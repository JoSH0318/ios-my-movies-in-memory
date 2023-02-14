//
//  ReviewDetailCoordinator.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/17.
//

import UIKit
import RxSwift

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
    
    func start(with review: Review) {
        let reviewDetailViewModel = ReviewDetailViewModel(
            reviewUseCase: reviewUseCase,
            review: review
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
    
    func dismissReviewDetailView() {
        navigationController.popViewController(animated: true)
        parentCoordinator?.removeChildCoordinator(child: self)
    }
    
    func showDeleteAlert() -> Observable<AlertActionType> {
        return Observable.create { [weak self] emitter in
            let cancelAction = UIAlertAction(
                title: "취소",
                style: .cancel
            ) { _ in
                emitter.onNext(.cancel)
                emitter.onCompleted()
            }

            let deleteAction = UIAlertAction(
                title: "삭제",
                style: .destructive
            ) { _ in
                emitter.onNext(.delete)
                emitter.onCompleted()
            }

            let alert = AlertBuilder.shared
                .setType(.alert)
                .setTitle("삭제할까요?")
                .setMessage("삭제하면 해당 리뷰는 삭제돼요!")
                .setActions([cancelAction, deleteAction])
                .apply()
            
            self?.navigationController.present(alert, animated: true)
            
            return Disposables.create {
                alert.dismiss(animated: true)
            }
        }
    }
    
    func presentModificationView(review: Review) {
        let modificationCoordinator = ModificationCoordinator(
            navigationController: self.navigationController,
            parentCoordinator: self,
            reviewUseCase: reviewUseCase
        )
        self.childCoordinators.append(modificationCoordinator)
        
        modificationCoordinator.start(with: review)
    }
}
