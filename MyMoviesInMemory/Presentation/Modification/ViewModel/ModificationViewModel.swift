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
        let didTapSaveButton: Observable<EditViewModelItem>
    }
    
    // MARK: - Output
    
    struct Output {
        let reviewWithPoster: Observable<(UIImage?, Review)>
        let starRating: Observable<Int>
        let popModificationViewTrigger: Observable<Void>
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
                
        let popModificationViewTrigger = input.didTapSaveButton
            .withUnretained(self)
            .map { owner, data in
                let dataToUpdate = Review(
                    id: String(owner.review.id),
                    title: owner.review.title,
                    originalTitle: owner.review.originalTitle,
                    posterPath: owner.review.posterPath,
                    genres: owner.review.genres,
                    releaseDate: owner.review.releaseDate,
                    userRating: owner.review.userRating,
                    originalLanguage: owner.review.originalLanguage,
                    overview: owner.review.overview,
                    personalRating: Double(data.personalRating),
                    shortComment: data.shortComment ?? "",
                    comment: data.comment ?? "",
                    recordDate: MMIMDateFormatter.shared.toDateString(Date())
                )
                owner.reviewUseCase.update(dataToUpdate)
            }
        
        return Output(
            reviewWithPoster: reviewWithPoster,
            starRating: starRating,
            popModificationViewTrigger: popModificationViewTrigger
        )
    }
}
