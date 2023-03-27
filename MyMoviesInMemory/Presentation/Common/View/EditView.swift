//
//  EditView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/01.
//

import SnapKit

final class EditView: UIView {
    
    // MARK: - Properties
    
    private let editScrollView = UIScrollView()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Design.vStackMargin
        return stackView
    }()
    
    private let summaryView = SummaryView()
    
    private(set) var starRatingView: StarRatingView = {
        let view = StarRatingView()
        view.layer.applyShadow()
        return view
    }()
    
    private(set) var shortCommentTextView: ContentTextView = {
        let textView = ContentTextView()
        textView.textAlignment = .left
        textView.font = UIFont().fontWith(.medium)
        textView.textContainerInset = .init(
            top: Design.textViewInset,
            left: Design.textViewInset,
            bottom: Design.textViewInset,
            right: Design.textViewInset
        )
        textView.layer.cornerRadius = Design.cornerRadius
        textView.layer.applyShadow()
        textView.backgroundColor = .MWhite
        textView.clipsToBounds = false
        return textView
    }()
    
    private(set) var commentTextView: ContentTextView = {
        let textView = ContentTextView()
        textView.textAlignment = .left
        textView.font = UIFont().fontWith(.medium)
        textView.textContainerInset = .init(
            top: Design.textViewInset,
            left: Design.textViewInset,
            bottom: Design.textViewInset,
            right: Design.textViewInset
        )
        textView.layer.cornerRadius = Design.cornerRadius
        textView.layer.applyShadow()
        textView.backgroundColor = .MWhite
        textView.clipsToBounds = false
        textView.setContentHuggingPriority(.init(1), for: .vertical)
        return textView
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setupContents(_ item: EditViewModelItem) {
        summaryView.posterImageView.setImage(urlString: item.posterPath)
        summaryView.titleLabel.text = item.title
        summaryView.originalTitleLabel.text = item.originalTitle
        summaryView.genreStackView.contentLabel.text = item.genres
        summaryView.releaseStackView.contentLabel.text = item.release
        summaryView.ratingStackView.contentLabel.text = item.rating
        summaryView.overviewLabel.text = item.overview
        starRatingView.dragStarSlider(item.personalRatingOnTen)
        shortCommentTextView.text = item.shortComment
        commentTextView.text = item.comment
    }
    
    func dragStarSlider(_ rating: Int) {
        starRatingView.dragStarSlider(rating)
    }
    
    private func configureLayout() {
        backgroundColor = .MBeige
        
        let shadowView = ShadowView()
        
        addSubview(editScrollView)
        editScrollView.addSubview(mainStackView)
        shadowView.addSubview(summaryView)
        
        mainStackView.addArrangedSubview(shadowView)
        mainStackView.addArrangedSubview(starRatingView)
        mainStackView.addArrangedSubview(shortCommentTextView)
        mainStackView.addArrangedSubview(commentTextView)
        
        editScrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Design.defaultMargin)
            $0.bottom.equalToSuperview().offset(-Design.defaultMargin)
            $0.leading.equalToSuperview().offset(Design.mainStackMargin)
            $0.trailing.equalToSuperview().offset(-Design.mainStackMargin)
            $0.width.equalToSuperview().offset(-Design.mainStackMargin * 2)
        }
        
        shadowView.snp.makeConstraints {
            $0.height.equalTo(self.snp.height).multipliedBy(0.2)
        }
        
        summaryView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        starRatingView.snp.makeConstraints {
            $0.height.equalTo(self.snp.height).multipliedBy(0.07)
        }
        
        shortCommentTextView.snp.makeConstraints {
            $0.height.equalTo(self.snp.height).multipliedBy(0.1)
        }
        
        commentTextView.snp.makeConstraints {
            $0.height.equalTo(self.snp.height).multipliedBy(0.3)
        }
    }
    
    func changeBottomConstraint(_ keyboardHeight: CGFloat) {
        let contentInsets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: keyboardHeight,
            right: 0
        )
        
        editScrollView.contentInset = contentInsets
        editScrollView.scrollIndicatorInsets = contentInsets
        editScrollView.contentOffset = CGPoint(x: .zero, y: keyboardHeight)
        
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
}

extension EditView {
    private enum Design {
        static let defaultMargin: CGFloat = 16.0
        static let mainStackMargin: CGFloat = 20.0
        
        static let textViewInset: CGFloat = 16.0
        static let vStackMargin: CGFloat = 16.0
        static let cornerRadius: CGFloat = 16.0
    }
}
