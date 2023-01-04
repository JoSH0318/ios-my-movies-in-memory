//
//  HomeCoordinator.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/04.
//

import UIKit

final class HomeCoordinator: Coordinator {
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
        let homeViewModel = HomeViewModel(movieUseCase: useCase)
        let homeViewController = HomeViewController(homeViewModel)
        self.navigationController.pushViewController(homeViewController, animated: true)
    }
}
