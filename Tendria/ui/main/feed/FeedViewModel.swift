//
//  FeedViewModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 23.01.2025.
//

import Foundation
import SwiftUICore

class FeedViewModel: BaseViewModel{
    @Published var gameList = gameTitles
}

let gameTitles: [QuestionLocalModel] = [
    QuestionLocalModel(
        gameType: .love,
        title: QuestionStringKeys.love_title,
        foregroundColor: Color(hex: "#F2AEAE"),
        backgroundColor: Color(hex: "#D95FA2")
    ),
    QuestionLocalModel(
        gameType: .life,
        title: QuestionStringKeys.life_title,
        foregroundColor: Color(hex: "#607EA6"),
        backgroundColor: Color(hex: "#253759")
    ),
    QuestionLocalModel(
        gameType: .philosophy,
        title: QuestionStringKeys.philosophy_title,
        foregroundColor: Color(hex: "#A8BF56"),
        backgroundColor: Color(hex: "#658C6F")
    ),
    QuestionLocalModel(
        gameType: .firsts,
        title: QuestionStringKeys.firsts_title,
        foregroundColor: Color(hex: "#BF8A49"),
        backgroundColor: Color(hex: "#252617")
    ),
    QuestionLocalModel(
        gameType: .dreams,
        title: QuestionStringKeys.dreams_title,
        foregroundColor: Color(hex: "#735A8C"),
        backgroundColor: Color(hex: "#161C40")
    ),
    QuestionLocalModel(
        gameType: .trust,
        title: QuestionStringKeys.trust_title,
        foregroundColor: Color(hex: "#A66B49"),
        backgroundColor: Color(hex: "#457362")
    ),
    QuestionLocalModel(
        gameType: .whatIf,
        title: QuestionStringKeys.whatIf_title,
        foregroundColor: Color(hex: "#023059"),
        backgroundColor: Color(hex: "#BF8034")
    ),
    QuestionLocalModel(
        gameType: .favorites,
        title: QuestionStringKeys.favorites_title,
        foregroundColor: Color(hex: "#F25270"),
        backgroundColor: Color(hex: "#034AA6")
    )
]
