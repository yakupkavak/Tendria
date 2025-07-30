//
//  GameModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 29.07.2025.
//

import FirebaseFirestore
import SwiftUICore

struct GameLocalModel: Identifiable{
    var id = UUID()
    var gameType: GameType
    var title: LocalizedStringKey
    var foregroundColor: Color
    var backgroundColor: Color
}

struct LocalQuestion{
    var gameType: GameType
    var questionId: Int
    var questionTitle: LocalizedStringKey
    var questionDescription: LocalizedStringKey
}

struct GameModel{
    @DocumentID var id: String?
    var gameType: GameType
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

enum GameType: String, Codable{
    case love
    case life
    case philosophy
    case firsts
    case dreams
    case trust
    case whatIf
    case favorites
}
