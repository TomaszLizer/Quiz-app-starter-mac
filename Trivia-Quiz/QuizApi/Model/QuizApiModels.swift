//
//  QuizApiEndpoint.swift
//  Trivia-Quiz
//
//  Created by Tomasz Lizer on 17/01/2025.
//

import Foundation

// MARK: Endpoints

enum QuizApiEndpoint {
    case getQuiz(params: GetQuizParams)
    case getToken
    case resetToken(token: String)
    
    static func getQuiz(amount: Int) -> Self {
        let params = GetQuizParams(
            amount: amount,
            category: nil,
            token: nil
        )
        return .getQuiz(params: params)
    }
    
    var path: String {
        switch self {
        case .getQuiz:
            return "/api.php"
        case .getToken, .resetToken:
            return "/api_token.php"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getQuiz(let params):
            return params.asQueryItems()
        case .getToken:
            return [.init(name: "command", value: "request")]
        case .resetToken(let token):
            return [
                .init(name: "command", value: "reset"),
                .init(name: "token", value: token)
            ]
        }
    }
}

struct GetQuizParams {
    /// The amount of questions to be returned. Maximum is 50.
    let amount: Int
    /// The category of the questions. Optional
    let category: String?
    /// Session token for quiz. Optional
    let token: String?
}

extension GetQuizParams {
    func asQueryItems() -> [URLQueryItem] {
        var items: [URLQueryItem] = []
        items.append(.init(name: "amount", value: "\(amount)"))
        if let category {
            items.append(.init(name: "category", value: category))
        }
        if let token {
            items.append(.init(name: "token", value: token))
        }
        return items
    }
}

// MARK: Responses

struct QuizResponse: Decodable {
    // Add data
}
