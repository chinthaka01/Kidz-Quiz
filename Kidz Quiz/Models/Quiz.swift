//
//  Quiz.swift
//  Kidz Quiz
//
//  Created by Chinthaka Perera on 1/11/25.
//

import Foundation

struct QuizResponse: Decodable {
    let response_code: Int
    let results: [Question]
}

struct Question: Decodable {
    let type: QuestionType
    let difficulty: QuestionDifficulty
    let category: String // For now I keep this as a String since that takes some time to gather all categories to define as an enum.
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}

struct Answer: Hashable {
    let id = UUID()
    let text: String
    var isCorrect = false
    var isSelected = false
}
