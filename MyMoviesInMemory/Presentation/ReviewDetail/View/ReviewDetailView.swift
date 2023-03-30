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
    
    private let summaryStackView: ContentStackView = {
        let stackView = ContentStackView("개요", .medium)
        stackView.spacing = Design.hStackSpacing
        return stackView
    }()
    
    private let directorStackView: ContentStackView = {
        let stackView = ContentStackView("감독", .medium)
        stackView.spacing = Design.hStackSpacing
        return stackView
    }()
    
    private let actorsStackView: ContentStackView = {
        let stackView = ContentStackView("출연", .medium)
        stackView.contentLabel.numberOfLines = 2
        stackView.spacing = Design.hStackSpacing
        return stackView
    }()
    
    private let releaseStackView: ContentStackView = {
        let stackView = ContentStackView("개봉", .medium)
        stackView.spacing = Design.hStackSpacing
        return stackView
    }()
    
    private let ratingStackView: ContentStackView = {
        let stackView = ContentStackView("평점", .medium)
        stackView.spacing = Design.hStackSpacing
        return stackView
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let starRatingBackgroundView: ShadowBackgroundView = {
        let view = ShadowBackgroundView()
        view.backgroundColor = .MWhite
        view.layer.cornerRadius = Design.cornerRadius
        return view
    }()
    
    private let starRatingView = StarRatingView()
    
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
        summaryStackView.contentLabel.text = item.summary
        directorStackView.contentLabel.text = item.director
        actorsStackView.contentLabel.text = item.actors
        releaseStackView.contentLabel.text = item.release
        ratingStackView.contentLabel.text = item.rating
        overviewLabel.text = item.overview

        starRatingView.dragStarSlider(item.personalRatingOnTen)
        shortCommentLabel.text = item.shortComment
        commentLabel.text = item.comment
    }
    
    private func configureLayout() {
        backgroundColor = .MLight
        
        addSubview(backgroundImageView)
        addSubview(detailScrollView)
        
        detailScrollView.addSubview(detailContentView)
        
        detailContentView.addSubview(posterImageView)
        detailContentView.addSubview(informationStackView)
        detailContentView.addSubview(starRatingBackgroundView)
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
        
        starRatingBackgroundView.addSubview(starRatingView)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(originalTitleLabel)
        
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
        
        starRatingBackgroundView.snp.makeConstraints {
            $0.height.equalTo(starRatingBackgroundView.snp.width).multipliedBy(Design.starRatingViewRadius)
            $0.top.equalTo(informationStackView.snp.bottom).offset(Design.defaultMargin)
            $0.leading.equalToSuperview().offset(Design.defaultMargin)
            $0.trailing.equalToSuperview().offset(-Design.defaultMargin)
        }
        
        reviewStackView.snp.makeConstraints {
            $0.top.equalTo(starRatingBackgroundView.snp.bottom).offset(Design.defaultMargin)
            $0.leading.equalToSuperview().offset(Design.defaultMargin)
            $0.trailing.bottom.equalToSuperview().offset(-Design.defaultMargin)
        }
        
        starRatingView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.4)
            $0.width.equalToSuperview()
            $0.center.equalToSuperview()
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
        
        static let starRatingViewRadius: CGFloat = 0.2
        static let posterHeightRadius: CGFloat = 0.6
        static let backgroundImageHeightRadius: CGFloat = 0.7
    }
}
