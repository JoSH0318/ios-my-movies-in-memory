//
//  HomeViewModel.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/29.
//

import Foundation
import RxSwift
import RxRelay

final class HomeViewModel {
    
    // MARK: - Input
    
    struct Input {
        let didShowView: Observable<Void>
    }
    
    // MARK: - Output
    
    struct Output {
        let reviews: Observable<[Review]>
    }
    
    // MARK: - Properties
    
    private let reviewUseCase: ReviewUseCaseType
    
    // MARK: - Initializer
    
    init(reviewUseCase: ReviewUseCaseType) {
        self.reviewUseCase = reviewUseCase
    }
    
    // MARK: - Methods
    
    func transform(_ input: Input) -> Output {
        let reviews = input.didShowView
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.reviewUseCase.fetchReviews()
            }
            .filter { !$0.isEmpty }
        
        return Output(reviews: reviews)
    }
}
