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
        let movieDetailItem: Observable<SearchDetailViewModelItem>
        let detailToSend: Observable<MovieDetail>
    }
    
    // MARK: - Properties
    
    private let movieUseCase: MovieUseCaseType
    private let movieID: Int
    
    // MARK: - Initializer
    
    init(
        movieUseCase: MovieUseCaseType,
        movieID: Int
    ) {
        self.movieUseCase = movieUseCase
        self.movieID = movieID
    }
    
    // MARK: - Methods
    
    func transform(_ input: Input) -> Output {
        let movieDetail = input.didShowView
            .withUnretained(self)
            .flatMap { owner, detail in
                owner.movieUseCase
                    .fetchMovieDetail(id: owner.movieID)
            }
            .share()
        
        let movieDetailItem = movieDetail
            .map { detail in
                SearchDetailViewModelItem(movieDetail: detail)
            }
        
        let detailToSend = input.didTapEditButton
            .flatMap {
                movieDetail
            }
        
        return Output(
            movieDetailItem: movieDetailItem,
            detailToSend: detailToSend
        )
    }
}
