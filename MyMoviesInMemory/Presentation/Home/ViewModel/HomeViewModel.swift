//
//  HomeViewModel.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/29.
//

import Foundation

final class HomeViewModel {
    private let movieUseCase: MovieUseCaseType
    
    init(movieUseCase: MovieUseCaseType) {
        self.movieUseCase = movieUseCase
    }
}
