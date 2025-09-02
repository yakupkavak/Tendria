//
//  RelationRepository.swift
//  Tendria
//
//  Created by Yakup Kavak on 29.03.2025.
//

import Foundation
import FirebaseFirestore

class RelationRepository{
    
    private let database = Firestore.firestore()
    static let shared = RelationRepository()
    var relationId: String?
    
    private init(){
    }
    
    func getPartnerModel(userId: String) async throws -> PartnerModel {
        
        if let partnerId = UserDefaults.standard.string(forKey: UserDefaultsKeys.getPartnerId(userID: userId)){
            if let partnerImage = UserDefaults.standard.string(forKey: UserDefaultsKeys.getPartnerImage(userID: userId)) {
                return PartnerModel(partnerId: partnerId, partnerImageUrl: partnerImage, partnerName: "")
            }
        }
        
        Task{
            
        }
        return PartnerModel(partnerId: "", partnerImageUrl: "", partnerName: "")
    }
    
    func getRelationId() async throws -> String {
        if let userId = AuthManager.shared.getUserID(){
            if let cachedRelationId = UserDefaults.standard.string(forKey: UserDefaultsKeys.getRelationId(userID: userId)) {
                return cachedRelationId
            }
            let documentReference = database.collection(FireDatabase.USERS_PATH).document(userId)
            do {
                let document = try await documentReference.getDocument()
                if document.exists {
                    let userRelationId = document.data()?[FireDatabase.RELATION_ID] as? String
                    guard let userRelationId else {
                        throw RelationError.invalidUserRelation
                    }
                    UserDefaults.standard.set(UserDefaultsKeys.relationId, forKey: userRelationId)
                    return userRelationId
                }else {
                    throw RelationError.invalidUserRelation
                }
            } catch {
                throw RelationError.invalidUserRelation
            }
        }
        throw RelationError.invalidUserRelation
    }
}
