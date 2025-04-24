//
//  FirestoreManager.swift
//  Tendria
//
//  Created by Yakup Kavak on 10.02.2025.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseFunctions
import FirebaseMessaging

class FirestorageManager {
    
    static let shared = FirestorageManager()
    private let storage = Storage.storage()
    private let functions = Functions.functions()
    private let database = Firestore.firestore()
    let storageRef: StorageReference
    let memoryRef: StorageReference
    let collectionRef: StorageReference
    
    private init() {
        self.storageRef = storage.reference()
        self.memoryRef = storageRef.child(FireStorage.MEMORY_PATH)
        self.collectionRef = storageRef.child(FireStorage.COLLECTION_PATH)
    }
    
    func addCollectionImage(imageData: Data) async throws -> String {
        let uniqueFileName = UUID().uuidString + ".jpg"
        let listImageRef = collectionRef.child("\(uniqueFileName)")
        
        do {
            let uploadTask = try await listImageRef.putDataAsync(imageData){ progress in
                print("Upload progress: \(progress?.fractionCompleted ?? 0)")
            }
            let uploadUrl = try await listImageRef.downloadURL()
            print("Upload successful, metadata: \(uploadTask)")
            return uploadUrl.absoluteString
        }
        catch {
            print("Upload failed: \(error.localizedDescription)")
            throw error
        }
    }
    
    func addMemoryImages(imageDatas: [Data]) async throws -> [String] {
        return try await withThrowingTaskGroup(of: String.self) { group in
            for image in imageDatas {
                group.addTask {
                    let uniqueFileName = UUID().uuidString + ".jpg"
                    let listImageRef = self.memoryRef.child("\(uniqueFileName)")
                    let uploadTask = try await listImageRef.putDataAsync(image){ progress in
                        print("Upload progress: \(progress?.fractionCompleted ?? 0)")
                    }
                    let uploadUrl = try await listImageRef.downloadURL()
                    print("Upload successful, metadata: \(uploadTask)")
                    return uploadUrl.absoluteString
                }
            }
            var returnList = [String]()
            
            for try await imageUrl in group {
                returnList.append(imageUrl)
            }
            
            return returnList
        }
    }
    
    func addMemoryDocument(memoryDocumentModel: MemoryDocumentModel) async throws{
        let newListRef = database.collection(FireDatabase.MEMORY_PATH).document()
        try await addDocument(documentRef: newListRef, value: memoryDocumentModel)
    }
    
    func addCollectionDocument(collectionDocumentModel: CollectionDocumentModel) async throws{
        let newListRef = database.collection(FireDatabase.COLLECTION_PATH).document()
        try await addDocument(documentRef: newListRef, value: collectionDocumentModel)
    }
    
    private func addDocument<T: Encodable>(documentRef: DocumentReference, value: T) async throws {
        do {
            try documentRef.setData(from: value)
            print("Document added successfully")
        } catch {
            print("Failed to add document: \(error.localizedDescription)")
            throw error
        }
    }
    
    func generateConnectionCode() async throws -> String?{
        let randomCode = randomString(length: Numbers.RANDOM_COUNT)
        let relationCodeRef = database.collection(FireDatabase.RELATION_CODE_PATH).document()
        guard let currentUserId = AuthManager.shared.getUserID() else {
            return nil
        }
        let newDocument = RelationCodeModel(firstUserId: currentUserId, secondUserId: nil, relationCode: randomCode, createDate: Timestamp(date: Date()))
        try await addDocument(documentRef: relationCodeRef, value: newDocument)
        return randomCode
    }
    
