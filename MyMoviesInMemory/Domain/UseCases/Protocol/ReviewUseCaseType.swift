//
//  ReviewUseCaseType.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/09.
//

import Foundation
import RxSwift

protocol ReviewUseCaseType {
    func save(_ review: Review)
    func fetchReviews() -> Observable<[Review]>
    func fetchReview(_ id: String) -> Observable<Review>
    func update(_ review: Review)
    func delete(_ review: Review)
}
