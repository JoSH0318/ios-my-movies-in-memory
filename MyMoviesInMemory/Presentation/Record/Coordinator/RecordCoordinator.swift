//
//  RecordCoordinator.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/30.
//

import UIKit

final class RecordCoordinator: Coordinator {
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
    
    func start(review: Review, posterImage: UIImage?) {
        let recordViewModel = RecordViewModel(
            reviewUseCase: reviewUseCase,
            review: review,
            posterImage: posterImage
        )
        
        let recordViewController = RecordViewController(
            recordViewModel,
            self
        )
        
        self.navigationController.pushViewController(
            recordViewController,
            animated: true
        )
    }
    
    func popEditView() {
        self.navigationController.popViewController(animated: true)
        self.parentCoordinator?.removeChildCoordinator(child: self)
    }
}
