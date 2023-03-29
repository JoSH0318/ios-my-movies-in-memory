//
//  HTTPMethod.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/28.
//

import Foundation

enum HTTPMethod {
    case get
    case post
    case patch
    case delete
}

extension HTTPMethod {
    var description: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .patch:
            return "PATCH"
        case .delete:
            return "DELETE"
        }
    }
}
