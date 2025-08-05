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
    var date: Timestamp
    var firstName: String
    var firstImage: String
    var secondName: String
    var secondImage: String
}

struct OnlineAnswer {
    @DocumentID var id: String?
    var questionId: Int
    var firstAnswer: String
    var secondAnswer: String
}

enum GameExist {
    /// Hâlihazırda aktif bir oturum bulundu
    case existing(OnlineQuestionModel)
    /// Yeni oturum başarılı şekilde oluşturuldu
    case created(OnlineQuestionModel)
    /// (Opsiyonel) Beklenmedik hata
    case failure(Error)
}

enum GamePhase:  String, Codable { case answering, review, finished, canceled }
