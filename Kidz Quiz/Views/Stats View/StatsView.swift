//
//  StatsView.swift
//  Kidz Quiz
//
//  Created by Chinthaka Perera on 1/11/25.
//

import SwiftUI

struct StatsView: View {
    
    @ObservedObject var viewModel = StatsViewModel()

    //  The format: [category: [difficulty: [total: <value>, correctCount: <value>]]]
    //  The percentages are calculated based on this.
    let results: [String: [String: [String: Int]]]

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.stats.keys.sorted(), id: \.self) { category in
                    VStack {
                        Text(category)
                            .lineLimit(nil)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.vertical)

                        ForEach(viewModel.stats[category]!.keys.sorted(), id: \.self) { difficulty in
                            HStack {
                                Text(difficulty)
                                    .fontWeight(.bold)
                                Spacer()
                                Text("\(viewModel.stats[category]![difficulty]![StatsKeys.fraction.rawValue]!)")
                                Spacer()
                                Text("\(viewModel.stats[category]![difficulty]![StatsKeys.percentage.rawValue]!)")
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
            VStack {
                Text("\(viewModel.getLocalizedString(key: "Overral_Percentage")): \(viewModel.overralPercentage)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                Button("Go To Home") {

                }
                .padding(.vertical)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle(viewModel.getLocalizedString(key: "Final_Result"))
        .onAppear() {
            viewModel.calculatePercentages(results: results)
        }
    }
}
