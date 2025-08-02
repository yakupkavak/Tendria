//
//  GameModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 29.07.2025.
//

import FirebaseFirestore
import SwiftUICore

struct QuestionLocalModel: Identifiable{
    var id = UUID()
    var gameType: QuestionType
    var title: LocalizedStringKey
    var foregroundColor: Color
    var backgroundColor: Color
}

struct LocalQuestion{
    var gameType: QuestionType
    var questionId: Int
    var questionTitle: LocalizedStringKey
    var questionDescription: LocalizedStringKey
}

struct QuestionModel{
    @DocumentID var id: String?
    var gameType: QuestionType
    var relationId: String
}

struct Question{
    @DocumentID var id: String?
    var questionId: Int
    var userOneAnswer: String
    var userOneName: String
    var userTwoAnswer: String?
    var userTwoName: String?
    var date: Timestamp
}

enum QuestionType: String, Codable{
    case love
    case life
    case philosophy
    case firsts
    case dreams
    case trust
    case favorites
}

let lifeQuestionModels: [LocalQuestion] = [
    LocalQuestion(gameType: .life, questionId: 1, questionTitle: QuestionStringKeys.life_q1_title, questionDescription: QuestionStringKeys.life_q1_desc),
    LocalQuestion(gameType: .life, questionId: 2, questionTitle: QuestionStringKeys.life_q2_title, questionDescription: QuestionStringKeys.life_q2_desc),
    LocalQuestion(gameType: .life, questionId: 3, questionTitle: QuestionStringKeys.life_q3_title, questionDescription: QuestionStringKeys.life_q3_desc),
    LocalQuestion(gameType: .life, questionId: 4, questionTitle: QuestionStringKeys.life_q4_title, questionDescription: QuestionStringKeys.life_q4_desc),
    LocalQuestion(gameType: .life, questionId: 5, questionTitle: QuestionStringKeys.life_q5_title, questionDescription: QuestionStringKeys.life_q5_desc),
    LocalQuestion(gameType: .life, questionId: 6, questionTitle: QuestionStringKeys.life_q6_title, questionDescription: QuestionStringKeys.life_q6_desc),
    LocalQuestion(gameType: .life, questionId: 7, questionTitle: QuestionStringKeys.life_q7_title, questionDescription: QuestionStringKeys.life_q7_desc),
    LocalQuestion(gameType: .life, questionId: 8, questionTitle: QuestionStringKeys.life_q8_title, questionDescription: QuestionStringKeys.life_q8_desc),
    LocalQuestion(gameType: .life, questionId: 9, questionTitle: QuestionStringKeys.life_q9_title, questionDescription: QuestionStringKeys.life_q9_desc),
    LocalQuestion(gameType: .life, questionId: 10, questionTitle: QuestionStringKeys.life_q10_title, questionDescription: QuestionStringKeys.life_q10_desc)
]

let loveQuestionModels: [LocalQuestion] = [
    LocalQuestion(gameType: .love, questionId: 1, questionTitle: QuestionStringKeys.love_q1_title, questionDescription: QuestionStringKeys.love_q1_desc),
    LocalQuestion(gameType: .love, questionId: 2, questionTitle: QuestionStringKeys.love_q2_title, questionDescription: QuestionStringKeys.love_q2_desc),
    LocalQuestion(gameType: .love, questionId: 3, questionTitle: QuestionStringKeys.love_q3_title, questionDescription: QuestionStringKeys.love_q3_desc),
    LocalQuestion(gameType: .love, questionId: 4, questionTitle: QuestionStringKeys.love_q4_title, questionDescription: QuestionStringKeys.love_q4_desc),
    LocalQuestion(gameType: .love, questionId: 5, questionTitle: QuestionStringKeys.love_q5_title, questionDescription: QuestionStringKeys.love_q5_desc),
    LocalQuestion(gameType: .love, questionId: 6, questionTitle: QuestionStringKeys.love_q6_title, questionDescription: QuestionStringKeys.love_q6_desc),
    LocalQuestion(gameType: .love, questionId: 7, questionTitle: QuestionStringKeys.love_q7_title, questionDescription: QuestionStringKeys.love_q7_desc),
    LocalQuestion(gameType: .love, questionId: 8, questionTitle: QuestionStringKeys.love_q8_title, questionDescription: QuestionStringKeys.love_q8_desc),
    LocalQuestion(gameType: .love, questionId: 9, questionTitle: QuestionStringKeys.love_q9_title, questionDescription: QuestionStringKeys.love_q9_desc),
    LocalQuestion(gameType: .love, questionId: 10, questionTitle: QuestionStringKeys.love_q10_title, questionDescription: QuestionStringKeys.love_q10_desc)
]
let philosophyQuestionModels: [LocalQuestion] = [
    LocalQuestion(gameType: .philosophy, questionId: 1,  questionTitle: QuestionStringKeys.philosophy_q1_title,  questionDescription: QuestionStringKeys.philosophy_q1_desc),
    LocalQuestion(gameType: .philosophy, questionId: 2,  questionTitle: QuestionStringKeys.philosophy_q2_title,  questionDescription: QuestionStringKeys.philosophy_q2_desc),
    LocalQuestion(gameType: .philosophy, questionId: 3,  questionTitle: QuestionStringKeys.philosophy_q3_title,  questionDescription: QuestionStringKeys.philosophy_q3_desc),
    LocalQuestion(gameType: .philosophy, questionId: 4,  questionTitle: QuestionStringKeys.philosophy_q4_title,  questionDescription: QuestionStringKeys.philosophy_q4_desc),
    LocalQuestion(gameType: .philosophy, questionId: 5,  questionTitle: QuestionStringKeys.philosophy_q5_title,  questionDescription: QuestionStringKeys.philosophy_q5_desc),
    LocalQuestion(gameType: .philosophy, questionId: 6,  questionTitle: QuestionStringKeys.philosophy_q6_title,  questionDescription: QuestionStringKeys.philosophy_q6_desc),
    LocalQuestion(gameType: .philosophy, questionId: 7,  questionTitle: QuestionStringKeys.philosophy_q7_title,  questionDescription: QuestionStringKeys.philosophy_q7_desc),
    LocalQuestion(gameType: .philosophy, questionId: 8,  questionTitle: QuestionStringKeys.philosophy_q8_title,  questionDescription: QuestionStringKeys.philosophy_q8_desc),
    LocalQuestion(gameType: .philosophy, questionId: 9,  questionTitle: QuestionStringKeys.philosophy_q9_title,  questionDescription: QuestionStringKeys.philosophy_q9_desc),
    LocalQuestion(gameType: .philosophy, questionId: 10, questionTitle: QuestionStringKeys.philosophy_q10_title, questionDescription: QuestionStringKeys.philosophy_q10_desc)
]

