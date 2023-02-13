//
//  SearchDetailCoordinator.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/18.
//

import UIKit

final class SearchDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    private let movieUseCase: MovieUseCaseType
    private let reviewUseCase: ReviewUseCaseType
    
    init(
        navigationController: UINavigationController,
        parentCoordinator: Coordinator,
        movieUseCase: MovieUseCaseType,
        reviewUseCase: ReviewUseCaseType
    ) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.movieUseCase = movieUseCase
        self.reviewUseCase = reviewUseCase
    }
    
    func start(with movie: Movie) {
        let searchDetailViewModel = SearchDetailViewModel(
            movieUseCase: movieUseCase,
            movie: movie
        )
        let searchDetailViewController = SearchDetailViewController(
            searchDetailViewModel,
            self
        )
        self.navigationController.pushViewController(
            searchDetailViewController,
            animated: true
        )
    }
    
    func presentEditView(posterImage: UIImage?, movie: Movie) {
        let editCoordinator = EditCoordinator(
            navigationController: self.navigationController,
            parentCoordinator: self,
            reviewUseCase: reviewUseCase
        )
        let defaultReview = movie.toDefaultReview()
        
        self.childCoordinators.append(editCoordinator)
        editCoordinator.start(
            review: defaultReview,
            posterImage: posterImage
        )
    }
}
