//
//  Enums.swift
//  Kidz Quiz
//
//  Created by Chinthaka Perera on 1/11/25.
//

import Foundation

enum QuestionType: String, Decodable {
    case boolean = "boolean"
    case multiple = "multiple"
}

enum QuestionDifficulty: String, Decodable {
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"
}

//enum QuestionCategory: String {
//    // This is empty for now since that takes some time to gather all categories to insert in here.
//}

enum QuizStatus {
    case none
    case isFetching
    case isProcessing
    case isRetryFetching
    case isReady
    case isFailed
}

enum QuizError: Error {
    case apiFailure
    case decodingFailure
}
