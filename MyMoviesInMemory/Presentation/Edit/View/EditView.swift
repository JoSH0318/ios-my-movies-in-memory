//
//  EditView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/01.
//

import SnapKit

final class EditView: UIView {
    
    // MARK: - Constant
    
    private enum FontSize {
        static let title: CGFloat = 16.0
    }
    
    // MARK: - Properties
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let summaryView = SummaryView()
    
    private(set) var starRatingView = StarRatingView()
    
    private(set) var shortCommentTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .left
        textView.textColor = .systemGray
        textView.font = .systemFont(ofSize: FontSize.title)
        textView.textContainerInset = .init(
            top: 16,
            left: 16,
            bottom: 16,
            right: 16
        )
        textView.layer.cornerRadius = 16
        textView.backgroundColor = .MWhite
        textView.clipsToBounds = true
        return textView
    }()
    
    private(set) var shortCommentTextCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/20"
        label.font = .systemFont(ofSize: FontSize.title)
        label.textColor = .systemGray3
        label.textAlignment = .center
        return label
    }()
    
    private(set) var commentTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .left
        textView.textColor = .systemGray
        textView.font = .systemFont(ofSize: FontSize.title)
        textView.textContainerInset = .init(
            top: 16,
            left: 16,
            bottom: 16,
            right: 16
        )
        textView.layer.cornerRadius = 16
        textView.backgroundColor = .MWhite
        textView.clipsToBounds = true
        textView.setContentHuggingPriority(.init(1), for: .vertical)
        return textView
    }()
        
    private(set) var commentTextCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/700"
        label.font = .systemFont(ofSize: FontSize.title)
        label.textColor = .systemGray3
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configureContents(
        _ posterImage: UIImage?,
        _ movie: Movie)
    {
        summaryView.posterImageView.image = posterImage
        summaryView.titleLabel.text = movie.title
        summaryView.originalTitleLabel.text = movie.originalTitle
        summaryView.genreLabel.text = "\(movie.genres)"
        summaryView.releaseLabel.text = "\(movie.releaseDate) | \(movie.originalLanguage)"
        summaryView.ratingLabel.text = "\(movie.userRating)"
        summaryView.overviewLabel.text = movie.overview
    }
    
    func dragStarSlider(_ rating: Int) {
        starRatingView.dragStarSlider(rating)
    }
    
    private func configureView() {
        backgroundColor = .MBeige
    }
    
    private func configureUI() {
        addSubview(mainStackView)

        mainStackView.addArrangedSubview(summaryView)
        mainStackView.addArrangedSubview(starRatingView)
        mainStackView.addArrangedSubview(shortCommentTextView)
        mainStackView.addArrangedSubview(commentTextView)
        
        shortCommentTextView.addSubview(shortCommentTextCountLabel)
        commentTextView.addSubview(commentTextCountLabel)
    }
    
    private func configureConstraints() {
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
        
        summaryView.snp.makeConstraints {
            $0.height.equalTo(self.snp.height).multipliedBy(0.2)
        }
        
        starRatingView.snp.makeConstraints {
            $0.height.equalTo(self.snp.height).multipliedBy(0.07)
        }
        
        shortCommentTextView.snp.makeConstraints {
            $0.height.equalTo(self.snp.height).multipliedBy(0.1)
        }
        
        shortCommentTextCountLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().offset(-8)
        }
        
        commentTextCountLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().offset(-8)
        }
    }
}
