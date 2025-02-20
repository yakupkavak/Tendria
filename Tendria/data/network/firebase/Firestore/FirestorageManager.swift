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
        addDocument(documentRef: newListRef, value: newDocument)
    }
    
    private func addDocument<T: Encodable>(documentRef: DocumentReference, value: T) {
        do {
            try documentRef.setData(from: value)
            print("Document added successfully")
        } catch {
            print("Failed to add document: \(error.localizedDescription)")
        }
    }
    
    func generateConnectionCode() async throws{
        let randomCode = randomString(length: Numbers.RANDOM_COUNT)
        print(randomCode)
        let newCodeRef = database.collection(FireDatabase.RELATION_CODE_PATH).document()
        guard let currentUserId = AuthManager.shared.getUserID() else {
            return
        }
        let newDocument = RelationCodeModel(firstUserId: currentUserId, secondUserId: nil, relationCode: randomCode)
        addDocument(documentRef: newCodeRef, value: newDocument)
    }
    
    func checkUserRelation() async throws -> Bool {
        guard let userId = AuthManager.shared.getUserID() else {
            return false
        }
        let documentReference = database.collection(FireDatabase.USER_PATH).document(userId)
        
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
