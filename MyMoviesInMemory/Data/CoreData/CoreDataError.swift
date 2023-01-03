//
//  CoreDataError.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/29.
//

import Foundation

enum CoreDataError: LocalizedError {
    case readFail
    case saveFail
    
    var description: String {
        switch self {
        case .readFail:
            return "ERROR: Read fail in CoreData"
        case .saveFail:
            return "ERROR: Save fail in CoreData"
        }
    }
}
