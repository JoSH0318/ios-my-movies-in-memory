//
//  SearchDetailViewModel.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/18.
//

import Foundation
import RxSwift

final class SearchDetailViewModel {
    
    // MARK: - Input
    
    struct Input {
        let didShowView: Observable<Void>
    }
    
    // MARK: - Output
    
    struct Output {
        let movie: Observable<Movie>
    }
    
    // MARK: - Properties
    
    private let movieUseCase: MovieUseCaseType
    private let movie: Movie
    
    // MARK: - Initializer
    
    init(movieUseCase: MovieUseCaseType, movie: Movie) {
        self.movieUseCase = movieUseCase
        self.movie = movie
    }
    
    // MARK: - Methods
    
    func transform(_ input: Input) -> Output {
        let output = input.didShowView
            .withUnretained(self)
            .flatMap { owner, _ in
                Observable.just(owner.movie)
            }
        
        return Output(movie: output)
    }
}
