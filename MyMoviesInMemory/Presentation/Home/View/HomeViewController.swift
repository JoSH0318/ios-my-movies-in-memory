//
//  HomeViewController.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/29.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let homeView = HomeView()
    private let viewModel: HomeViewModel
    private var disposeBag = DisposeBag()
    private let coordinator: HomeCoordinator
    
    // MARK: - Initializer
    
    init(
        _ viewModel: HomeViewModel,
        _ coordinator: HomeCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View LifeCycle
    
    override func loadView() {        
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        disposeBag = DisposeBag()
        bind()
    }
    
    // MARK: - Bind
    
    private func bind() {
        let didShowViewEvent = Observable.just(())
        let input = HomeViewModel.Input(didShowView: didShowViewEvent)
        let output = viewModel.transform(input)
        
        output
            .reviews
            .bind(to: homeView.reviewCollectionView.rx.items(
                cellIdentifier: MovieReviewCell.identifier,
                cellType: MovieReviewCell.self
            )) { index, item, cell in
                cell.bind(item)
            }
            .disposed(by: disposeBag)

        homeView.reviewCollectionView.rx.modelSelected(Review.self)
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, item in
                owner.coordinator.presentSearchDetailView(with: item)
            })
            .disposed(by: disposeBag)
    }
}
