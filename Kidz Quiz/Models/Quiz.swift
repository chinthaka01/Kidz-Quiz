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
    let correct_answer: String
    let incorrect_answers: [String]
    var question: String
    var category: String // For now I keep this as a String since that takes some time to gather all categories to define as an enum.
    
    func decodeHTMLTags() -> Question {
        var decodedQuestion = self

        decodedQuestion.category = category.decodeHTMLTags()
        decodedQuestion.question = question.decodeHTMLTags()

        return decodedQuestion
    }
}

struct Answer: Hashable {
    let id = UUID()
    var text: String
    var isCorrect = false
    var isSelected = false
    
    func decodeHTMLTags() -> Answer {
        var decodedAnswer = self

        decodedAnswer.text = text.decodeHTMLTags()

        return decodedAnswer
    }
}
