//
//  SearchDetailCoordinator.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/18.
//

import UIKit

final class SearchDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinators: Coordinator?
    var childCoordinators: [Coordinator] = []
    private let useCase: MovieUseCaseType
    
    init(
        navigationController: UINavigationController,
        parentCoordinator: Coordinator,
        useCase: MovieUseCaseType
    ) {
        self.navigationController = navigationController
        self.parentCoordinators = parentCoordinator
        self.useCase = useCase
    }
    
    func start(with movie: Movie) {
        let searchDetailViewModel = SearchDetailViewModel(
            movieUseCase: useCase,
            movie: movie
        )
        let searchDetailViewController = SearchDetailViewController(
            searchDetailViewModel,
            self
        )
        self.navigationController.pushViewController(
            searchDetailViewController,
            animated: true
        )
    }
}
