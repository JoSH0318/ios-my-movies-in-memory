//
//  EditViewController.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/30.
//

import UIKit
import RxSwift

class EditViewController: UIViewController {

    // MARK: - Properties
    
    private let editView = EditView()
    private let viewModel: EditViewModel
    private let coordinator: EditCoordinator
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    init(
        _ viewModel: EditViewModel,
        _ coordinator: EditCoordinator
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
        view = editView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Methods
    func bind() {}
}
