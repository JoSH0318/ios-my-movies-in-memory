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

    func fetchReviews() -> Observable<[MovieDAO]> {
        return repository.fetchReviews()
    }
}
