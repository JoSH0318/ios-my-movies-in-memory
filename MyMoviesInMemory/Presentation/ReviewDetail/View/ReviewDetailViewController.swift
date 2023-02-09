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
    
    override func loadView() {
        view = reviewDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    private func bind() {
        let didShowEvent = Observable.just(())
        let input = ReviewDetailViewModel.Input(didShowView: didShowEvent)
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
    }
}
