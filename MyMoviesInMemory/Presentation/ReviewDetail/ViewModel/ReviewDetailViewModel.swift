//
//  ReviewDetailViewModel.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/17.
//

import RxSwift

final class ReviewDetailViewModel {
    
    // MARK: - Input
    
    struct Input {
        let didShowView: Observable<Void>
    }
    
    // MARK: - Output
    
    struct Output {
        let reviewWithPoster: Observable<(UIImage?, Review)>
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
    
    // MARK: - Methods
    
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
        
        return Output(reviewWithPoster: reviewWithPoster)
    }
}
