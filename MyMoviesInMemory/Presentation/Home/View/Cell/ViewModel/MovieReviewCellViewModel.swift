//
//  MovieReviewCellViewModel.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/10.
//

import UIKit
import RxSwift

final class MovieReviewCellViewModel {
    
    // MARK: - Input
    
    struct Input {
        let setupCell: Observable<Review>
    }
    
    // MARK: - Output
    
    struct Output {
        let posterImage: Observable<UIImage?>
        let review: Observable<MovieReviewCellViewModelItem>
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
        
        let posterImageUrl = setupCellEvent
            .withUnretained(self)
            .flatMap { owner, review in
                owner.imageManager.fetchPosterImageUrl(review.subtitle)
            }
        
        let posterImage = posterImageUrl
            .withUnretained(self)
            .flatMap { owner, imageUrl in
                owner.imageManager
                    .downloadImage(imageUrl, owner.downloadTaskToken)
                    .asObservable()
            }
        
        let review = setupCellEvent
            .map { $0.toCellViewModelItem() }
        
        return Output(posterImage: posterImage, review: review)
    }
    
    func onPrepareForReuse() {
        imageManager.cancelTask(downloadTaskToken)
    }
}
