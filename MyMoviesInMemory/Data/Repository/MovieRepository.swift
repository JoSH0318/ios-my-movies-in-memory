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
            .searchMovie(title)
            .asEndpoint
        
        return networkProvider.execute(endpoint: endpoint)
            .decode(type: MoviesResponse.self, decoder: JSONDecoder())
            .map { response in
                guard let movies = response.movieResults else { throw NetworkError.decodedError }
                return movies.compactMap { $0.toDomain() }
            }
    }
    
    func fetchMovieDetail(id: Int) -> Observable<MovieDetail> {
        let movieDetail = Observable
            .zip(
                fetchDetail(id: id),
                fetchCredits(id: id)
            )
            .map { detail, credits in
                let movieOfficial = credits.toMovieOfficial()
                return detail.toDomain(
                    movieOfficial.director,
                    movieOfficial.actors
                )
            }
        
        return movieDetail
    }
}

extension MovieRepository {
    private func fetchDetail(id: Int) -> Observable<MovieDetailResponse> {
        let endpoint = EndpointStorage
            .searchMovieDetail(id)
            .asEndpoint
        
        return networkProvider.execute(endpoint: endpoint)
            .decode(type: MovieDetailResponse.self, decoder: JSONDecoder())
    }
    
    private func fetchCredits(id: Int) -> Observable<CreditsResponse> {
        let endpoint = EndpointStorage
            .searchCredits(id)
            .asEndpoint
        
        return networkProvider.execute(endpoint: endpoint)
            .decode(type: CreditsResponse.self, decoder: JSONDecoder())
    }
}
