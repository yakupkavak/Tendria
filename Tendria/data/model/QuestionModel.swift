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
    case whatIf
    case favorites
}
