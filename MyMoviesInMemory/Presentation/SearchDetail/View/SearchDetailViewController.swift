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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
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
    
    // MARK: - Methods
    
    func bind() {
//        let input = Observable.just(())
//        viewModel.transform(input)
//            .movie
//            .
    }
    
}
