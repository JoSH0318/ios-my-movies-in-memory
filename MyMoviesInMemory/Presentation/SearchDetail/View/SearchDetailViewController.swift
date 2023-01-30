//
//  SearchDetailViewController.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/18.
//

import UIKit
import RxSwift

final class SearchDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let coordinator: SearchDetailCoordinator
    private let viewModel: SearchDetailViewModel
    private let disposeBag = DisposeBag()
    private let searchDetailView = SearchDetailView()
    private let editBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil)
        barButtonItem.tintColor = .MGreen
        return barButtonItem
    }()
    
    // MARK: - Initializer
    
    init(
        _ viewModel: SearchDetailViewModel,
        _ coordinator: SearchDetailCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        
        bind()
        configureEditButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = searchDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    func bind() {
        let didShowViewEvent = Observable.just(())
        let didTapEditButtonEvent = editBarButton.rx.tap.asObservable()
        let input = SearchDetailViewModel.Input(
            didShowView: didShowViewEvent,
            didTapEditButton: didTapEditButtonEvent
        )
        
        viewModel.transform(input)
            .movieWithPoster
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, movieWithPoster in
                owner.searchDetailView
                    .configureContents(
                        movieWithPoster.0,
                        movieWithPoster.1
                    )
            })
            .disposed(by: disposeBag)
        
        viewModel.transform(input)
            .movie
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, movie in
//                owner.coordinator.
//                coordinator를 통해서 Edit 화면으로 이동하는 로직
            })
            .disposed(by: disposeBag)
    }
    
    private func configureEditButton() {
        navigationItem.rightBarButtonItem = editBarButton
    }
}
