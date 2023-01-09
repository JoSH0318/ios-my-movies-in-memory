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
    
    func fetchReviews() -> Observable<[MovieDAO]> {
        return coreDataManager.fetch()
    }
}
