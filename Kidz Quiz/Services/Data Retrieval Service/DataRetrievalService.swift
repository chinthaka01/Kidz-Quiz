//
//  DataRetrievalService.swift
//  Kidz Quiz
//
//  Created by Chinthaka Perera on 1/11/25.
//
//  This contains the functionalities related to fetching data through APIs.

import Foundation

class DataRetrievalService: IDataRetrievalService {

    func retrieveData(url: String, completion: @escaping (Result<Data, QuizError>) -> Void) {
        DispatchQueue.global().async {
            if let url = URL(string: url) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    DispatchQueue.main.async {
                        guard let data = data else {
                            NSLog("Error occured while fetching a quiz: \(String(describing: error))")
                            completion(.failure(.apiFailure))

                            return
                        }
                        
                        NSLog("Quiz received: \(data)")
                        completion(.success(data))
                    }
                }

                task.resume()
            } else {
                completion(.failure(.apiFailure))
            }
        }
    }
}
