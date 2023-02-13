//
//  ReviewDetailViewController.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/17.
//

import UIKit
import RxSwift

final class ReviewDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let reviewDetailView = ReviewDetailView()
    private let viewModel: ReviewDetailViewModel
    private var disposeBag = DisposeBag()
    private let coordinator: ReviewDetailCoordinator
    private let deleteBarButton: UIBarButtonItem = {
        let deleteImage = UIImage(systemName: "trash")
        let barButtonItem = UIBarButtonItem(
            image: deleteImage,
            style: .plain,
            target: nil,
            action: nil
        )
        barButtonItem.tintColor = .MGreen
        return barButtonItem
    }()
    private let modificationBarButton: UIBarButtonItem = {
        let modificationImage = UIImage(systemName: "square.and.pencil")
        let barButtonItem = UIBarButtonItem(
            image: modificationImage,
            style: .plain,
            target: nil,
            action: nil
        )
        barButtonItem.tintColor = .MGreen
        return barButtonItem
    }()
    
    // MARK: - Initializer
    
    init(
        viewModel: ReviewDetailViewModel,
        coordinator: ReviewDetailCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = reviewDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        bind()
    }
    
    // MARK: - Bind
    
    private func bind() {
        let didShowEvent = Observable.just(())
        let didTapDeleteButton = deleteBarButton.rx.tap
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.coordinator.showDeleteAlert()
            }
        let didTapModificationButton = modificationBarButton.rx.tap
            .asObservable()
        
        let input = ReviewDetailViewModel.Input(
            didShowView: didShowEvent,
            didTapDeleteButton: didTapDeleteButton,
            didTapModificationButton: didTapModificationButton
        )
        let output = viewModel.transform(input)
        
        output.reviewWithPoster
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, reviewWithPoster in
                owner.reviewDetailView
                    .setupContents(
                        reviewWithPoster.0,
                        reviewWithPoster.1
                    )
            })
            .disposed(by: disposeBag)
        
        output.deleteAlertAction
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, action in
                switch action {
                case .delete:
                    owner.coordinator.dismissReviewDetailView()
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        output.reviewToSend
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, reviewToSend in
                owner.coordinator.presentModificationView(
                    posterImage: reviewToSend.0,
                    review: reviewToSend.1
                )
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItems = [modificationBarButton, deleteBarButton]
    }
}
