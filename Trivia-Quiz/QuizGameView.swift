//
//  QuizGameView.swift
//  Trivia-Quiz
//
//  Created by Tomasz Lizer on 17/01/2025.
//

import SwiftUI

struct QuizGameView: View {
    
    @EnvironmentObject var game: QuizGame
    
    var body: some View {
        switch game.state {
        case .idle:
            startGameView
        case .loading:
            loadingView
        }
    }
    
    private var startGameView: some View {
        Button("Start game") {
            Task {
                await game.start()
            }
        }
    }
    
    private var loadingView: some View {
        ProgressView()
    }
}
