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
    private let imageManager = ImageManager.shared
    private let downloadTaskToken: UInt
    private let review: Review
    
    // MARK: - Initializer
    
    init(
        reviewUseCase: ReviewUseCaseType,
        review: Review
    ) {
        self.reviewUseCase = reviewUseCase
        self.downloadTaskToken = imageManager.nextToken()
        self.review = review
    }
    
    // MARK: - Methods
    
    func transform(_ input: Input) -> Output {
        let posterImage = input.didShowView
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.imageManager.downloadImage(
                    owner.review.posterPath,
                    owner.downloadTaskToken
                )
                .asObservable()
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
