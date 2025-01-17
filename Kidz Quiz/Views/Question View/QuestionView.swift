//
//  QuestionView.swift
//  Kidz Quiz
//
//  Created by Chinthaka Perera on 1/11/25.
//

import SwiftUI

struct QuestionView: View {
    
    @ObservedObject var viewModel = QuestionViewModel()

    //  The format: [category: [difficulty: [total: <value>, correctCount: <value>]]]
    //  The percentages are calculated in the StatsView after this's finalized.
    @State var results: [String: [String: [String: Int]]] = [:]
    
    @State private var showingResult = false
    @State private var navigatingNextQuestion = false
    @State private var navigatingStats = false
    @State private var selectedAnswer: Answer?

    //  Index of current question
    let questionIndex: Int
    
    //  All questions of the quiz
    let questions: [Question]

    var body: some View {
        bodyView
        .padding()
        .sheet(isPresented: $showingResult) {
            getResultSheetView()
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.hidden)
        }
        .onAppear {
            viewModel.prepareSortedAnswers(question: questions[questionIndex])
        }
        .navigationBarBackButtonHidden()
        .navigationTitle(
            viewModel.getLocalizedString(
                key: "QuestionPage_Title%@%@",
                args: [(questionIndex + 1).description, questions.count.description]
            )
        )
        .navigationDestination(isPresented: $navigatingNextQuestion) {
            QuestionView(results: results, questionIndex: questionIndex + 1, questions: questions)
        }
        .navigationDestination(isPresented: $navigatingStats) {
            StatsView(results: results)
        }
    }
    
    var bodyView: some View {
        VStack {
            VStack {
                HStack {
                    Text("\(viewModel.getLocalizedString(key: "Difficulty")): ")
                        .fontWeight(.bold)
                    Text("\(viewModel.getLocalizedString(key: questions[questionIndex].difficulty.rawValue))")
                    Spacer()
                }

                HStack {
                    Text("\(viewModel.getLocalizedString(key: "Category")): ")
                        .fontWeight(.bold)
                    Text("\(questions[questionIndex].category)")
                        .lineLimit(nil)
                    Spacer()
                }
            }
            
            Spacer()
            
            HStack {
                Text("\(viewModel.getLocalizedString(key: "Question")):")
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.bottom)

            Text("\(questions[questionIndex].question)")
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .font(.title2)
            
            Spacer()
            
            answersView
            
            Spacer()
            
            VStack {
                Button {
                    showingResult = true
                } label: {
                    Text("\(viewModel.getLocalizedString(key: "Submit"))")
                }
                .padding(.bottom)
                .disabled(selectedAnswer == nil)

                Button(action: { endQuiz() }) {
                    Text("\(viewModel.getLocalizedString(key: "Exit_Quiz"))")
                }
                .padding(.bottom)
            }
        }
    }
    
    var answersView: some View {
        VStack {
            HStack {
                Text("\(viewModel.getLocalizedString(key: "Pick_Answer"))")
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.bottom)

            ForEach(viewModel.answers, id: \.self) { answer in
                HStack {
                    Label {
                        Text("\(answer.text)")
                            .lineLimit(nil)
                    } icon: {
                        Image(systemName: "checkmark")
                            .opacity(answer.isSelected ? 1 : 0)
                    }
                    
                    Spacer()
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .background(Color.gray.opacity(0.5))
                .padding(.bottom)
                .onTapGesture {
                    viewModel.manageAnswerSelection(answer)
                    self.selectedAnswer = answer
                }
            }
        }
    }

    private func getResultSheetView() -> some View {
        var iconName = "checkmark.circle.fill"
        var statusTextKey = "Selected_Correct_Answer"
        var correctAnswerText = ""
        
        if !(selectedAnswer?.isCorrect ?? false) {
            iconName = "xmark.circle.fill"
            statusTextKey = "Selected_Wrong_Answer"
            correctAnswerText = viewModel.answers.filter({ $0.isCorrect })[0].text
        }
        
        return VStack {
            Spacer()

            Image(systemName: iconName)
                .padding(.bottom)
            Text("\(viewModel.getLocalizedString(key: statusTextKey))")
            
            Spacer()

            Text(correctAnswerText)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .font(.title2)
            
            Spacer()
            
            VStack {
                Button(action: { handleAnswerSelection() }) {
                    Text("\(getNavButtonTitle())")
                }
                .padding(.bottom)

                Button(action: { endQuiz() }) {
                    Text("\(viewModel.getLocalizedString(key: "Exit_Quiz"))")
                }
                .padding(.bottom)
                .opacity(questionIndex < questions.count - 1 ? 1 : 0)
            }
        }
    }
}

extension QuestionView {
    
    private func getNavButtonTitle() -> String {
        if questionIndex < questions.count - 1 {
            viewModel.getLocalizedString(key: "Next_Question")
        } else {
            viewModel.getLocalizedString(key: "See_Score")
        }
    }
    
    private func handleAnswerSelection() {
        showingResult = false
        
        guard let selectedAnswer = selectedAnswer else { return }

        viewModel.saveResults(question: questions[questionIndex], selectedAnswer: selectedAnswer, results: &results)

        if questionIndex < questions.count - 1 {
            navigatingNextQuestion = true
        } else {
            navigatingStats = true
        }
    }
    
    private func endQuiz() {
        showingResult = false

        guard let selectedAnswer = selectedAnswer else {
            navigatingStats = true
            return
        }

        viewModel.saveResults(question: questions[questionIndex], selectedAnswer: selectedAnswer, results: &results)
        
        navigatingStats = true
    }
}
