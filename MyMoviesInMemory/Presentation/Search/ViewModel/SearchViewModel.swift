//
//  SearchViewModel.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/14.
//

import Foundation
import RxSwift

final class SearchViewModel {
    
    // MARK: - Input
    
    struct Input {
        let didEndSearching: Observable<String>
    }
    
    // MARK: - Output
    
    struct Output {
        let movies: Observable<[Movie]>
    }
    
    // MARK: - Properties
    
    private let movieUseCase: MovieUseCaseType
    
    // MARK: - Initializer
    
    init(movieUseCase: MovieUseCaseType) {
        self.movieUseCase = movieUseCase
    }
    
    // MARK: - Methods
    
    func transform(_ input: Input) -> Output {
        let movies = input.didEndSearching
            .withUnretained(self)
            .flatMap { owner, title in
                owner.movieUseCase.fetchMovies(title: title)
            }
        
        return Output(movies: movies)
    }
}
