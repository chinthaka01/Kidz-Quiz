# Kidz-Quiz
This app allows users to answer 10 random questions in a quiz.

# Xcode Version
16.2

# Swift Version
Swift 5

# Project Description

- The app fetches quiz questions from OpenTDB (https://opentdb.com), which is an open API for trivia questions. 
- Questions are fetched at each app launch, and users can navigate through the quiz one question at a time with no time limit. 
- After answering each question, the app provides immediate feedback on whether the selected answer is correct. If not, the app let the user know the correct answer.
- At the end of the quiz, or if the user exits in between the quiz, the app displays the overall result, including the percentage of correct answers.
- The UI is designed to be simple showing only required details, reducing the number of lines in the view files and the time required to complete the project.
- Log statements have been added only for properties and functions that require additional description, maintain the files length.

# An example of a sample question received by the API in JSON format:

        {
            "type": "multiple",
            "difficulty": "easy",
            "category": "History",
            "question": "In which year did the Invasion of Kuwait by Iraq occur?",
            "correct_answer": "1990",
            "incorrect_answers": [
                "1992",
                "1988",
                "1986"
            ]
        }

# Project Architectural Design Pattern
MVVM

# Project File Structure

- .gitignore
- Screen Record - Starting and Exiting in the midway.mp4
- Screen Record - End of the Quiz.mp4
- en.lproj/
  - Localizable.strings
- Kidz Quiz/
  - Data Types/
    - Enums.swift
  - Models/
    - Quiz.swift
  - Services/
    - Data Retrieval Service/
      - DataRetrievalService.swift
      - IDataRetrievalService.swift
    - DataDecodeService.swift
  - Views/
    - ParentViewModel.swift
    - Content View/
      - ContentView-ViewModel.swift
      - ContentView.swift
    - Question View/
      - QuestionView-ViewModel.swift
      - QuestionView.swift
    - Stats View/
      - StatsView-ViewModel.swift
      - StatsView.swift
  - Kidz_Quiz.entitlements
  - Kidz_QuizApp.swift
  - Assets.xcassets/
  - Preview Content/
    - Preview Assets.xcassets/
  - Kidz Quiz.xcodeproj/
- Kidz QuizTests/
    - Kidz_QuizTests.swift
- Kidz QuizUITests/
- README.md

# Design Patterns use in the Project:

- Swift Extensions, aligning closely related to the Decotator Design Pattern
- Combine Swift, strongly related to the Observer Design Pattern
- Closures, closely related to the Command Design Pattern
- Aditionally, The project adheres to SOLID principals

# Data Structures use in the Project:
- Array
- Dictionary
