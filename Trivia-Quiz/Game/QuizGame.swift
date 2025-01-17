//
//  QuizGame.swift
//  Trivia-Quiz
//
//  Created by Tomasz Lizer on 17/01/2025.
//

import SwiftUI

@MainActor
final class QuizGame: ObservableObject {
    
    private let api: QuizApi
    
    @Published var state: QuizGameState = .idle
    
    init(api: QuizApi) {
        self.api = api
    }
    
    func start() async {
        state = .loading
        
        do {
            let quiz = try await api.getQuiz()
            print("Quiz fetched successfully: \(quiz)")
        } catch {
            print("Error fetching quiz: \(error)")
        }
        
        state = .idle
    }
}

enum QuizGameState {
    case idle
    case loading
}
