//
//  AppCoordinator.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/10.
//

import UIKit

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    private let reviewUseCase: ReviewUseCaseType = ReviewUseCase(
        repository: ReviewRepository(coreDataManager: CoreDataManager()))
    private let movieUseCase: MovieUseCaseType = MovieUseCase(
        repository: MovieRepository(networkProvider: MovieNetworkProvider()))
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .MGreen
        tabBarController.tabBar.tintColor = .MWhite
        
        let homeNavigationController = UINavigationController()
        homeNavigationController.tabBarItem = UITabBarItem(
            title: "home",
            image: UIImage(systemName: "film"),
            tag: 0
        )
        homeNavigationController.navigationBar.tintColor = .MGreen
        
        let searchNavigationController = UINavigationController()
        searchNavigationController.tabBarItem = UITabBarItem(
            title: "search",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 1
        )
        searchNavigationController.navigationBar.tintColor = .MGreen
        
        tabBarController.viewControllers = [
            homeNavigationController,
            searchNavigationController
        ]
        navigationController.viewControllers = [tabBarController]
        navigationController.setNavigationBarHidden(true, animated: false)
        
        let homeCoordinator = HomeCoordinator(
            navigationController: homeNavigationController,
            parentCoordinator: self,
            reviewUseCase: reviewUseCase
        )
        
        let searchCoordinator = SearchCoordinator(
            navigationController: searchNavigationController,
            parentCoordinator: self,
            movieUseCase: movieUseCase,
            reviewUseCase: reviewUseCase
        )
        
        childCoordinators.append(homeCoordinator)
        childCoordinators.append(searchCoordinator)
        homeCoordinator.start()
        searchCoordinator.start()
    }
}
