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
    private let reviewUseCase: ReviewUseCaseType
    
    init(
        navigationController: UINavigationController,
        parentCoordinator: Coordinator,
        reviewUseCase: ReviewUseCaseType
    ) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.reviewUseCase = reviewUseCase
    }
    
    func start() {
        let homeViewModel = HomeViewModel(reviewUseCase: reviewUseCase)
        let homeViewController = HomeViewController(
            homeViewModel,
            self
        )
        self.navigationController.pushViewController(
            homeViewController,
            animated: true
        )
    }
    
    func pushReviewDetailView(_ Review: Review) {
        let reviewDetailModel = ReviewDetailViewModel()
        let reviewDetailViewController = ReviewDetailViewController()
        self.navigationController.pushViewController(reviewDetailViewController, animated: true)
    }
}
