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
            let sortedAnswers = allAnswers.sorted { $0.text < $1.text }
            
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
}
