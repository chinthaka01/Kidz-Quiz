//
//  Extensions.swift
//  Kidz Quiz
//
//  Created by Chinthaka Perera on 1/11/25.
//

import Foundation

extension String {
    
    /// Decode Strings by replacing HTML code by the symbol.
    /// This function is copied from ChatGPT.
    /// - Returns: The String after decoded.
    func decodeHTMLTags() -> String {
        guard let data = self.data(using: .utf8) else { return self }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        return (try? NSAttributedString(data: data, options: options, documentAttributes: nil).string) ?? self
    }
}
