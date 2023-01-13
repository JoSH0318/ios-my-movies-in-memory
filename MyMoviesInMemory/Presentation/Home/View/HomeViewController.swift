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
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    init(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View LifeCycle
    
    override func loadView() {        
        view = homeView
    }
    
    // MARK: - Bind
    
    private func bind() {
        let viewDidLoadEvent = Observable.just(())
        let input = HomeViewModel.Input(
            viewDidLoadEvent: viewDidLoadEvent,
            didTapRefreshButton: .never()
        )
        
        viewModel.transform(input)
            .reviews
            .bind(to: homeView.reviewCollectionView.rx.items(
                cellIdentifier: MovieReviewCell.identifier,
                cellType: MovieReviewCell.self
            )) { index, item, cell in
                cell.bind(item)
            }
            .disposed(by: disposeBag)
    }
}
