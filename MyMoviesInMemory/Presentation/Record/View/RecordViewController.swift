//
//  EditViewController.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/30.
//

import UIKit
import RxSwift

class RecordViewController: UIViewController {
    
    // MARK: - Properties
    
    private let recordView = EditView()
    private let viewModel: RecordViewModel
    private let coordinator: RecordCoordinator
    private let disposeBag = DisposeBag()
    private let saveBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: nil,
            action: nil
        )
        barButtonItem.tintColor = .MGray
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
        view = recordView
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
        let draggedValue = recordView.starRatingView
            .starRatingSlider.rx.value
            .asObservable()
        let didTapSaveButtonEvent = saveBarButton.rx.tap
            .withUnretained(self)
            .map { owner, _ in
                (
                    owner.recordView.starRatingView.starRatingSlider.value,
                    owner.recordView.shortCommentTextView.text,
                    owner.recordView.commentTextView.text
                )
            }
        let didEditCommentViewEvent = recordView
            .commentTextView.rx.didBeginEditing
            .withUnretained(self)
            .map { owner, _ in
                let commentText = owner.recordView.commentTextView.text
                let placeHolder = PlaceHolder.commentPlaceHolder
                return (commentText, placeHolder)
            }
        let didEditShortCommentViewEvent = recordView
            .shortCommentTextView.rx.didBeginEditing
            .withUnretained(self)
            .map { owner, _ in
                let shortCommentText = owner.recordView.commentTextView.text
                let placeHolder = PlaceHolder.commentPlaceHolder
                return (shortCommentText, placeHolder)
            }
        let willShowKeyboardEvent = Observable
            .from([
                NotificationCenter.default.rx
                    .notification(UIResponder.keyboardWillShowNotification),
                NotificationCenter.default.rx
                    .notification(UIResponder.keyboardWillHideNotification)
            ])
            .merge()
        
        let input = RecordViewModel.Input(
            didShowView: didShowViewEvent,
            didDragStarRating: draggedValue,
            didTapSaveButton: didTapSaveButtonEvent,
            didEditCommentView: didEditCommentViewEvent,
            didEditShortCommentView: didEditShortCommentViewEvent,
            willShowKeyboard: willShowKeyboardEvent
        )
        let output = viewModel.transform(input)
        
        output
            .editViewModelItem
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, item in
                owner.recordView.setupContents(item)
            })
            .disposed(by: disposeBag)
        
        output
            .starRating
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, rating in
                owner.recordView.dragStarSlider(rating)
            })
            .disposed(by: disposeBag)
        
        output
            .commentViewEditingStatus
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.recordView.commentTextView.text = nil
                owner.recordView.commentTextView.textColor = .black
            })
            .disposed(by: disposeBag)
        
        output
            .shortCommentViewEditingStatus
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.recordView.shortCommentTextView.text = nil
                owner.recordView.shortCommentTextView.textColor = .black
            })
            .disposed(by: disposeBag)
        
        output
            .popRecordViewTrigger
            .withUnretained(self)
            .bind(onNext: { owner, _ in
                owner.coordinator.popEditView()
            })
            .disposed(by: disposeBag)
        
        output
            .keyboardHeight
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, keyboardHeight in
                let safeAreaBottom = owner.recordView.safeAreaInsets.bottom
                let height = keyboardHeight > 0.0 ? (keyboardHeight - safeAreaBottom) : 0.0
                owner.recordView.changeBottomConstraint(height)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    
    private func configureEditButton() {
        navigationItem.rightBarButtonItem = saveBarButton
    }
    
    private func setupPlaceHolder() {
        recordView.shortCommentTextView.textColor = .systemGray
        recordView.commentTextView.textColor = .systemGray
        recordView.shortCommentTextView.text = PlaceHolder.shortCommentPlaceHolder
        recordView.commentTextView.text = PlaceHolder.commentPlaceHolder
    }
}

extension RecordViewController {
    private enum PlaceHolder {
        static let shortCommentPlaceHolder = "📝 나만의 한줄평 📝"
        static let commentPlaceHolder = "📝 나만의 영화 감상평을 작성해보세요 📝"
    }
}
