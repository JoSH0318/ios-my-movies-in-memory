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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
