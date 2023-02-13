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
        let didTapSaveButton: Observable<EditViewModelItem>
        let didEditCommentView: Observable<(String?, String)>
        let didEditShortCommentView: Observable<(String?, String)>
    }
    
    // MARK: - Output
    
    struct Output {
        let movieWithPoster: Observable<(UIImage?, Review)>
        let starRating: Observable<Int>
        let commentViewEditingStatus: Observable<Void>
        let shortCommentViewEditingStatus: Observable<Void>
        let popEditViewTrigger: Observable<Void>
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
        let movieWithPoster = input.didShowView
            .withUnretained(self)
            .map { owner, _ in
                (owner.posterImage, owner.review)
            }
        
        let rating = input.didDragStarRating
            .withUnretained(self)
            .map { owner, value in
                Int(floor(value))
            }
        
        let isBeginEditingCommentView = input.didEditCommentView
            .filter { $0.0 == $0.1 }
            .map { _ in }
        
        let isBeginEditingShortCommentView = input.didEditShortCommentView
            .filter { $0.0 == $0.1 }
            .map { _ in }
        
        let popEditViewTrigger = input.didTapSaveButton
            .withUnretained(self)
            .map { owner, data in
                let dataToSave = Review(
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
                owner.reviewUseCase.save(dataToSave)
            }
        
        return Output(
            movieWithPoster: movieWithPoster,
            starRating: rating,
            commentViewEditingStatus: isBeginEditingCommentView,
            shortCommentViewEditingStatus: isBeginEditingShortCommentView,
            popEditViewTrigger: popEditViewTrigger
        )
    }
}
