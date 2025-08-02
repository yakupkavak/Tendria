//
//  FeedViewModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 23.01.2025.
//

import Foundation
import SwiftUICore

class FeedViewModel: BaseViewModel{
    @Published var questionList = questionTitles
    @Published var gameList = gamesTitles

}
