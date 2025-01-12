//
//  ContentView.swift
//  Kidz Quiz
//
//  Created by Chinthaka Perera on 1/11/25.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            bodyView
            .padding()
            .onAppear() {
                viewModel.fetchQuiz()
            }
            .navigationTitle(viewModel.getLocalizedString(key: "Hi"))
        }
    }
    
    var bodyView: some View {
        VStack {
            HStack {
                Text(getFetchStatus())
                    .fontWeight(.bold)
                ProgressView()
            }
            .opacity(getStatusViewOpacity())
            
            Spacer()
            
            Text(getBodyDescription())
                .fontWeight(.bold)
                .frame(alignment: .center)
            
            Spacer()
            
            NavigationLink(destination: QuestionView(questionIndex: 0, questions: viewModel.questions)) {
                Text(getButtonTitle())
                    .fontWeight(.bold)
            }
            .disabled(getButtonDisabled())
        }
    }
}

//  Contains functionalities that related to the views.
extension ContentView {

    private func getFetchStatus() -> String {
        switch viewModel.fetchStatus {
        case .isFetching, .none:
            return viewModel.getLocalizedString(key: "Loading")
        case .isProcessing:
            return viewModel.getLocalizedString(key: "Processing")
        case .isRetryFetching:
            return viewModel.getLocalizedString(key: "Retrying%@", args: [viewModel.retryCount.description])
        default:
            return ""
        }
    }
    
    private func getBodyDescription() -> String {
        switch viewModel.fetchStatus {
        case .isReady:
            return viewModel.getLocalizedString(key: "Quiz_Ready%@", args: [viewModel.questions.count.description])
        case .isFailed:
            return viewModel.getLocalizedString(key: "Quiz_Failed")
        default:
            return viewModel.getLocalizedString(key: "Quiz_Loading")
        }
    }
    
    private func getButtonTitle() -> String {
        switch viewModel.fetchStatus {
        case .isFailed:
            return viewModel.getLocalizedString(key: "Try_Again")
        default:
            return viewModel.getLocalizedString(key: "Start_Quiz")
        }
    }
    
    private func getButtonDisabled() -> Bool {
        !(viewModel.fetchStatus == .isReady || viewModel.fetchStatus == .isFailed) && viewModel.questions.isEmpty
    }
    
    private func getStatusViewOpacity() -> Double {
        viewModel.fetchStatus == .isReady || viewModel.fetchStatus == .isFailed ? 0 : 1
    }
}
