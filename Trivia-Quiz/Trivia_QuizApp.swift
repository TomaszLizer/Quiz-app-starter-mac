//
//  Trivia_QuizApp.swift
//  Trivia-Quiz
//
//  Created by Tomasz Lizer on 17/01/2025.
//

import SwiftUI

@main
struct Trivia_QuizApp: App {
    
    var body: some Scene {
        WindowGroup {
            let api = QuizApi()
            let game = QuizGame(api: api)
            QuizGameView()
                .environmentObject(game)
        }
    }
}
