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
        let didTapSaveButton: Observable<(Float, String?, String?)>
    }
    
    // MARK: - Output
    
    struct Output {
        let modificationViewModelItem: Observable<EditViewModelItem>
        let starRating: Observable<Int>
        let popModificationViewTrigger: Observable<Void>
    }
    
    // MARK: - Properties
    
    private let reviewUseCase: ReviewUseCaseType
    private let review: Review
    
    // MARK: - Initializer
    
    init(
        reviewUseCase: ReviewUseCaseType,
        review: Review
    ) {
        self.reviewUseCase = reviewUseCase
        self.review = review
    }
    
    func transform(_ input: Input) -> Output {
        let modificationViewModelItem = input.didShowView
            .withUnretained(self)
            .map { owner, _ in
                EditViewModelItem(review: owner.review)
            }
        
        let starRating = input.didDragStarRating
            .withUnretained(self)
            .map { owner, rating in
                Int(rating)
            }
                
        let popModificationViewTrigger = input.didTapSaveButton
            .withUnretained(self)
            .map { owner, data in
                let dataToUpdate = Review(
                    id: owner.review.id,
                    title: owner.review.title,
                    originalTitle: owner.review.originalTitle,
                    posterPath: owner.review.posterPath,
                    genres: owner.review.genres,
                    runTime: owner.review.runTime,
                    releaseDate: owner.review.releaseDate,
                    userRating: owner.review.userRating,
                    overview: owner.review.overview,
                    director: owner.review.director,
                    actors: owner.review.actors,
                    personalRating: Double(data.0 / 2),
                    shortComment: data.1 ?? "",
                    comment: data.2 ?? "",
                    recordDate: MMIMDateFormatter.shared.toString(from: Date())
                )
                owner.reviewUseCase.update(dataToUpdate)
            }
        
        return Output(
            modificationViewModelItem: modificationViewModelItem,
            starRating: starRating,
            popModificationViewTrigger: popModificationViewTrigger
        )
    }
}
