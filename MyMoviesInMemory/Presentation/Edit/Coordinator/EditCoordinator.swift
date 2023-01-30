//
//  EditCoordinator.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/30.
//

import UIKit

final class EditCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinators: Coordinator?
    var childCoordinators: [Coordinator] = []
    private let useCase: ReviewUseCaseType
    
    init(
        navigationController: UINavigationController,
        parentCoordinator: Coordinator,
        useCase: ReviewUseCaseType
    ) {
        self.navigationController = navigationController
        self.parentCoordinators = parentCoordinator
        self.useCase = useCase
    }
    
    func start(with movie: Movie, _ posterImage: UIImage?) {
        let editViewModel = EditViewModel(
            reviewUseCase: useCase,
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
