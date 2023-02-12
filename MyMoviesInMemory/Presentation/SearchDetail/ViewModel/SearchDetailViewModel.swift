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
        let movieWithPoster: Observable<(UIImage?, Movie)>
        let movieToSend: Observable<(UIImage?, Movie)>
    }
    
    // MARK: - Properties
    
    private let movieUseCase: MovieUseCaseType
    private let imageManager = ImageManager.shared
    private let downloadTaskToken: UInt
    private let movie: Movie
    
    // MARK: - Initializer
    
    init(
        movieUseCase: MovieUseCaseType,
        movie: Movie
    ) {
        self.movieUseCase = movieUseCase
        self.downloadTaskToken = imageManager.nextToken()
        self.movie = movie
    }
    
    // MARK: - Methods
    
    func transform(_ input: Input) -> Output {
        let posterImage = input.didShowView
            .withUnretained(self)
            .flatMap { owner, movie in
                owner.imageManager.downloadImage(
                    owner.movie.posterPath,
                    owner.downloadTaskToken
                )
                .asObservable()
            }
        
        let movie = input.didShowView
            .withUnretained(self)
            .map { owner, _ in
                owner.movie
            }
        
        let movieWithPoster = Observable.combineLatest(
            posterImage,
            movie
        )
        
        let movieToSend = input.didTapEditButton
            .withLatestFrom(movieWithPoster)
        
        return Output(
            movieWithPoster: movieWithPoster,
            movieToSend: movieToSend
        )
    }
}
