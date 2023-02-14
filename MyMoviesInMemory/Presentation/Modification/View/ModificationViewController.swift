//
//  ModificationViewController.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/13.
//

import RxSwift

class ModificationViewController: UIViewController {

    // MARK: - Properties
    
    private let modificationView = EditView()
    private let viewModel: ModificationViewModel
    private let coordinator: ModificationCoordinator
    private let disposeBag = DisposeBag()
    private let saveBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: nil,
            action: nil
        )
        barButtonItem.tintColor = .MGreen
        return barButtonItem
    }()
    
    // MARK: - Initializer
    
    init(
        _ viewModel: ModificationViewModel,
        _ coordinator: ModificationCoordinator
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
        view = modificationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureEditButton()
        bind()
    }
    
    // MARK: - Bind
    
    private func bind() {
        let viewDidLoadEvent = Observable.just(())
        let draggedValue = modificationView
            .starRatingView
            .starRatingSlider
            .rx
            .value
            .asObservable()
        let didTapSaveButtonEvent = saveBarButton.rx.tap
            .withUnretained(self)
            .map { owner, _ in
                EditViewModelItem(
                    personalRating: owner.modificationView.starRatingView.starRatingSlider.value / 2,
                    shortComment: owner.modificationView.shortCommentTextView.text,
                    comment: owner.modificationView.commentTextView.text
                )
            }
        

        let input = ModificationViewModel.Input(
            didShowView: viewDidLoadEvent,
            didDragStarRating: draggedValue,
            didTapSaveButton: didTapSaveButtonEvent
        )
        let output = viewModel.transform(input)
        
        output
            .reviewWithPoster
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, reviewWithPoster in
                owner.modificationView.setupSummary(
                    reviewWithPoster.0,
                    reviewWithPoster.1
                )
                owner.modificationView.setupReview(reviewWithPoster.1)
            })
            .disposed(by: disposeBag)
        
        output
            .reviewWithPoster
            .compactMap { Float($0.1.personalRating) }
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, rating in
                owner.modificationView.starRatingView.starRatingSlider.value = rating * 2
            })
            .disposed(by: disposeBag)
        
        output
            .starRating
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, rating in
                owner.modificationView.dragStarSlider(rating)
            })
            .disposed(by: disposeBag)
        
        output
            .popModificationViewTrigger
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.coordinator.popModificationView()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    
    private func configureEditButton() {
        navigationItem.rightBarButtonItem = saveBarButton
    }
}
