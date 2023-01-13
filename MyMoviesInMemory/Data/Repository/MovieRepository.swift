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
        
        let endpoint = EndpointStorage
            .naverMovieAPI(title)
            .asEndpoint
        
        return networkProvider.execute(endpoint: endpoint)
            .decode(type: MoviesResponse.self, decoder: JSONDecoder())
            .map { response in
                guard let movies = response.items else { throw NetworkError.decodedError }
                return movies.compactMap { $0.toDomain() }
            }
    }
}
