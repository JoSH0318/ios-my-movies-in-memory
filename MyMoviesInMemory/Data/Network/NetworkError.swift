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
    
    var description: String {
        switch self {
        case .errorIsOccurred(let error):
            return "\(error) 관련 오류가 발생했습니다."
        case .invalidUrl:
            return "유효하지 않은 URL 입니다."
        case .invalidResponse:
            return "유효하지 않은 응답입니다."
        case .invalidData:
            return "유효하지 않은 정보입니다."
        }
    }
}
