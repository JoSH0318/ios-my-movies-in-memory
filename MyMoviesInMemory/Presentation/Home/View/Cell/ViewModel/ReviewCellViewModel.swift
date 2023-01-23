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
        let setupCell: Observable<Review>
    }
    
    // MARK: - Output
    
    struct Output {
        let reviewItem: Observable<ReviewCellViewModelItem>
    }
    
    // MARK: - Properties
    
    private let imageManager = ImageManager.shared
    private let downloadTaskToken: UInt
    
    // MARK: - Initializer
    
    init() {
        self.downloadTaskToken = imageManager.nextToken()
    }
    
    // MARK: - Methods
    
    func transform(_ input: Input) -> Output {
        let setupCellEvent = input.setupCell
            .share()
        
        let posterImage = setupCellEvent
            .withUnretained(self)
            .flatMap { owner, review in
                owner.imageManager
                    .downloadImage(review.imageUrl, owner.downloadTaskToken)
                    .asObservable()
            }
        
        let reviewItem = Observable
            .combineLatest(
                setupCellEvent,
                posterImage
            )
            .map { review, image in
                review.toCellViewModelItem(with: image)
            }
        
        return Output(reviewItem: reviewItem)
    }
    
    func onPrepareForReuse() {
        imageManager.cancelTask(downloadTaskToken)
    }
}
