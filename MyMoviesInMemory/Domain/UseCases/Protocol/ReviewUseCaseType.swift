//
//  ReviewUseCaseType.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/09.
//

import Foundation
import RxSwift

protocol ReviewUseCaseType {
    func fetchReviews() -> Observable<[MovieDAO]>
}
