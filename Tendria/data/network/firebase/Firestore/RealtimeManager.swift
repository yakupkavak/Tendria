//
//  RealtimeManager.swift
//  Tendria
//
//  Created by Yakup Kavak on 8.08.2025.
//

import Foundation
import FirebaseDatabaseInternal
import FirebaseCore

class RealtimeManager {
    
    static let shared = RealtimeManager()
    var ref: DatabaseReference!
    
    private init(){
        ref = Database.database().reference()
    }
    
    func createRealtimeGame(gameType: GameType) async{
        do {
            let relationId = try await RelationRepository.shared.getRelationId()
            let relationModel = try await FirestorageManager.shared.fetchUserRelationship(relationId: relationId)
            
            var payload: [String: Any] = ["userOneId": relationModel.firstUserId,
                                          "userOneImage": relationModel.firstUserImageUrl,
                                          "userOneName": relationModel.firstUserName,
                                          "userTwoId": relationModel.secondUserId ?? "",
                                          "userTwoImage": relationModel.secondUserImageUrl ?? "",
                                          "userTwoName": relationModel.secondUserName ?? "",
                                          "gameType": gameType.rawValue,
                                          "phase": GamePhase.creating.rawValue,
                                          "questionIds": Array(0...9).shuffled(),
                                          "currentIndex": 0,
                                          "relationId": relationId,
                                          "date": ServerValue.timestamp(),
                                          "userOneConnect": false,
                                          "userTwoConnect": false]
            try await self.ref.child(RealtimeConst.GAMES_PATH).childByAutoId().setValue(payload)
            
        }catch{
            print("Error creating realtime game: \(error.localizedDescription)")
        }
    }
    
}
extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
