//
//  SearchCoordinator.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/14.
//

import UIKit

final class SearchCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    private let movieUseCase: MovieUseCaseType
    private let reviewUseCase: ReviewUseCaseType
    
    init(
        navigationController: UINavigationController,
        parentCoordinator: Coordinator,
        movieUseCase: MovieUseCaseType,
        reviewUseCase: ReviewUseCaseType
    ) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.movieUseCase = movieUseCase
        self.reviewUseCase = reviewUseCase
    }
    
    func start() {
        let searchViewModel = SearchViewModel(movieUseCase: movieUseCase)
        let searchViewController = SearchViewController(searchViewModel, self)
        self.navigationController.pushViewController(
            searchViewController,
            animated: true
        )
    }
    
    func presentSearchDetailView(with movie: Movie) {
        let searchDetailCoordinator = SearchDetailCoordinator(
            navigationController: self.navigationController,
            parentCoordinator: self,
            movieUseCase: movieUseCase,
            reviewUseCase: reviewUseCase
        )
        self.childCoordinators.append(searchDetailCoordinator)
        searchDetailCoordinator.start(with: movie)
    }
}
