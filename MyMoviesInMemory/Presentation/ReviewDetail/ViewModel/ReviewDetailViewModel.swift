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
        let didTapDeleteButton: Observable<AlertActionType>
        let didTapModificationButton: Observable<Void>
        let didScroll: Observable<CGPoint>
    }
    
    // MARK: - Output
    
    struct Output {
        let reviewCellViewModelItem: Observable<ReviewDetailViewModelItem>
        let deleteAlertAction: Observable<AlertActionType>
        let reviewToSend: Observable<Review>
        let contentOffsetY: Observable<CGFloat>
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
        let fetchedReview = input.didShowView
            .withUnretained(self)
            .flatMap { owner, _ in
                owner
                    .reviewUseCase
                    .fetchReview(owner.review.id)
            }
            .share()
        
        let reviewCellViewModelItem = fetchedReview
            .map { review in
                ReviewDetailViewModelItem(review: review)
            }
        
        let deleteAlertAction = input.didTapDeleteButton
            .withUnretained(self)
            .map { owner, action in
                if action == .delete {
                    owner
                        .reviewUseCase
                        .delete(owner.review)
                }
                
                return action
            }
        
        let reviewToSend = input.didTapModificationButton
            .withLatestFrom(fetchedReview)
        
        let contentOffsetY = input.didScroll
            .map { $0.y }
        
        return Output(
            reviewCellViewModelItem: reviewCellViewModelItem,
            deleteAlertAction: deleteAlertAction,
            reviewToSend: reviewToSend,
            contentOffsetY: contentOffsetY
        )
    }
}
