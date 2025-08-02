//
//  QuestionUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 30.07.2025.
//

import SwiftUI

struct QuestionUI: View {
    var questionType: QuestionType
    @StateObject var viewModel: QuestionViewModel
    
    init(questionType: QuestionType) {
        self.questionType = questionType
        _viewModel = StateObject(wrappedValue: QuestionViewModel(questionType: questionType))
    }
    
    var body: some View {
        VStack{
            HStack{
                btnSystemIconTransparent(iconSystemName: Icons.left_direction, color: Color.black) {
                    //isAddMemoryPresented = false
                }
                Spacer()
                tvBodylineString(text: String(format: NSLocalizedString("question_number", comment: ""), viewModel.questionNumber), color: .black)
                Spacer()
                btnSystemIconTransparent(iconSystemName: "ellipsis.circle", color: .black) {
                    viewModel.nextQuestion()
                }
            }
            //Timer
            ProgressView(value: viewModel.questionProgress).padding(.top).tint(.orange500).scaleEffect(x: 1,y: 2, anchor: .center)
            //Think about 30 seconds. Make it customize in the future
            
            tvBodylineString(text: "\(viewModel.timeRemaining)", color: .black).padding(.top)
            tvBodyline(text: viewModel.isTimeOver ? QuestionStringKeys.answer_question : QuestionStringKeys.think_question, color: .gray)
            
            Spacer()
            
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.gray)
                    .overlay {
                        tvBodylineString(text: viewModel.questionTitle, color: .black)
                    }
                    .frame(width: 200,height: 100)
                    .background(Color.clear).offset(y:-125)
                    .zIndex(2.0)
                
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.orange)
                    .padding(.horizontal, 32)
                    .frame(maxWidth: .infinity,maxHeight: 250)
                    .background(Color.clear)
                    .zIndex(1.9)
                    .overlay {
                        Text("kavak")
                    }
            }.padding(.top, -16)
            Spacer()
            btnTextGradientInfinity(action: {
                viewModel.nextQuestion()
            }, text: viewModel.questionNumber == viewModel.lastQuestionNumber ? QuestionStringKeys.finish : QuestionStringKeys.next)
            //next 5 saniye sonra açılsın en erken
        }.padding()
    }
}

#Preview {
    QuestionUI(questionType: .dreams)
}
