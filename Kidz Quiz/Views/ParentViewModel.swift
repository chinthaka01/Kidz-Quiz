//
//  ParentViewModel.swift
//  Kidz Quiz
//
//  Created by Chinthaka Perera on 1/11/25.
//

import Foundation

class ParentViewModel: ObservableObject {
    
    func getLocalizedString(key: String, args: [CVarArg]? = nil) -> String {
        guard let args = args else {
            return NSLocalizedString(key, comment: "")
        }
        return String(format: NSLocalizedString(key, comment: ""), args)
    }
}