let firstsQuestionModels: [LocalQuestion] = [
    LocalQuestion(gameType: .firsts, questionId: 1,  questionTitle: QuestionStringKeys.firsts_q1_title,  questionDescription: QuestionStringKeys.firsts_q1_desc),
    LocalQuestion(gameType: .firsts, questionId: 2,  questionTitle: QuestionStringKeys.firsts_q2_title,  questionDescription: QuestionStringKeys.firsts_q2_desc),
    LocalQuestion(gameType: .firsts, questionId: 3,  questionTitle: QuestionStringKeys.firsts_q3_title,  questionDescription: QuestionStringKeys.firsts_q3_desc),
    LocalQuestion(gameType: .firsts, questionId: 4,  questionTitle: QuestionStringKeys.firsts_q4_title,  questionDescription: QuestionStringKeys.firsts_q4_desc),
    LocalQuestion(gameType: .firsts, questionId: 5,  questionTitle: QuestionStringKeys.firsts_q5_title,  questionDescription: QuestionStringKeys.firsts_q5_desc),
    LocalQuestion(gameType: .firsts, questionId: 6,  questionTitle: QuestionStringKeys.firsts_q6_title,  questionDescription: QuestionStringKeys.firsts_q6_desc),
    LocalQuestion(gameType: .firsts, questionId: 7,  questionTitle: QuestionStringKeys.firsts_q7_title,  questionDescription: QuestionStringKeys.firsts_q7_desc),
    LocalQuestion(gameType: .firsts, questionId: 8,  questionTitle: QuestionStringKeys.firsts_q8_title,  questionDescription: QuestionStringKeys.firsts_q8_desc),
    LocalQuestion(gameType: .firsts, questionId: 9,  questionTitle: QuestionStringKeys.firsts_q9_title,  questionDescription: QuestionStringKeys.firsts_q9_desc),
    LocalQuestion(gameType: .firsts, questionId: 10, questionTitle: QuestionStringKeys.firsts_q10_title, questionDescription: QuestionStringKeys.firsts_q10_desc)
]

let dreamsQuestionModels: [LocalQuestion] = [
    LocalQuestion(gameType: .dreams, questionId: 1,  questionTitle: QuestionStringKeys.dreams_q1_title,  questionDescription: QuestionStringKeys.dreams_q1_desc),
    LocalQuestion(gameType: .dreams, questionId: 2,  questionTitle: QuestionStringKeys.dreams_q2_title,  questionDescription: QuestionStringKeys.dreams_q2_desc),
    LocalQuestion(gameType: .dreams, questionId: 3,  questionTitle: QuestionStringKeys.dreams_q3_title,  questionDescription: QuestionStringKeys.dreams_q3_desc),
    LocalQuestion(gameType: .dreams, questionId: 4,  questionTitle: QuestionStringKeys.dreams_q4_title,  questionDescription: QuestionStringKeys.dreams_q4_desc),
    LocalQuestion(gameType: .dreams, questionId: 5,  questionTitle: QuestionStringKeys.dreams_q5_title,  questionDescription: QuestionStringKeys.dreams_q5_desc),
    LocalQuestion(gameType: .dreams, questionId: 6,  questionTitle: QuestionStringKeys.dreams_q6_title,  questionDescription: QuestionStringKeys.dreams_q6_desc),
    LocalQuestion(gameType: .dreams, questionId: 7,  questionTitle: QuestionStringKeys.dreams_q7_title,  questionDescription: QuestionStringKeys.dreams_q7_desc),
    LocalQuestion(gameType: .dreams, questionId: 8,  questionTitle: QuestionStringKeys.dreams_q8_title,  questionDescription: QuestionStringKeys.dreams_q8_desc),
    LocalQuestion(gameType: .dreams, questionId: 9,  questionTitle: QuestionStringKeys.dreams_q9_title,  questionDescription: QuestionStringKeys.dreams_q9_desc),
    LocalQuestion(gameType: .dreams, questionId: 10, questionTitle: QuestionStringKeys.dreams_q10_title, questionDescription: QuestionStringKeys.dreams_q10_desc)
]

