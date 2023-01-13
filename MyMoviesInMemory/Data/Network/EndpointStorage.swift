//
//  EndpointStorage.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/13.
//

import Foundation

enum EndpointStorage {
    
    private enum Constant {
        static let naverBaseUrl = "https://openapi.naver.com/v1"
        static let naverSearchPath = "/search/movie.json"
        static let OMDbBaseUrl = "http://www.omdbapi.com/"
        static let empty = ""
    }
    
    case naverMovieAPI(String)
    case OMDbMovieAPI(String)
}

extension EndpointStorage {
    
    var asEndpoint: Endpoint {
        switch self {
        case .naverMovieAPI(let title):
            return Endpoint(
                baseUrl: Constant.naverBaseUrl,
                path: Constant.naverSearchPath,
                method: .get,
                header: [
                    "X-Naver-Client-Id": UserInfo.naverClientId,
                    "X-Naver-Client-Secret": UserInfo.naverClientSecret,
                    "Content-Type": "plain/text"
                ],
                queries: ["query" : title]
            )
        case .OMDbMovieAPI(let imageTitle):
            return Endpoint(
                baseUrl: Constant.OMDbBaseUrl,
                path: Constant.empty,
                method: .get,
                queries: [
                    "i": "tt3896198",
                    "t": imageTitle,
                    "apikey": UserInfo.OMDbClientKey
                ]
            )
        }
    }
}
