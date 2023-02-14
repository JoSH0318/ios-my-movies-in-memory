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
        let didTapEditButton: Observable<Void>
    }
    
    // MARK: - Output
    
    struct Output {
        let searchDetailViewModelItem: Observable<SearchDetailViewModelItem>
        let movieToSend: Observable<Movie>
    }
    
    // MARK: - Properties
    
    private let movieUseCase: MovieUseCaseType
    private let movie: Movie
    
    // MARK: - Initializer
    
    init(
        movieUseCase: MovieUseCaseType,
        movie: Movie
    ) {
        self.movieUseCase = movieUseCase
        self.movie = movie
    }
    
    // MARK: - Methods
    
    func transform(_ input: Input) -> Output {
        let searchDetailViewModelItem = input.didShowView
            .withUnretained(self)
            .map { owner, _ in
                SearchDetailViewModelItem(movie: owner.movie)
            }
        
        let movieToSend = input.didTapEditButton
            .withUnretained(self)
            .map { owner, _ in
                owner.movie
            }
        
        return Output(
            searchDetailViewModelItem: searchDetailViewModelItem,
            movieToSend: movieToSend
        )
    }
}
