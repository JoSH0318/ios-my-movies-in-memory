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
        
        configureEditButton()
        bind()
    }
    
    // MARK: - Bind
    
    func bind() {
        let didShowViewEvent = Observable.just(())
        let didTapEditButtonEvent = editBarButton.rx.tap.asObservable()
        let didScrollEvent = searchDetailView.detailScrollView.rx.contentOffset
            .asObservable()
        
        let input = SearchDetailViewModel.Input(
            didShowView: didShowViewEvent,
            didTapEditButton: didTapEditButtonEvent,
            didScroll: didScrollEvent
        )
        let output = viewModel.transform(input)
        
        output
            .movieDetailItem
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, item in
                owner.searchDetailView
                    .setupContents(item)
            })
            .disposed(by: disposeBag)
        
        output
            .detailToSend
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, movieToSend in
                owner.coordinator
                    .presentRecordView(movieDetail: movieToSend)
            })
            .disposed(by: disposeBag)
        
        output.contentOffsetY
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, contentOffsetY in
                let isReachContentOffset = owner
                    .searchDetailView
                    .posterImageView
                    .bounds
                    .height < contentOffsetY
                owner.changeNavigationBarColor(isReachContentOffset)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    
    private func configureEditButton() {
        navigationItem.rightBarButtonItem = editBarButton
    }
    
    private func changeNavigationBarColor(_ isScrollUp: Bool) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.navigationController?
                .navigationBar
                .backgroundColor = isScrollUp ? .MBeige : .clear
        }
    }
}
