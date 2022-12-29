//
//  NetworkRepository.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/29.
//

import Foundation
import RxSwift

protocol NetworkRepository {
    func fetchMovies(title: String) -> Observable<[Movie]>
}
