//
//  QuestionView-ViewModel.swift
//  Kidz Quiz
//
//  Created by Chinthaka Perera on 1/11/25.
//

import Foundation

class QuestionViewModel: ParentViewModel {
    
    //  Answer instances of a question sorted by the answer text.
    @Published var answers: [Answer] = []
    
    func prepareSortedAnswers(question: Question) {
        DispatchQueue.global().async {
            let correctAnswer = question.correct_answer
            let incorrectAnswers = question.incorrect_answers
            
            let allAnswers: [Answer] = [Answer(text: correctAnswer, isCorrect: true)] +
                incorrectAnswers.map { Answer(text: $0) }

            let decodedAnswers = allAnswers.map( { $0.decodeHTMLTags() })
            let sortedAnswers = decodedAnswers.sorted { $0.text < $1.text }
            
            DispatchQueue.main.async {
                self.answers = sortedAnswers
            }
        }
    }
    
    func manageAnswerSelection(_ selectedAnswer: Answer) {
        for index in answers.indices {
            answers[index].isSelected = answers[index].id == selectedAnswer.id
        }
    }
    
    func saveResults(question: Question, selectedAnswer: Answer, results: inout [String: [String: [String: Int]]]) {
        let category = question.category
        let difficulty = question.difficulty
        let correctAnswer = question.correct_answer
        let defaultResult = [StatsKeys.total.rawValue: 1, StatsKeys.correctCount.rawValue: 0]
        
        if results[category] == nil {
            results[category] = [difficulty.rawValue: defaultResult]
        } else if results[category]![difficulty.rawValue] == nil {
            results[category]![difficulty.rawValue] = defaultResult
        } else {
            let totalCount = results[category]![difficulty.rawValue]![StatsKeys.total.rawValue]! + 1
            results[category]![difficulty.rawValue]![StatsKeys.total.rawValue] = totalCount
        }
        
        if selectedAnswer.text == correctAnswer {
            let correctCount = results[category]![difficulty.rawValue]![StatsKeys.correctCount.rawValue]! + 1
            results[category]![difficulty.rawValue]![StatsKeys.correctCount.rawValue] = correctCount
        }
    }
}
