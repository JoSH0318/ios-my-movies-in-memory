//
//  HomeCoordinator.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/04.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    private let useCase: ReviewUseCaseType
    
    init(
        navigationController: UINavigationController,
        parentCoordinator: Coordinator,
        useCase: ReviewUseCaseType
    ) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.useCase = useCase
    }
    
    func start() {
        let homeViewModel = HomeViewModel(reviewUseCase: useCase)
        let homeViewController = HomeViewController(
            homeViewModel,
            homeCoordinator: self
        )
        self.navigationController.pushViewController(
            homeViewController,
            animated: true
        )
    }
    
    func pushReviewDetailView(_ ReviewItem: ReviewCellViewModelItem) {
        let reviewDetailModel = ReviewDetailViewModel()
        let reviewDetailViewController = ReviewDetailViewController()
        self.navigationController.pushViewController(reviewDetailViewController, animated: true)
    }
}
