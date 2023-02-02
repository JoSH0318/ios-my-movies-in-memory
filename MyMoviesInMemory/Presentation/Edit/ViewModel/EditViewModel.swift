//
//  EditViewModel.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/30.
//

import RxSwift

final class EditViewModel {
    
    // MARK: - Input
    
    struct Input {
        let didShowView: Observable<Void>
        let didDragStarRating: Observable<Float>
        let didTapSaveButton: Observable<(String?, String?)>
    }
    
    // MARK: - Output
    
    struct Output {
        let movieWithPoster: Observable<(UIImage?, Movie)>
        let starRating: Observable<Int>
    }
    
    // MARK: - Properties
    
    private let reviewUseCase: ReviewUseCaseType
    private let movie: Movie
    private let posterImage: UIImage?
    
    // MARK: - Initializer
    
    init(
        reviewUseCase: ReviewUseCaseType,
        movie: Movie,
        posterImage: UIImage?
    ) {
        self.reviewUseCase = reviewUseCase
        self.movie = movie
        self.posterImage = posterImage
    }
    
    // MARK: - Methods
    
    func transform(_ input: Input) -> Output {
        let movieWithPoster = input.didShowView
            .withUnretained(self)
            .map { owner, _ in
                (owner.posterImage, owner.movie)
            }
        
        let rating = input.didDragStarRating
            .withUnretained(self)
            .map { owner, value in
                Int(floor(value))
            }
        
        return Output(
            movieWithPoster: movieWithPoster,
            starRating: rating
        )
    }
}
