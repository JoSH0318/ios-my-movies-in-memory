//
//  MovieRepository.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/29.
//

import Foundation
import RxSwift

final class MovieRepository: NetworkRepository {
    private let networkProvider: NetworkProvider
    
    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
    
    func fetchMovies(title: String) -> Observable<[Movie]> {
        let endpoint = Endpoint(
            baseUrl: "https://openapi.naver.com/v1",
            path: "/search/movie.json",
            method: .get,
            header: [
                "X-Naver-Client-Id": "Tkn0wA2s08hupRMoxlvP",
                "X-Naver-Client-Secret": "Bre9iIzgOZ",
                "Content-Type": "plain/text"
            ],
            queries: ["query" : title]
        )
        
        return networkProvider.execute(endpoint: endpoint)
            .decode(type: MoviesResponse.self, decoder: JSONDecoder())
            .map { response in
                guard let movies = response.items else { throw NetworkError.decodedError }
                return movies.compactMap { $0.toDomain() }
            }
    }
}
