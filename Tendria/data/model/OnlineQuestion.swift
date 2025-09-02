//
//  AnswerQuestion.swift
//  Tendria
//
//  Created by Yakup Kavak on 5.08.2025.
//

import Foundation
import FirebaseFirestore

struct OnlineQuestionModel {
    @DocumentID var id: String?
    var relationId: String
    var questionType: QuestionType
    var questions: [Int]
    var currentIndex: Int
    var phase: GamePhase
    var date: [AnyHashable : Any]
    var firstName: String?
    var firstImage: String?
    var secondName: String?
    var secondImage: String?
    var firstUserActive: Bool?
    var secondUserActive: Bool?
    var firstUserId: String
    var secondUserId: String
}

struct OnlineAnswer {
    @DocumentID var id: String?
    var questionId: Int
    var firstAnswer: String
    var secondAnswer: String
}

enum GameExist {
    case existing(OnlineQuestionModel)   // Yarım kalan oyun bulundu
    case created(OnlineQuestionModel)    // Yeni oturum açıldı
    case failure(Error)
}

enum GamePhase:  String, Codable { case answering,
                                        review,
                                        finished,
                                        canceled,
                                        waiting,
                                        creating}
