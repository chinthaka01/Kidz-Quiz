//
//  Kidz_QuizTests.swift
//  Kidz QuizTests
//
//  Created by Chinthaka Perera on 1/11/25.
//

import Testing
@testable import Kidz_Quiz

struct Kidz_QuizTests {

    @Test func saveResults1() async throws {
        let questionViewModel = QuestionViewModel()
        let question = Question(type: .boolean, difficulty: .easy, correct_answer: "True", incorrect_answers: ["False"],
                                question: "Question 1", category: "Test Category")
        let selectedAnswer = Answer(text: "True", isCorrect: true, isSelected: true)
        var results: [String: [String: [String: Int]]] = [:]
        
        questionViewModel.saveResults(question: question, selectedAnswer: selectedAnswer, results: &results)
        
        #expect(results.count == 1)
        #expect(results[question.category]?[QuestionDifficulty.easy.rawValue]?.count == 2)
        #expect(results[question.category]?[QuestionDifficulty.easy.rawValue]?[StatsKeys.total.rawValue] == 1)
        #expect(results[question.category]?[QuestionDifficulty.easy.rawValue]?[StatsKeys.correctCount.rawValue] == 1)
    }
    
    @Test func saveResults2() async throws {
        let questionViewModel = QuestionViewModel()
        let question = Question(type: .boolean, difficulty: .easy, correct_answer: "True", incorrect_answers: ["False"],
                                question: "Question 1", category: "Test Category")
        let selectedAnswer = Answer(text: "False", isCorrect: true, isSelected: true)
        var results: [String: [String: [String: Int]]] = [:]
        
        questionViewModel.saveResults(question: question, selectedAnswer: selectedAnswer, results: &results)
        
        #expect(results.count == 1)
        #expect(results[question.category]?[QuestionDifficulty.easy.rawValue]?.count == 2)
        #expect(results[question.category]?[QuestionDifficulty.easy.rawValue]?[StatsKeys.total.rawValue] == 1)
        #expect(results[question.category]?[QuestionDifficulty.easy.rawValue]?[StatsKeys.correctCount.rawValue] == 0)
    }
    
    @Test func saveResults3() async throws {
        let questionViewModel = QuestionViewModel()
        let question = Question(type: .boolean, difficulty: .easy, correct_answer: "True", incorrect_answers: ["False"],
                                question: "Question 1", category: "Test Category")
        let selectedAnswer = Answer(text: "True", isCorrect: true, isSelected: true)
        var results: [String: [String: [String: Int]]] = ["Test Category": [QuestionDifficulty.easy.rawValue: [StatsKeys.total.rawValue: 1, StatsKeys.correctCount.rawValue: 0]]]
        
        questionViewModel.saveResults(question: question, selectedAnswer: selectedAnswer, results: &results)
        
        #expect(results.count == 1)
        #expect(results[question.category]?[QuestionDifficulty.easy.rawValue]?.count == 2)
        #expect(results[question.category]?[QuestionDifficulty.easy.rawValue]?[StatsKeys.total.rawValue] == 2)
        #expect(results[question.category]?[QuestionDifficulty.easy.rawValue]?[StatsKeys.correctCount.rawValue] == 1)
    }
    
    @Test func saveResults4() async throws {
        let questionViewModel = QuestionViewModel()
        let question = Question(type: .boolean, difficulty: .easy, correct_answer: "True", incorrect_answers: ["False"],
                                question: "Question 1", category: "Test Category")
        let selectedAnswer = Answer(text: "False", isCorrect: true, isSelected: true)
        var results: [String: [String: [String: Int]]] = ["Test Category": [QuestionDifficulty.easy.rawValue: [StatsKeys.total.rawValue: 1, StatsKeys.correctCount.rawValue: 0]]]
        
        questionViewModel.saveResults(question: question, selectedAnswer: selectedAnswer, results: &results)
        
        #expect(results.count == 1)
        #expect(results[question.category]?[QuestionDifficulty.easy.rawValue]?.count == 2)
        #expect(results[question.category]?[QuestionDifficulty.easy.rawValue]?[StatsKeys.total.rawValue] == 2)
        #expect(results[question.category]?[QuestionDifficulty.easy.rawValue]?[StatsKeys.correctCount.rawValue] == 0)
    }

}
