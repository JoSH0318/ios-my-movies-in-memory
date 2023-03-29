//
//  EndpointStorage.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/13.
//

import Foundation

enum EndpointStorage {
    
    private enum Constant {
        static let baseUrl = "https://api.themoviedb.org/3"
        static let searchPath = "/search/movie"
        static let moviePath = "/movie"
    }
    
    case searchMovie(String)
    case searchMovieDetail(Int)
    case searchCredits(Int)
}

extension EndpointStorage {
    var asEndpoint: Endpoint {
        switch self {
        case .searchMovie(let title):
            return Endpoint(
                baseUrl: Constant.baseUrl,
                path: Constant.searchPath,
                method: .get,
                queries: [
                    "api_key" : UserInfo.apiKey,
                    "query" : title,
                    "language" : "ko-KR"
                ]
            )
        case .searchMovieDetail(let id):
            return Endpoint(
                baseUrl: Constant.baseUrl,
                path: Constant.moviePath + "/\(id)",
                method: .get,
                queries: [
                    "api_key" : UserInfo.apiKey,
                    "language" : "ko-KR"
                ]
            )
        case .searchCredits(let id):
            return Endpoint(
                baseUrl: Constant.baseUrl,
                path: Constant.moviePath + "/\(id)/credits",
                method: .get,
                queries: [
                    "api_key" : UserInfo.apiKey,
                    "language" : "ko-KR"
                ]
            )
        }
    }
}
