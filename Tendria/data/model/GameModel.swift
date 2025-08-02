//
//  GameModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 30.07.2025.
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

struct GameQuestion{
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

struct Game{
    @DocumentID var id: String?
    var questionId: Int
    var userOneAnswer: String
    var userOneName: String
    var userTwoAnswer: String?
    var userTwoName: String?
    var date: Timestamp
}

struct StoryGame{
    @DocumentID var id: String?
    var questionId: Int
    var questionText: String?
    var userOneAnswer: String
    var userOneName: String
    var userTwoAnswer: String?
    var userTwoName: String?
    var date: Timestamp
}

enum GameType: String, Codable{
    case story
    case truthLie
    case whatIf
    case memory
}

enum StoryType: String, Codable{
    case ancientRome
    case vikings
    case dragons
    case egypt
    case mesopotamia
    case animalsTalk
    case superPower
    case vampire
    case avatar
    case dreams
}
