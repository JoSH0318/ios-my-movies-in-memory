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
    
    // MARK: - Initializer
    
    init(
        _ viewModel: SearchDetailViewModel,
        _ coordinator: SearchDetailCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        
        bind()
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
        let input = SearchDetailViewModel.Input(didShowView: didShowViewEvent)
        
        viewModel.transform(input)
            .posterImage
            .withUnretained(self)
            .bind(onNext: { owner, image in
                owner.searchDetailView.configurePosterImage(image)
            })
            .disposed(by: disposeBag)
        
        viewModel.transform(input)
            .movie
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, movie in
                owner.searchDetailView.configureContents(movie)
            })
            .disposed(by: disposeBag)
    }
}
