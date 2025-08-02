//
//  FeedUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 23.01.2025.
//

import SwiftUI

struct FeedUI: View {
    @EnvironmentObject var routerFeed: RouterFeed
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView{
                // Subjects bölümü
                SubjectsView(title: QuestionStringKeys.questions_title, description: QuestionStringKeys.questions_description).frame(maxWidth: .infinity,alignment: .leading)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 16){
                        ForEach(viewModel.questionList){ question in
                            FeedRowUI(foregroundColor: question.foregroundColor, backgroundColor: question.backgroundColor, title: Text(question.title)).frame(width: Width.screenFourtyTwoWidth)
                        }
                    }
                }.padding(.bottom)
                // Games bölümü
                SubjectsView(title: GamesStringKeys.games_title, description: GamesStringKeys.games_description).frame(maxWidth: .infinity,alignment: .leading)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 16){
                        ForEach(viewModel.gameList){ game in
                            FeedRowUI(foregroundColor: game.foregroundColor, backgroundColor: game.backgroundColor, title: Text(game.title)).frame(width: Width.screenFourtyTwoWidth)
                        }
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(.leading,16).padding(.top).background(Color.white).clipShape(RoundedTopLeftShape(radius: 70)).padding(.top,190)
        }.ignoresSafeArea().background(Color.feedBackground)
    }
}

struct SubjectsView: View {
    var title: LocalizedStringKey
    var description: LocalizedStringKey
    
    var body: some View {
        VStack(alignment: .leading){
            tvTitle(text: title, color: .blue)
            tvBodyline(text: description, color: .gray).truncationMode(.head)
        }
    }
}

#Preview {
    FeedUI()
}

