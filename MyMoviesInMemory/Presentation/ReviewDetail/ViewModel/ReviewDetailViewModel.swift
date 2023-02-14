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
    }
    
    // MARK: - Output
    
    struct Output {
        let reviewCellViewModelItem: Observable<ReviewDetailViewModelItem>
        let deleteAlertAction: Observable<AlertActionType>
        let reviewToSend: Observable<Review>
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
        
        let reviewCellViewModelItem = input.didShowView
            .withUnretained(self)
            .map { owner, _ in
                ReviewDetailViewModelItem(review: owner.review)
            }
        
        let deleteAlertAction = input.didTapDeleteButton
            .withUnretained(self)
            .map { owner, action in
                if action == .delete {
                    owner.reviewUseCase.delete(owner.review)
                }
                
                return action
            }
        
        let reviewToSend = input.didTapModificationButton
            .withUnretained(self)
            .map { owner, _ in
                owner.review
            }
        
        return Output(
            reviewCellViewModelItem: reviewCellViewModelItem,
            deleteAlertAction: deleteAlertAction,
            reviewToSend: reviewToSend
        )
    }
}
