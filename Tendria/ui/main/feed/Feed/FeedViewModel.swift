//
//  FeedViewModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 23.01.2025.
//

import Foundation
import SwiftUICore
import FirebaseFirestore

class FeedViewModel: BaseViewModel {
    
    @Published var questionList = questionTitles
    @Published var gameList     = gamesTitles
        
    @Published var showResumeAlert = false
    
    @Published var errorMessage: String?
    @Published var loading = false
    
    func checkOnlineGame(){
        
    }
    
    func createOnlineGame(selectedGame: QuestionType){
        getDataCall {
            try await RelationRepository.shared.getRelationId()
        } onSuccess: { relationId in
            self.createGame(relationId: relationId, selectedGame: selectedGame)
        } onLoading: {
            self.loading = true
        } onError: { error in
            self.errorMessage = error?.localizedDescription ?? ""
        }
        
        
    }
    func createGame(relationId: String, selectedGame: QuestionType){
        getDataCall {
            try await FirestorageManager.shared.createOnlineGame(selectedGame: selectedGame, relationId: relationId)
        } onSuccess: { success in
            print("Game created")
        } onLoading: {
            self.loading = true
        } onError: { error in
            self.errorMessage = error?.localizedDescription ?? ""
        }
    }
}
