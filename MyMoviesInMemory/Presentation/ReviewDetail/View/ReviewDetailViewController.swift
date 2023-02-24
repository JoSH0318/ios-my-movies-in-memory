//
//  ReviewDetailViewController.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/17.
//

import UIKit
import RxSwift
import RxCocoa

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
        let didShowEvent = self.rx.viewWillAppear.asObservable()
        let didTapDeleteButton = deleteBarButton.rx.tap
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.coordinator.showDeleteAlert()
            }
        let didTapModificationButton = modificationBarButton.rx.tap
            .asObservable()
        let didScrollEvent = reviewDetailView.detailScrollView.rx.contentOffset
            .asObservable()
        
        let input = ReviewDetailViewModel.Input(
            didShowView: didShowEvent,
            didTapDeleteButton: didTapDeleteButton,
            didTapModificationButton: didTapModificationButton,
            didScroll: didScrollEvent
        )
        let output = viewModel.transform(input)
        
        output.reviewCellViewModelItem
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, item in
                owner.reviewDetailView.setupContents(item)
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
                owner.coordinator.presentModificationView(review: reviewToSend)
            })
            .disposed(by: disposeBag)
        
        output.contentOffsetY
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, contentOffsetY in
                let isReachContentOffset = owner
                    .reviewDetailView
                    .posterImageView
                    .bounds
                    .height < contentOffsetY
                owner.changeNavigationBarColor(isReachContentOffset)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItems = [
            modificationBarButton,
            deleteBarButton
        ]
    }
    
    private func changeNavigationBarColor(_ isScrollUp: Bool) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.navigationController?
                .navigationBar
                .backgroundColor = isScrollUp ? .MBeige : .clear
        }
    }
}
