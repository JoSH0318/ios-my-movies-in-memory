//
//  SearchDetailView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/23.
//

import SnapKit

final class SearchDetailView: UIView {
    
    // MARK: - Constants
    
    private enum FontSize {
        static let title: CGFloat = 18.0
        static let subtitle: CGFloat = 16.0
        static let body: CGFloat = 14.0
    }
    
    private enum Design {
        static let posterRatioRadius = 840 / 600
    }
    
    // MARK: - Properties
    
    private let detailScrollView = UIScrollView()
    
    private let detailView = UIView()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 16
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowOpacity = 0.6
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
        stackView.layer.cornerRadius = 16
        stackView.spacing = 16
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
        label.font = .systemFont(ofSize: FontSize.title, weight: .bold)
        return label
    }()
    
    private let originalTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
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
        label.font = .systemFont(ofSize: FontSize.subtitle, weight: .bold)
        label.textColor = .systemGray
        label.text = "장르"
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.subtitle)
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
        label.font = .systemFont(ofSize: FontSize.subtitle, weight: .bold)
        label.textColor = .systemGray
        label.text = "개봉"
        return label
    }()
    
    private let releaseLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.subtitle)
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
        label.font = .systemFont(ofSize: FontSize.subtitle, weight: .bold)
        label.textColor = .systemGray
        label.text = "평점"
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.subtitle)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
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
    
    func setupContents(
        _ posterImage: UIImage?,
        _ movie: Movie)
    {
        posterImageView.image = posterImage
        backgroundImageView.image = posterImage
        titleLabel.text = movie.title
        originalTitleLabel.text = movie.originalTitle
        genreLabel.text = movie.genres
        releaseLabel.text = "\(movie.releaseDate) | \(movie.originalLanguage)"
        ratingLabel.text = "\(movie.userRating)"
        overviewLabel.text = movie.overview
    }
    
    private func configureView() {
        backgroundColor = .MBeige
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 16
        layer.shadowOffset = .zero
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
