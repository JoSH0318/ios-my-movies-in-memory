//
//  EditView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/01.
//

import SnapKit

final class EditView: UIView {
    
    // MARK: - Properties
    
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
    
    private(set) var shortCommentTextView: UITextView = {
        let textView = UITextView()
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
    
    private(set) var shortCommentTextCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/20"
        label.font = UIFont().fontWith(.small)
        label.textColor = .systemGray3
        label.textAlignment = .center
        return label
    }()
    
    private(set) var commentTextView: UITextView = {
        let textView = UITextView()
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
        
    private(set) var commentTextCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/700"
        label.font = UIFont().fontWith(.small)
        label.textColor = .systemGray3
        label.textAlignment = .center
        return label
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
        summaryView.genreLabel.text = item.genres
        summaryView.releaseLabel.text = item.release
        summaryView.ratingLabel.text = item.rating
        summaryView.overviewLabel.text = item.overview
        shortCommentTextView.text = item.shortComment
        commentTextView.text = item.comment
    }
    
    func dragStarSlider(_ rating: Int) {
        starRatingView.dragStarSlider(rating)
    }
    
    private func configureLayout() {
        backgroundColor = .MBeige
        
        let shadowView = ShadowView()
        
        addSubview(mainStackView)
        shadowView.addSubview(summaryView)
        
        mainStackView.addArrangedSubview(shadowView)
        mainStackView.addArrangedSubview(starRatingView)
        mainStackView.addArrangedSubview(shortCommentTextView)
        mainStackView.addArrangedSubview(commentTextView)
        
        shortCommentTextView.addSubview(shortCommentTextCountLabel)
        commentTextView.addSubview(commentTextCountLabel)
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(Design.mainStackMargin)
            $0.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
                .offset(-Design.mainStackMargin)
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
        
        shortCommentTextCountLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().offset(-Design.defaultMargin)
        }
        
        commentTextCountLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().offset(-Design.defaultMargin)
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