    func checkAndAddRelation(relationCode: String) async throws -> String {
        let data = ["relationCode": relationCode]
        do {
            let result = try await functions.httpsCallable(FunctionName.CHECK_AND_ADD_RELATION).call(data)
            if let response = result.data as? [String: Any],
               let relationshipId = response["relationshipId"] as? String {
                return relationshipId
            } else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No relationship ID found."])
            }
        } catch let error as NSError {
            if let firebaseError = error.userInfo[FunctionsErrorDetailsKey] as? [String: Any],
               let message = firebaseError["message"] as? String {
                print("Cloud Function Error: \(message)")
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: message])
            } else {
                print("Error calling function: \(error.localizedDescription)")
                throw error
            }
        }
    }
    
    func configureFcmToken(){
        guard let userMail = AuthManager.shared.getUserMail() else { return }
        
        Messaging.messaging().token(){token,error in
            if let fcmToken = token{
                let userKey = userMail + KeychainKeys.FCM_TOKEN
                let storedToken = KeychainHelper.shared.getToken(key: userKey)
                if(storedToken == fcmToken){
                    print("key aynı kaydedilmedi")
                }else{
                    let userKey = userMail + KeychainKeys.FCM_TOKEN
                    KeychainHelper.shared.saveToken(fcmToken, key: userKey)
                    self.saveTokenToFirestore(token: fcmToken)
                    print("key kaydedildi")
                }
            }
            if let error = error{
                print("error ->", error.localizedDescription)
            }
        }
    }
    
    func configureUserLanguage(userID: String,preferLanguage: String? = nil){
        guard let preferLanguage = preferLanguage else {
            //DEFAULT USERS LANGUAGE
            let userLanguage = Locale.current.language.languageCode?.identifier ?? "en"
            setDataToUser(data: userLanguage, path: FireDatabase.USER_LANGUAGE)
            return
        }
        setDataToUser(data: preferLanguage, path: FireDatabase.USER_LANGUAGE)
    }
    
    func saveTokenToFirestore(token: String) {
        setDataToUser(data: token,path: FireDatabase.FCM_TOKEN_FIELD)
    }
    
    private func setDataToUser(data: String,path: String){
        guard let userID = AuthManager.shared.getUserID() else {
            print("No user is logged in. Token not saved.")
            return
        }
        let userRef = database.collection(FireDatabase.USERS_PATH).document(userID)
        userRef.setData([path: data], merge: true) { error in
            if let error = error {
                print("Error saving data to Firestore: \(error.localizedDescription)")
            } else {
                print("\(data) successfully saved to Firestore!")
            }
        }
    }
    
    func checkUserRelation() async throws -> Bool {
        guard let userId = AuthManager.shared.getUserID() else {
            return false
        }
        let documentReference = database.collection(FireDatabase.USERS_PATH).document(userId)
        
        do {
            let document = try await documentReference.getDocument()
            if document.exists {
                let relationId = document.data()?[FireDatabase.RELATION_ID] as? String
                print(document)
                return !(relationId?.isEmpty ?? true)
            }else {
                return false
            }
        } catch {
            throw error
        }
    }
    
    func fetchCollectionList() async throws -> IsCollectionExist {
        guard let relationId = try await RelationRepository.shared.getRelationId() else {
            return IsCollectionExist.noneRelation
        }
        let documentReference = database.collection(FireDatabase.COLLECTION_PATH)
        do {
            let querySnapshot = try await documentReference.whereField(FireDatabase.RELATION_ID, isEqualTo: relationId).getDocuments()
            if(querySnapshot.documents.count == 0){
                return IsCollectionExist.nonExist
            }
            var documentList: [CollectionFetchModel] = []
            for document in querySnapshot.documents{
                let data = try document.data(as: CollectionFetchModel.self)
                let collectionModel = CollectionFetchModel(id: data.id, imageUrl: data.imageUrl, title: data.title, relationId: data.relationId, userOneDescription: data.userOneDescription, userTwoDescription: data.userTwoDescription, userOneImage: data.userOneImage, userTwoImage: data.userTwoImage, createDate: data.createDate)
                documentList.append(collectionModel)
            }
            return IsCollectionExist.exist(documentList)
        }catch {
            throw error
        }
    }
    
    func fetchMemoryList(collectionId: String) async throws -> FetchDataList<MemoryFetchModel> {
        guard let relationId = try await RelationRepository.shared.getRelationId() else {
            throw RelationError.invalidUserRelation
        }
        let documentReference = database.collection(FireDatabase.MEMORY_PATH)
        do {
            let querySnapshot = try await documentReference.whereField(FireDatabase.COLLECTION_ID, isEqualTo: collectionId).getDocuments()
            if(querySnapshot.documents.count == 0){
                return FetchDataList.nonExist
            }
            var documentList: [MemoryFetchModel] = []
            for document in querySnapshot.documents{
                let data = try document.data(as: MemoryFetchModel.self)
                let memoryModel = MemoryFetchModel(id: data.id, imageUrl: data.imageUrl, title: data.title, userOneDescription: data.userOneDescription, userTwoDescription: data.userTwoDescription, userOneImage: data.userOneImage, userTwoImage: data.userTwoImage, createDate: data.createDate)
                documentList.append(memoryModel)
            }
            return FetchDataList.exist(documentList)
        }catch {
            throw error
        }
    }
    
    //IT ADDED ON CLOUD FUNCTION
    /*
     func checkRelationCode(relationCode: String) async throws {
     let relationCodeRef = database.collection(FireDatabase.RELATION_CODE_PATH)
     do {
     let querySnapshot = try await relationCodeRef.whereField("relationCode", isEqualTo: relationCode).getDocuments()
     if querySnapshot.documents.count > 1 {
     throw RelationError.duplicateCode
     }
     for document in querySnapshot.documents {
     let data = try document.data(as: RelationCodeModel.self)
     try await addRelationToUser(relationCode: data)
     }
     } catch {
     throw error
     }
     }
     
     func addRelationToUser(relationCode: RelationCodeModel) async throws {
     let relationshipRef = database.collection(FireDatabase.RELATIONSHIP_PATH).document()
     guard let firstUserId = relationCode.firstUserId else {
     throw RelationError.invalidUserId
     }
     guard let secondUserId = AuthManager.shared.getUserID() else {
     throw RelationError.invalidUserId
     }
     do {
     let newRelationDocument = RelationshipModel(firstUserId: firstUserId, secondUserId: secondUserId, createDate: Timestamp(date: Date()))
     try addDocument(documentRef: relationshipRef, value: newRelationDocument)
     }catch {
     throw error
     }
     }
     */

}
