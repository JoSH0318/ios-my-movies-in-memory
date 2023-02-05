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
        let reviewWithPoster: Observable<(UIImage?, Review)>
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
        let review = input.setupCell
            .share()
        
        let posterImage = review
            .withUnretained(self)
            .flatMap { owner, review in
                owner.imageManager
                    .downloadImage(review.posterPath, owner.downloadTaskToken)
                    .asObservable()
            }
        
        let reviewWithPoster = Observable.combineLatest(posterImage, review)
        
        return Output(reviewWithPoster: reviewWithPoster)
    }
    
    func onPrepareForReuse() {
        imageManager.cancelTask(downloadTaskToken)
    }
}
