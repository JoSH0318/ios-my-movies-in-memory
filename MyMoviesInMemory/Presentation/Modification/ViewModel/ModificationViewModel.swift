//
//  ModificationViewModel.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/13.
//

import RxSwift

final class ModificationViewModel {
    
    // MARK: - Input
    
    struct Input {
        let didShowView: Observable<Void>
        let didDragStarRating: Observable<Float>
    }
    
    // MARK: - Output
    
    struct Output {
        let reviewWithPoster: Observable<(UIImage?, Review)>
        let starRating: Observable<Int>
    }
    
    // MARK: - Properties
    
    private let reviewUseCase: ReviewUseCaseType
    private let review: Review
    private let posterImage: UIImage?
    
    // MARK: - Initializer
    
    init(
        reviewUseCase: ReviewUseCaseType,
        review: Review,
        posterImage: UIImage?
    ) {
        self.reviewUseCase = reviewUseCase
        self.review = review
        self.posterImage = posterImage
    }
    
    func transform(_ input: Input) -> Output {
        let posterImage = input.didShowView
            .withUnretained(self)
            .map { owner, _ in
                owner.posterImage
            }
        
        let review = input.didShowView
            .withUnretained(self)
            .map { owner, _ in
                owner.review
            }
        
        let reviewWithPoster = Observable.combineLatest(
            posterImage,
            review
        )
        
        let starRating = input.didDragStarRating
            .withUnretained(self)
            .map { owner, rating in
                Int(rating)
            }
                
        return Output(
            reviewWithPoster: reviewWithPoster,
            starRating: starRating
        )
    }
}
