//
//  EditCoordinator.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/30.
//

import UIKit

final class EditCoordinator: Coordinator {
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
    
    func start(with movie: Movie, _ posterImage: UIImage?) {
        let editViewModel = EditViewModel(
            reviewUseCase: reviewUseCase,
            movie: movie,
            posterImage: posterImage
        )
        
        let editViewController = EditViewController(
            editViewModel,
            self
        )
        
        self.navigationController.pushViewController(
            editViewController,
            animated: true
        )
    }
}
