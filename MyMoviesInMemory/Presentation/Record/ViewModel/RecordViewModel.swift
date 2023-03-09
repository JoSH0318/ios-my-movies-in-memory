//
//  EditViewModel.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/30.
//

import RxSwift

final class RecordViewModel {
    
    // MARK: - Input
    
    struct Input {
        let didShowView: Observable<Void>
        let didDragStarRating: Observable<Float>
        let didTapSaveButton: Observable<(Float, String?, String?)>
        let didEditCommentView: Observable<(String?, String)>
        let didEditShortCommentView: Observable<(String?, String)>
        let willShowKeyboard: Observable<Notification>
    }
    
    // MARK: - Output
    
    struct Output {
        let editViewModelItem: Observable<EditViewModelItem>
        let starRating: Observable<Int>
        let commentViewEditingStatus: Observable<Void>
        let shortCommentViewEditingStatus: Observable<Void>
        let popRecordViewTrigger: Observable<Void>
        let keyboardHeight: Observable<CGFloat>
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
    
    // MARK: - Methods
    
    func transform(_ input: Input) -> Output {
        let editViewModelItem = input.didShowView
            .withUnretained(self)
            .map { owner, _ in
                EditViewModelItem(review: owner.review)
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
        
        let popRecordViewTrigger = input.didTapSaveButton
            .withUnretained(self)
            .map { owner, data in
                let dataToSave = Review(
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
                owner.reviewUseCase.save(dataToSave)
            }
        
        let keyboardHeight = input.willShowKeyboard
            .map { notification in
                if notification.name == UIResponder.keyboardWillShowNotification {
                    let userInfo = notification.userInfo
                    let keyboardInfo = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
                    return keyboardInfo?.cgRectValue.height ?? 0
                }
                return 0
            }
        
        return Output(
            editViewModelItem: editViewModelItem,
            starRating: rating,
            commentViewEditingStatus: isBeginEditingCommentView,
            shortCommentViewEditingStatus: isBeginEditingShortCommentView,
            popRecordViewTrigger: popRecordViewTrigger,
            keyboardHeight: keyboardHeight
        )
    }
}
