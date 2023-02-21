//
//  ReviewRepository.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/09.
//

import Foundation
import RxSwift

final class ReviewRepository: CoreDataRepository {
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func save(_ review: Review) {
        coreDataManager.create(with: review)
    }
    
    func fetchReviews() -> Observable<[Review]> {
        return coreDataManager.fetchAll()
            .map {
                $0.map { $0.toDomain() }
            }
    }
    
    func fetchReview(_ id: String) -> Observable<Review> {
        return coreDataManager.fetchOne(id)
            .map { $0.toDomain() }
    }
    
    func update(_ review: Review) {
        coreDataManager.update(with: review)
    }
    
    func delete(_ review: Review) {
        coreDataManager.delete(review)
    }
}
