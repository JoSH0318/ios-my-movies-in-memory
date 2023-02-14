//
//  EditViewController.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/30.
//

import UIKit
import RxSwift

class RecordViewController: UIViewController {

    // MARK: - Contant
    
    private enum PlaceHolder {
        static let shortCommentPlaceHolder = "📝 나만의 한줄평 📝"
        static let commentPlaceHolder = "📝 나만의 영화 감상평을 작성해보세요 📝"
    }
    
    // MARK: - Properties
    
    private let editView = EditView()
    private let viewModel: RecordViewModel
    private let coordinator: RecordCoordinator
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
        _ viewModel: RecordViewModel,
        _ coordinator: RecordCoordinator
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
        view = editView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureEditButton()
        bind()
        setupPlaceHolder()
    }
    
    // MARK: - Bind
    
    private func bind() {
        let didShowViewEvent = Observable.just(())
        
        let draggedValue = editView.starRatingView
            .starRatingSlider.rx.value
            .asObservable()
        
        let didTapSaveButtonEvent = saveBarButton.rx.tap
            .withUnretained(self)
            .map { owner, _ in
                (
                    owner.editView.starRatingView.starRatingSlider.value,
                    owner.editView.shortCommentTextView.text,
                    owner.editView.commentTextView.text
                )
            }
        
        let didEditCommentViewEvent = editView
            .commentTextView.rx.didBeginEditing
            .withUnretained(self)
            .map { owner, _ in
                let commentText = owner.editView.commentTextView.text
                let placeHolder = PlaceHolder.commentPlaceHolder
                return (commentText, placeHolder)
            }
        
        let didEditShortCommentViewEvent = editView
            .shortCommentTextView.rx.didBeginEditing
            .withUnretained(self)
            .map { owner, _ in
                let shortCommentText = owner.editView.commentTextView.text
                let placeHolder = PlaceHolder.commentPlaceHolder
                return (shortCommentText, placeHolder)
            }
        
        let input = RecordViewModel.Input(
            didShowView: didShowViewEvent,
            didDragStarRating: draggedValue,
            didTapSaveButton: didTapSaveButtonEvent,
            didEditCommentView: didEditCommentViewEvent,
            didEditShortCommentView: didEditShortCommentViewEvent
        )
        let output = viewModel.transform(input)
        
        output
            .editViewModelItem
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, item in
                owner.editView.setupContents(item)
            })
            .disposed(by: disposeBag)
        
        output
            .starRating
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, rating in
                owner.editView.dragStarSlider(rating)
            })
            .disposed(by: disposeBag)
        
        output
            .commentViewEditingStatus
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.editView.commentTextView.text = nil
                owner.editView.commentTextView.textColor = .black
            })
            .disposed(by: disposeBag)
        
        output
            .shortCommentViewEditingStatus
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.editView.shortCommentTextView.text = nil
                owner.editView.shortCommentTextView.textColor = .black
            })
            .disposed(by: disposeBag)
        
        output
            .popRecordViewTrigger
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.coordinator.popEditView()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    
    private func configureEditButton() {
        navigationItem.rightBarButtonItem = saveBarButton
    }
    
    private func setupPlaceHolder() {
        editView.shortCommentTextView.textColor = .systemGray
        editView.commentTextView.textColor = .systemGray
        editView.shortCommentTextView.text = PlaceHolder.shortCommentPlaceHolder
        editView.commentTextView.text = PlaceHolder.commentPlaceHolder
    }
}
