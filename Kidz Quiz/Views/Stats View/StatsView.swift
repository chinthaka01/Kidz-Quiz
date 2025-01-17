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
                
                Button(viewModel.getLocalizedString(key: "Go_Home")) {
                    //  Still Swift hasn't given a direct way to go to the root view like with Objective-C.
                    //  We can use Combine-Swift's @State variable as a work-around for this purpose.
                    //  But I keep not implementing that since that will make a bit confusion.
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
