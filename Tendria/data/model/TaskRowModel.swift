//
//  TaskRowModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 4.02.2025.
//

import Foundation
import FirebaseFirestore

struct TaskRowModel: Identifiable{
    @DocumentID var id: String? //Firebaseden çekilmezse id gelmiyor.
    var imageUrl: String
    var subText: String
    var wrappedId: String {
        id ?? UUID().uuidString  // ✅ Eğer Firestore'dan gelen id nil ise UUID kullan
    }
}
