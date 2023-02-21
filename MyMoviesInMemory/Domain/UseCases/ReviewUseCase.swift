//
//  ReviewUseCase.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/09.
//

import Foundation
import RxSwift

final class ReviewUseCase: ReviewUseCaseType {
    private let repository: CoreDataRepository
    
    init(repository: CoreDataRepository) {
        self.repository = repository
    }

    func save(_ review: Review) {
        repository.save(review)
    }
    
    func fetchReviews() -> Observable<[Review]> {
        return repository.fetchReviews()
    }
    
    func fetchReview(_ id: String) -> Observable<Review> {
        return repository.fetchReview(id)
    }
    
    func update(_ review: Review) {
        repository.update(review)
    }
    
    func delete(_ review: Review) {
        repository.delete(review)
    }
}
