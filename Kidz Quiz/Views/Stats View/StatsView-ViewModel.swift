//
//  StatsView-ViewModel.swift
//  Kidz Quiz
//
//  Created by Chinthaka Perera on 1/11/25.
//

import Foundation

class StatsViewModel: ParentViewModel {

    //  The format: [category: [difficulty: [fraction: <correctCount/total>, percentage: <(correctCount / total)%>]]]
    @Published var stats: [String: [String: [String: String]]] = [:]
    @Published var overralPercentage = ""
    
    func calculatePercentages(results: [String: [String: [String: Int]]]) {
        var totalQuestionsCount = 0
        var totalCorrectCount = 0

        results.forEach { category, categoryStats in
            stats[category] = [:]

            categoryStats.forEach { difficulty, difficultyStats in
                let total = difficultyStats[StatsKeys.total.rawValue]!
                let correctCount = difficultyStats[StatsKeys.correctCount.rawValue]!

                let fraction = "\(correctCount) / \(total)"
                let percentage = "\(Int(Double(correctCount) / Double(total) * 100))%"
                
                let percentageStats: [String: String] = [
                    StatsKeys.fraction.rawValue: fraction,
                    StatsKeys.percentage.rawValue: percentage
                ]
                stats[category]?[difficulty] = percentageStats
                
                totalQuestionsCount += total
                totalCorrectCount += correctCount
            }
        }
        
        overralPercentage = "\(Int(Double(totalCorrectCount) / Double(totalQuestionsCount) * 100))%"
    }
}
