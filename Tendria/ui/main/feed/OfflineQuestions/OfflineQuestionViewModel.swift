//
//  QuestionViewModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 30.07.2025.
//

import Foundation
import Combine
import SwiftUICore

class QuestionViewModel: BaseViewModel{
    var lastQuestionNumber = 10
    @Published var timeRemaining = 30
    @Published var questionNumber = 1{
        didSet {
            updateProgress()
        }
    }
    @Published var questionProgress = 0.1
    @Published var questionTitle: LocalizedStringKey = StringKey.empty
    @Published var questionDescription: LocalizedStringKey = StringKey.empty
    @Published var isTimeOver = false
    @Published var currentQuestionId: Int = 1
    @Published var questionList: [LocalQuestion] = [LocalQuestion]()
    @Published var error: Error?
    var questionType: QuestionType
    private var repeatTimer = true
    
    private var timer = Timer()
    
    init(timeRemaining: Int = 30,questionType: QuestionType ,questionNumber: Int = 1, questionProgress: Double = 0.1, timer: Timer = Timer()) {
        self.timeRemaining = timeRemaining
        self.questionNumber = questionNumber
        self.questionProgress = questionProgress
        self.timer = timer
        self.questionType = questionType
        super.init()
        self.enableTimer()
        getQuestions(questionType: questionType)
    }
    
    private func getQuestions(questionType: QuestionType){
        switch questionType{
            case .dreams:
                initalizeList(list: dreamsQuestionModels)
            case .favorites:
                initalizeList(list: favoritesQuestionModels)
            case .firsts:
                initalizeList(list: firstsQuestionModels)
            case .life:
                initalizeList(list: lifeQuestionModels)
            case .love:
                initalizeList(list: loveQuestionModels)
            case .philosophy:
                initalizeList(list: philosophyQuestionModels)
            case .trust:
                initalizeList(list: trustQuestionModels)
        }
    }
    
    private func initalizeList(list: [LocalQuestion]){
        let randomIdList = getRandomNumberArray(startIndex: 1, endIndex: 10, numberCount: 10)
        guard let randomIdList else { error = RelationError.unknown ; return }
        for (index, randomId) in randomIdList.enumerated(){
            questionList.append(trustQuestionModels[randomId])
        }
    }
    
    private func getRandomNumberArray(startIndex: Int, endIndex: Int, numberCount: Int) -> [Int]?{
        if(endIndex - startIndex < numberCount) {
            return nil
        }
        var returnList = [Int]()
        var errorCheck = 0
        var errorLimit = numberCount * 2
        
        for i in 1...numberCount{
            var newNumber = Int.random(in: startIndex...endIndex)
            while returnList.contains(newNumber){
                newNumber = Int.random(in: startIndex...endIndex)
                if(errorCheck == errorLimit){
                    return nil
                }
                errorCheck += 1
            }
            errorCheck = 0
            returnList.append(newNumber)
        }
        return returnList
    }
    
    func enableTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: repeatTimer, block: { _ in
            DispatchQueue.main.async { [weak self] in
                if(self?.timeRemaining != 0){
                    self?.timeRemaining -= 1
                }else {
                    self?.isTimeOver = true
                    self?.repeatTimer = false
                }
            }
        })
    }
    
    func nextQuestion() {
        if(questionNumber == lastQuestionNumber){
            endGame()
        }else {
            questionNumber += 1
            timeRemaining = 30
            repeatTimer = true
            isTimeOver = false
        }
    }
    func endGame(){
        
    }
    
    private func updateProgress() {
        questionProgress = Double(questionNumber) / 10.0
    }
}
