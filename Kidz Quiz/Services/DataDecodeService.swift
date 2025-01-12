//
//  DataDecodeService.swift
//  Kidz Quiz
//
//  Created by Chinthaka Perera on 1/11/25.
//
//  This contains the functionalities related to decording data.

import Foundation

class JSONDataDecodeService {

    func decodeQuiz(data: Data) throws -> QuizResponse {
        try JSONDecoder().decode(QuizResponse.self, from: data)
    }
}
