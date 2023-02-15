//
//  MMIMNumberFormatter.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/16.
//

import Foundation

final class MMIMNumberFormatter {
    static let shared = MMIMNumberFormatter()
    
    private init() {}
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    func toRating(_ double: Double) -> String {
        return numberFormatter.string(from: double as NSNumber) ?? ""
    }
}
