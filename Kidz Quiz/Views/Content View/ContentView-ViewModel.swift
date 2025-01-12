//
//  ContentView-ViewModel.swift
//  Kidz Quiz
//
//  Created by Chinthaka Perera on 1/11/25.
//

import Foundation

class ContentViewModel: ParentViewModel {
    
    // The array of fetched questions of a quiz.
    @Published var questions: [Question] = []
    
    // This is the quiz fetching status
    @Published var fetchStatus = QuizStatus.none // Swift assign the variable type from the value by default.
    
    // We retry if fetching a quiz failed. This is the count of retry attempts.
    @Published var retryCount = 0
    
    private let baseURL = "https://opentdb.com/api.php"
    
    // This is the maximum retry attempts count.
    private let maxRetryCount = 3
    
    // The batch count of questions fetch request.
    private let fetchAmount = "10"

    private let quizRetrievalService: IDataRetrievalService
    private let jsonDataDecodeService = JSONDataDecodeService()
    
    init(quizRetrievalService: IDataRetrievalService = DataRetrievalService()) {
        self.quizRetrievalService = quizRetrievalService
    }

    func fetchQuiz() {
        let url = baseURL + "?amount=\(fetchAmount)"

        quizRetrievalService.retrieveData(url: url) { result in
            switch result {
            case .success(let data):
                self.fetchStatus = .isProcessing
                
                do {
                    self.questions = try self.jsonDataDecodeService.decodeQuiz(data: data).results
                    self.fetchStatus = .isReady
                } catch {
                    NSLog("Quiz decoding failed: \(error)")
                    self.fetchStatus = .isFailed
                }
            case .failure(_):
                guard self.retryCount < self.maxRetryCount else {
                    self.fetchStatus = .isFailed

                    return
                }
                
                self.retryCount += 1
                self.fetchStatus = .isRetryFetching

                self.fetchQuiz()
            }
        }
    }
}
