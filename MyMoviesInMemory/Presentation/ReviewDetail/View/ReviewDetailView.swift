//
//  ReviewDetailView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/06.
//

import SnapKit

final class ReviewDetailView: UIView {
    
    // MARK: - Properties
    
    private(set) var detailScrollView = UIScrollView()
    
    private let detailContentView = UIView()
    
    private(set) var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
        stackView.spacing = Design.vStackSpacing
        stackView.layer.cornerRadius = Design.cornerRadius
        stackView.layer.applyShadow()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(
            top: Design.defaultMargin,
            left: Design.defaultMargin,
            bottom: Design.defaultMargin,
            right: Design.defaultMargin
        )
        return stackView
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Design.titleStackSpacing
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
    
    private let summaryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Design.hStackSpacing
        return stackView
    }()
    
    private let summaryTagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.medium, .bold)
        label.textColor = .systemGray
        label.text = "개요"
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()
    
    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.medium)
        return label
    }()
    
    private let directorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Design.hStackSpacing
        return stackView
    }()
    
    private let directorTagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.medium, .bold)
        label.textColor = .systemGray
        label.text = "감독"
        return label
    }()
    
    private let directorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.medium)
        label.setContentHuggingPriority(.init(1), for: .horizontal)
        return label
    }()
    
    private let actorsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Design.hStackSpacing
        return stackView
    }()
    
    private let actorsTagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.medium, .bold)
        label.textColor = .systemGray
        label.text = "출연"
        return label
    }()
    
    private let actorsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.medium)
        label.numberOfLines = 2
        return label
    }()
    
    private let releaseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Design.hStackSpacing
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
        stackView.spacing = Design.hStackSpacing
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
        stackView.spacing = Design.vStackSpacing / 2
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
        stackView.spacing = Design.vStackSpacing
        stackView.layer.cornerRadius = Design.cornerRadius
        stackView.layer.applyShadow()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(
            top: Design.defaultMargin,
            left: Design.defaultMargin,
            bottom: Design.defaultMargin,
            right: Design.defaultMargin
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
    
    func setupContents(_ item: ReviewDetailViewModelItem) {
        posterImageView.setImage(urlString: item.posterPath)
        backgroundImageView.image = posterImageView.image
        titleLabel.text = item.title
        originalTitleLabel.text = item.originalTitle
        summaryLabel.text = item.summary
        directorLabel.text = item.director
        actorsLabel.text = item.actors
        releaseLabel.text = item.release
        ratingLabel.text = item.rating
        overviewLabel.text = item.overview

        starRatingView.dragStarSlider(item.personalRatingOnTen)
        shortCommentLabel.text = item.shortComment
        commentLabel.text = item.comment
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
        informationStackView.addArrangedSubview(DividerLineView())
        informationStackView.addArrangedSubview(summaryStackView)
        informationStackView.addArrangedSubview(directorStackView)
        informationStackView.addArrangedSubview(actorsStackView)
        informationStackView.addArrangedSubview(releaseStackView)
        informationStackView.addArrangedSubview(ratingStackView)
        informationStackView.addArrangedSubview(DividerLineView())
        informationStackView.addArrangedSubview(overviewLabel)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(originalTitleLabel)
        
        summaryStackView.addArrangedSubview(summaryTagLabel)
        summaryStackView.addArrangedSubview(summaryLabel)
        
        directorStackView.addArrangedSubview(directorTagLabel)
        directorStackView.addArrangedSubview(directorLabel)
        
        actorsStackView.addArrangedSubview(actorsTagLabel)
        actorsStackView.addArrangedSubview(actorsLabel)
        
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
                .multipliedBy(Design.backgroundImageHeightRadius)
                .priority(.low)
            $0.bottom.lessThanOrEqualTo(posterImageView.snp.bottom).priority(.high)
        }

        posterImageView.snp.makeConstraints {
            $0.height.equalTo(detailScrollView.frameLayoutGuide.snp.height)
                .multipliedBy(Design.posterHeightRadius)
            $0.leading.top.trailing.equalToSuperview()
        }

        informationStackView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(Design.defaultMargin)
            $0.leading.equalToSuperview().offset(Design.defaultMargin)
            $0.trailing.equalToSuperview().offset(-Design.defaultMargin)
        }
        
        starRatingView.snp.makeConstraints {
            $0.height.equalTo(starRatingView.snp.width).multipliedBy(Design.starRatingViewRadius)
            $0.top.equalTo(informationStackView.snp.bottom).offset(Design.defaultMargin)
            $0.leading.equalToSuperview().offset(Design.defaultMargin)
            $0.trailing.equalToSuperview().offset(-Design.defaultMargin)
        }
        
        reviewStackView.snp.makeConstraints {
            $0.top.equalTo(starRatingView.snp.bottom).offset(Design.defaultMargin)
            $0.leading.equalToSuperview().offset(Design.defaultMargin)
            $0.trailing.bottom.equalToSuperview().offset(-Design.defaultMargin)
        }
    }
}

extension ReviewDetailView {
    private enum Design {
        static let defaultMargin: CGFloat = 16.0
        static let vStackSpacing: CGFloat = 16.0
        static let hStackSpacing: CGFloat = 16.0
        static let titleStackSpacing: CGFloat = 4.0
        
        static let cornerRadius: CGFloat = 16.0
        
        static let starRatingViewRadius: CGFloat = 0.15
        static let posterHeightRadius: CGFloat = 0.6
        static let backgroundImageHeightRadius: CGFloat = 0.7
    }
}
