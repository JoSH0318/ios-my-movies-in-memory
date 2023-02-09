//
//  ReviewDetailView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/06.
//

import SnapKit

final class ReviewDetailView: UIView {
    
    // MARK: - Properties
    
    private let detailScrollView = UIScrollView()
    
    private let detailContentView = UIView()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 16
        imageView.layer.applyShadow()
        return imageView
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        imageView.addSubview(blurEffectView)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .MWhite
        stackView.spacing = 16
        stackView.layer.cornerRadius = 16
        stackView.layer.applyShadow()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(
            top: 16,
            left: 16,
            bottom: 16,
            right: 16
        )
        return stackView
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.large, .heavy)
        return label
    }()
    
    private let originalTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .systemGray2
        label.font = UIFont().fontWith(.small)
        return label
    }()
    
    private let genreStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        return stackView
    }()
    
    private let genreTagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.medium, .bold)
        label.textColor = .systemGray
        label.text = "장르"
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.medium)
        label.setContentHuggingPriority(.init(1), for: .horizontal)
        return label
    }()
    
    private let releaseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        return stackView
    }()
    
    private let releaseTagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.medium, .bold)
        label.textColor = .systemGray
        label.text = "개봉"
        return label
    }()
    
    private let releaseLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.medium)
        label.setContentHuggingPriority(.init(1), for: .horizontal)
        return label
    }()
    
    private let ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        return stackView
    }()
    
    private let ratingTagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.medium, .bold)
        label.textColor = .systemGray
        label.text = "평점"
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.medium)
        label.setContentHuggingPriority(.init(1), for: .horizontal)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let starRatingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let starRatingTagLabel: UILabel = {
        let label = UILabel()
        label.text = "내 영화 점수:"
        label.font = UIFont().fontWith(.small)
        label.textColor = .systemGray
        return label
    }()
    
    private let starRatingView: StarRatingView = {
        let starRatingView = StarRatingView()
        starRatingView.layer.applyShadow()
        return starRatingView
    }()
    
    private let reviewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .MWhite
        stackView.spacing = 16
        stackView.layer.cornerRadius = 16
        stackView.layer.applyShadow()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(
            top: 16,
            left: 16,
            bottom: 16,
            right: 16
        )
        return stackView
    }()
    
    private let shortCommentTagLabel: UILabel = {
        let label = UILabel()
        label.text = "영화 한줄평:"
        label.font = UIFont().fontWith(.small)
        label.textColor = .systemGray
        return label
    }()
    
    private let shortCommentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont().fontWith(.medium)
        return label
    }()
    
    private let commentTagLabel: UILabel = {
        let label = UILabel()
        label.text = "영화 감상평:"
        label.font = UIFont().fontWith(.small)
        label.textColor = .systemGray
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont().fontWith(.medium)
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
    
    func setupContents(
        _ posterImage: UIImage?,
        _ review: Review)
    {
        posterImageView.image = posterImage
        backgroundImageView.image = posterImage
        titleLabel.text = review.title
        originalTitleLabel.text = review.originalTitle
        genreLabel.text = review.genres
        releaseLabel.text = "\(review.releaseDate) | \(review.originalLanguage)"
        ratingLabel.text = "\(review.userRating)"
        overviewLabel.text = review.overview

        starRatingView.dragStarSlider(Int(review.personalRating * 2))
        shortCommentLabel.text = review.shortComment
        commentLabel.text = review.comment
    }
    
    private func configureLayout() {
        backgroundColor = .MBeige
        
        addSubview(backgroundImageView)
        addSubview(detailScrollView)
        
        detailScrollView.addSubview(detailContentView)
        
        detailContentView.addSubview(posterImageView)
        detailContentView.addSubview(informationStackView)
        detailContentView.addSubview(starRatingView)
        detailContentView.addSubview(reviewStackView)
        
        informationStackView.addArrangedSubview(titleStackView)
        informationStackView.addArrangedSubview(genreStackView)
        informationStackView.addArrangedSubview(releaseStackView)
        informationStackView.addArrangedSubview(ratingStackView)
        informationStackView.addArrangedSubview(overviewLabel)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(originalTitleLabel)
        
        genreStackView.addArrangedSubview(genreTagLabel)
        genreStackView.addArrangedSubview(genreLabel)
        
        releaseStackView.addArrangedSubview(releaseTagLabel)
        releaseStackView.addArrangedSubview(releaseLabel)
        
        ratingStackView.addArrangedSubview(ratingTagLabel)
        ratingStackView.addArrangedSubview(ratingLabel)
        
        reviewStackView.addArrangedSubview(shortCommentTagLabel)
        reviewStackView.addArrangedSubview(shortCommentLabel)
        reviewStackView.addArrangedSubview(commentTagLabel)
        reviewStackView.addArrangedSubview(commentLabel)
        
        detailScrollView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide.snp.edges)
        }

        detailContentView.snp.makeConstraints {
            $0.edges.equalTo(detailScrollView.contentLayoutGuide)
            $0.height.greaterThanOrEqualTo(self.snp.height).priority(.low)
            $0.width.equalTo(detailScrollView.snp.width)
        }

        backgroundImageView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.lessThanOrEqualTo(detailScrollView.frameLayoutGuide.snp.height)
                .multipliedBy(0.7)
                .priority(.low)
            $0.bottom.lessThanOrEqualTo(posterImageView.snp.bottom).priority(.high)
        }

        posterImageView.snp.makeConstraints {
            $0.height.equalTo(detailScrollView.frameLayoutGuide.snp.height)
                .multipliedBy(0.6)
            $0.leading.top.trailing.equalToSuperview()
        }

        informationStackView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        starRatingView.snp.makeConstraints {
            $0.height.equalTo(starRatingView.snp.width).multipliedBy(0.15)
            $0.top.equalTo(informationStackView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        reviewStackView.snp.makeConstraints {
            $0.top.equalTo(starRatingView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.bottom.equalToSuperview().offset(-16)
        }
    }
}

