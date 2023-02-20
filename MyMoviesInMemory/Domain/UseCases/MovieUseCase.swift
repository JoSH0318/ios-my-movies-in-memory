//
//  MovieUseCase.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/29.
//

import Foundation
import RxSwift

final class MovieUseCase: MovieUseCaseType {
    private let repository: NetworkRepository
    
    init(repository: NetworkRepository) {
        self.repository = repository
    }
    
    func fetchMovies(title: String) -> Observable<[Movie]> {
        return repository.fetchMovies(title: title)
    }
    
    func fetchMovieDetail(id: Int) -> Observable<MovieDetail> {
        return repository.fetchMovieDetail(id: id)
    }
}
