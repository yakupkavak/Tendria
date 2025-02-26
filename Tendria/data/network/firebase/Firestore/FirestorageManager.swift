//
//  FirestoreManager.swift
//  Tendria
//
//  Created by Yakup Kavak on 10.02.2025.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore

class FirestorageManager {
    
    static let shared = FirestorageManager()
    private let storage = Storage.storage()
    private let database = Firestore.firestore()
    let storageRef: StorageReference
    let taskRef: StorageReference
    let listRef: StorageReference
    
    private init() {
        self.storageRef = storage.reference()
        self.taskRef = storageRef.child(FireStorage.TASK_PATH)
        self.listRef = storageRef.child(FireStorage.LIST_PATH)
    }
    
    func addListImage(imageData: Data) async throws -> String {
        let uniqueFileName = UUID().uuidString + ".jpg"
        let listImageRef = listRef.child("\(uniqueFileName)")
        
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
    
    func addListDocument(downloadUrl: String,description: String) async throws{
        let newListRef = database.collection(FireDatabase.LIST_PATH).document()
        let newDocument = ListDocumentModel(
                imageUrl: downloadUrl,
                relationId: "23232",
                taskIdList: nil,
                description: description
            )
        try addDocument(documentRef: newListRef, value: newDocument)
    }
    
    private func addDocument<T: Encodable>(documentRef: DocumentReference, value: T) throws {
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
        let newDocument = RelationCodeModel(firstUserId: currentUserId, secondUserId: nil, relationCode: randomCode)
        try addDocument(documentRef: relationCodeRef, value: newDocument)
        return randomCode
    }
    
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
    
    func checkUserRelation() async throws -> Bool {
        guard let userId = AuthManager.shared.getUserID() else {
            return false
        }
        let documentReference = database.collection(FireDatabase.USERS_PATH).document(userId)
        
        do {
            let document = try await documentReference.getDocument()
            if document.exists {
                let relationId = document.data()?[FireDatabase.USER_RELATION_ID] as? String
                return !(relationId?.isEmpty ?? true)
            }else {
                return false
            }
        } catch {
            throw error
        }
    }
    
}
