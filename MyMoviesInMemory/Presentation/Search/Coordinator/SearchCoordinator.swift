//
//  SearchCoordinator.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/14.
//

import UIKit

final class SearchCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinators: Coordinator?
    var childCoordinators: [Coordinator] = []
    private let useCase: MovieUseCaseType
    
    init(
        navigationController: UINavigationController,
        parentCoordinators: Coordinator,
        useCase: MovieUseCaseType
    ) {
        self.navigationController = navigationController
        self.parentCoordinators = parentCoordinators
        self.useCase = useCase
    }
    
    func start() {
        let searchViewModel = SearchViewModel(movieUseCase: useCase)
        let searchViewController = SearchViewController(searchViewModel, self)
        self.navigationController.pushViewController(
            searchViewController,
            animated: true
        )
    }
}