let trustQuestionModels: [LocalQuestion] = [
    LocalQuestion(gameType: .trust, questionId: 1,  questionTitle: QuestionStringKeys.trust_q1_title,  questionDescription: QuestionStringKeys.trust_q1_desc),
    LocalQuestion(gameType: .trust, questionId: 2,  questionTitle: QuestionStringKeys.trust_q2_title,  questionDescription: QuestionStringKeys.trust_q2_desc),
    LocalQuestion(gameType: .trust, questionId: 3,  questionTitle: QuestionStringKeys.trust_q3_title,  questionDescription: QuestionStringKeys.trust_q3_desc),
    LocalQuestion(gameType: .trust, questionId: 4,  questionTitle: QuestionStringKeys.trust_q4_title,  questionDescription: QuestionStringKeys.trust_q4_desc),
    LocalQuestion(gameType: .trust, questionId: 5,  questionTitle: QuestionStringKeys.trust_q5_title,  questionDescription: QuestionStringKeys.trust_q5_desc),
    LocalQuestion(gameType: .trust, questionId: 6,  questionTitle: QuestionStringKeys.trust_q6_title,  questionDescription: QuestionStringKeys.trust_q6_desc),
    LocalQuestion(gameType: .trust, questionId: 7,  questionTitle: QuestionStringKeys.trust_q7_title,  questionDescription: QuestionStringKeys.trust_q7_desc),
    LocalQuestion(gameType: .trust, questionId: 8,  questionTitle: QuestionStringKeys.trust_q8_title,  questionDescription: QuestionStringKeys.trust_q8_desc),
    LocalQuestion(gameType: .trust, questionId: 9,  questionTitle: QuestionStringKeys.trust_q9_title,  questionDescription: QuestionStringKeys.trust_q9_desc),
    LocalQuestion(gameType: .trust, questionId: 10, questionTitle: QuestionStringKeys.trust_q10_title, questionDescription: QuestionStringKeys.trust_q10_desc)
]

let favoritesQuestionModels: [LocalQuestion] = [
    LocalQuestion(gameType: .favorites, questionId: 1,  questionTitle: QuestionStringKeys.favorites_q1_title,  questionDescription: QuestionStringKeys.favorites_q1_desc),
    LocalQuestion(gameType: .favorites, questionId: 2,  questionTitle: QuestionStringKeys.favorites_q2_title,  questionDescription: QuestionStringKeys.favorites_q2_desc),
    LocalQuestion(gameType: .favorites, questionId: 3,  questionTitle: QuestionStringKeys.favorites_q3_title,  questionDescription: QuestionStringKeys.favorites_q3_desc),
    LocalQuestion(gameType: .favorites, questionId: 4,  questionTitle: QuestionStringKeys.favorites_q4_title,  questionDescription: QuestionStringKeys.favorites_q4_desc),
    LocalQuestion(gameType: .favorites, questionId: 5,  questionTitle: QuestionStringKeys.favorites_q5_title,  questionDescription: QuestionStringKeys.favorites_q5_desc),
    LocalQuestion(gameType: .favorites, questionId: 6,  questionTitle: QuestionStringKeys.favorites_q6_title,  questionDescription: QuestionStringKeys.favorites_q6_desc),
    LocalQuestion(gameType: .favorites, questionId: 7,  questionTitle: QuestionStringKeys.favorites_q7_title,  questionDescription: QuestionStringKeys.favorites_q7_desc),
    LocalQuestion(gameType: .favorites, questionId: 8,  questionTitle: QuestionStringKeys.favorites_q8_title,  questionDescription: QuestionStringKeys.favorites_q8_desc),
    LocalQuestion(gameType: .favorites, questionId: 9,  questionTitle: QuestionStringKeys.favorites_q9_title,  questionDescription: QuestionStringKeys.favorites_q9_desc),
    LocalQuestion(gameType: .favorites, questionId: 10, questionTitle: QuestionStringKeys.favorites_q10_title, questionDescription: QuestionStringKeys.favorites_q10_desc)
]
