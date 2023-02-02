//
//  StringFormatter.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/19.
//

import Foundation

final class StringFormatter {
    static let shared = StringFormatter()
    
    private init() {}
    
    func toTitleFormat(_ string: String) -> String {
        let formattedString = string
            .replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: " ")
        
        return formattedString
    }
}
