//
//  QuizApi.swift
//  Trivia-Quiz
//
//  Created by Tomasz Lizer on 17/01/2025.
//

import Foundation

final class QuizApi {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getQuiz(questionsCount: Int = 10) async throws -> QuizResponse {
        return try await response(
            for: .getQuiz(amount: questionsCount)
        )
    }
    
    // MARK: Private
    
    private func response<T: Decodable>(
        for endpoint: QuizApiEndpoint,
        decoder: JSONDecoder = .init()
    ) async throws -> T {
        let data = try await self.data(for: endpoint)
        return try decoder.decode(T.self, from: data)
    }
    
    private func data(for endpoint: QuizApiEndpoint) async throws -> Data {
        guard let url = url(for: endpoint) else {
            throw ApiError.cannotCreateURL
        }
        
        print("DEBUG - URL: \(url)")
        
        let (data, urlResponse) = try await session.data(from: url)
        
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            throw ApiError.invalidResponseType
        }
        
        print("DEBUG - RESPONSE: \(httpResponse)")
        
        #if DEBUG
        let string = String(data: data, encoding: .utf8)
        print("DEBUG - response: \(string ?? "no data")")
        #endif
        
        return data
    }
    
    private func url(for endpoint: QuizApiEndpoint) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "opentdb.com"
        components.path = endpoint.path
        components.queryItems = endpoint.queryItems
        
        return components.url
    }
}

extension QuizApi {
    enum ApiError: Error {
        case cannotCreateURL
        case invalidResponseType
    }
}
