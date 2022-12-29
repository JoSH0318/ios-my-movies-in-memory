//
//  MovieUseCaseType.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/29.
//

import Foundation

protocol MovieUseCaseType {
    func fetchMovies(title: String) -> Observable<[Movie]>
}
