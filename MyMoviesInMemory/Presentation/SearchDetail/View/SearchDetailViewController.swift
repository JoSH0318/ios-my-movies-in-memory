//
//  SearchDetailViewController.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/18.
//

import SnapKit
import RxSwift

final class SearchDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: SearchDetailViewModel
    private let coordinator: SearchDetailCoordinator
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
        
        configureConstraints()
        configureEditButton()
        bind()
    }
    
    // MARK: - Bind
    
    func bind() {
        let didShowViewEvent = Observable.just(())
        let didTapEditButtonEvent = editBarButton.rx.tap.asObservable()
        let input = SearchDetailViewModel.Input(
            didShowView: didShowViewEvent,
            didTapEditButton: didTapEditButtonEvent
        )
        let output = viewModel.transform(input)
        
        output
            .movieWithPoster
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, movieWithPoster in
                owner.searchDetailView
                    .setupContents(
                        movieWithPoster.0,
                        movieWithPoster.1
                    )
            })
            .disposed(by: disposeBag)
        
        output
            .movieToSend
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, movieWithPoster in
                owner.coordinator
                    .presentEditView(
                        with: movieWithPoster.0,
                        movieWithPoster.1
                    )
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    
    private func configureEditButton() {
        navigationItem.rightBarButtonItem = editBarButton
    }
    
    private func configureConstraints() {
        
        
    }
}
