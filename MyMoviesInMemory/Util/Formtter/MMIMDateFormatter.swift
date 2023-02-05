//
//  MMIMDateFormatter.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/05.
//

import Foundation

final class MMIMDateFormatter {
    static let shared = MMIMDateFormatter()
    
    private init() {}
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return formatter
    }()
    
    func toDateString(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
