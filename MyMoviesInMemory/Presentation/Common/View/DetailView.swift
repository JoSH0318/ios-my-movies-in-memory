//
//  DetailView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/08.
//

import SnapKit

class DetailView: UIView {
    
    // MARK: - Constants
    
    enum Design {}
    
    // MARK: - Properties
    
    private let detailScrollView = UIScrollView()
    
    private let detailView = UIView()
    
    private(set) var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 16
        imageView.layer.applyShadow()
        return imageView
    }()
    
    private(set) var backgroundImageView: UIImageView = {
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
    
    private(set) var informationStackView: UIStackView = {
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
    
    private(set) var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.large, .heavy)
        return label
    }()
    
    private(set) var originalTitleLabel: UILabel = {
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
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()
    
    private(set) var genreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.medium)
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
    
    private(set) var releaseLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.medium)
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
    
    private(set) var ratingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.medium)
        return label
    }()
    
    private(set) var overviewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.medium)
        label.numberOfLines = 0
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
    
    private func configureView() {
        backgroundColor = .MBeige
    }
    
    private func configureUI() {
        addSubview(backgroundImageView)
        addSubview(detailScrollView)

        detailScrollView.addSubview(detailView)

        detailView.addSubview(posterImageView)
        detailView.addSubview(informationStackView)
        
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
    }
    
    private func configureConstraints() {
        detailScrollView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide.snp.edges)
        }

        detailView.snp.makeConstraints {
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
            $0.trailing.bottom.equalToSuperview().offset(-16)
        }
    }
}