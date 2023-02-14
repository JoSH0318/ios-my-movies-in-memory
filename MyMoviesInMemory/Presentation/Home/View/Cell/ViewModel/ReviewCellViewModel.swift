//
//  ReviewCellViewModel.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/10.
//

import UIKit
import RxSwift

final class ReviewCellViewModel {
    
    // MARK: - Input
    
    struct Input {
        let didShowCell: Observable<Review>
    }
    
    // MARK: - Output
    
    struct Output {
        let reviewCellViewModelItem: Observable<ReviewCellViewModelItem>
    }
    
    // MARK: - Methods
    
    func transform(_ input: Input) -> Output {
        let reviewCellViewModelItem = input.didShowCell
            .withUnretained(self)
            .map { owner, review in
                ReviewCellViewModelItem(review: review)
            }
        
        return Output(reviewCellViewModelItem: reviewCellViewModelItem)
    }
}
