//
//  ModificationCoordinator.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/13.
//

import UIKit

final class ModificationCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    private let reviewUseCase: ReviewUseCaseType
    
    init(
        navigationController: UINavigationController,
        parentCoordinator: Coordinator?,
        reviewUseCase: ReviewUseCaseType
    ) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.reviewUseCase = reviewUseCase
    }
    
    func start(review: Review, posterImage: UIImage?) {
        let modificationViewModel = ModificationViewModel(
            reviewUseCase: reviewUseCase,
            review: review,
            posterImage: posterImage
        )
        let modificationViewController = ModificationViewController(
            modificationViewModel,
            self
        )
        
        self.navigationController.pushViewController(
            modificationViewController,
            animated: true
        )
    }
}
