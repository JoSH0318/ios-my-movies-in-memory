//
//  ReviewDetailCoordinator.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/17.
//

import UIKit

final class ReviewDetailCoordinator: Coordinator {
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
    
    func start(with review: Review, _ posterImage: UIImage?) {
        let reviewDetailViewModel = ReviewDetailViewModel(
            reviewUseCase: reviewUseCase,
            review: review,
            posterImage: posterImage
        )
        
        let reviewDetailViewController = ReviewDetailViewController(
            viewModel: reviewDetailViewModel,
            coordinator: self
        )
        
        self.navigationController.pushViewController(
            reviewDetailViewController,
            animated: true
        )
    }
}
