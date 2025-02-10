//
//  FirestoreManager.swift
//  Tendria
//
//  Created by Yakup Kavak on 10.02.2025.
//

import Foundation
import FirebaseStorage

class FirestorageManager {
    
    static let shared = FirestorageManager()
    private let storage = Storage.storage()
    let storageRef: StorageReference
    let taskRef: StorageReference
    let listRef: StorageReference

    private init() {
        self.storageRef = storage.reference()
        self.taskRef = storageRef.child("task")
        self.listRef = storageRef.child("list")
    }

    func addList(imageData: Data) async throws{
        let uniqueFileName = UUID().uuidString + ".jpg"
        let listImageRef = listRef.child("\(uniqueFileName)")
        
        do {
            let uploadTask = try await listImageRef.putDataAsync(imageData){ progress in
                print("Upload progress: \(progress?.fractionCompleted ?? 0)")
            }
            print("Upload successful, metadata: \(uploadTask)")
        }
        catch{
            print("Upload failed: \(error.localizedDescription)")

        }
    }
}
