//
//  EndpointStorage.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/13.
//

import Foundation

enum EndpointStorage {
    
    private enum Constant {
        static let baseUrl = "https://api.themoviedb.org/3/search/"
        static let path = "movie"
    }
    
    case searchMovie(String)
}

extension EndpointStorage {
    
    var asEndpoint: Endpoint {
        switch self {
        case .searchMovie(let title):
            return Endpoint(
                baseUrl: Constant.baseUrl,
                path: Constant.path,
                method: .get,
                queries: [
                    "api_key" : UserInfo.apiKey,
                    "query" : title,
                    "language" : "ko-KR"
                ]
            )
        }
    }
}
