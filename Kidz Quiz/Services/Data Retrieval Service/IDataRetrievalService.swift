//
//  IDataRetrievalService.swift
//  Kidz Quiz
//
//  Created by Chinthaka Perera on 1/11/25.
//

import Foundation

protocol IDataRetrievalService {
    func retrieveData(url: String, completion: @escaping (Result<Data, QuizError>) -> Void)
}
