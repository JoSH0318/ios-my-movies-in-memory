//
//  NetworkError.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/28.
//

import Foundation

enum NetworkError: Error {
    case errorIsOccurred(_ error: String)
    case invalidUrl
    case invalidResponse
    case invalidData
    case decodedError
    
    var description: String {
        switch self {
        case .errorIsOccurred(let error):
            return "\(error) 관련 오류가 발생했습니다."
        case .invalidUrl:
            return "ERROR: Invalid URL"
        case .invalidResponse:
            return "ERROR: Invalid Response"
        case .invalidData:
            return "ERROR: Invalid Data"
        case .decodedError:
            return "ERROR: Decode Fail"
        }
    }
}
