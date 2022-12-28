//
//  Endpoint.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/28.
//

import Foundation

final class Endpoint {
    private let baseUrl: String
    private let path: String
    private let method: HTTPMethod
    private let header: [String: String]
    private let queries: [String: Any]
    
    init(
        baseUrl: String,
        path: String,
        method: HTTPMethod,
        header: [String : String] = [:],
        queries: [String : Any] = [:]
    ) {
        self.baseUrl = baseUrl
        self.path = path
        self.method = method
        self.header = header
        self.queries = queries
    }
    
    func generateRequest() throws -> URLRequest {
        let url = try generateUrl()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.description
        
        header.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        return urlRequest
    }
    
    private func generateUrl() throws -> URL {
        let urlString = baseUrl + path
        
        var component = URLComponents(string: urlString)
        component?.queryItems = queries.map {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }
        
        guard let url = component?.url else {
            throw NetworkError.invalidUrl
        }
        
        return url
    }
}
