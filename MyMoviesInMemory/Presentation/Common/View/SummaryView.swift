//
//  SummaryView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/31.
//

import SnapKit

final class SummaryView: UIView {
    
    // MARK: - Constants
    
    private enum FontSize {
        static let title: CGFloat = 16.0
        static let body: CGFloat = 14.0
        static let body2: CGFloat = 10.0
    }
    
    // MARK: - Properties
    
    private(set) var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        return imageView
    }()
    
    private let informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private(set) var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.title, weight: .bold)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private(set) var originalTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body2)
        label.textColor = .systemGray3
        return label
    }()
    
    private let genreStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        return stackView
    }()
    
    private let genreTagLabel: UILabel = {
        let label = UILabel()
        label.text = "장르"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
        label.textColor = .MGray
        return label
    }()
    
    private(set) var genreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
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
        label.text = "개봉"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
        label.textColor = .MGray
        return label
    }()
    
    private(set) var releaseLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
        return label
    }()
    
    private let ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        return stackView
    }()
    
    private let ratingTagLabel: UILabel = {
        let label = UILabel()
        label.text = "평점"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
        label.textColor = .MGray
        return label
    }()
    
    private(set) var ratingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
        return label
    }()
    
    private(set) var overviewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body2)
        label.numberOfLines = 0
        label.setContentHuggingPriority(.init(1), for: .vertical)
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
        backgroundColor = .MWhite
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
    private func configureUI() {
        addSubview(posterImageView)
        addSubview(informationStackView)
        
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
        posterImageView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(self.snp.width).dividedBy(3)
        }
        
        informationStackView.snp.makeConstraints {
            $0.leading.equalTo(posterImageView.snp.trailing).offset(16)
            $0.top.equalToSuperview().offset(8)
            $0.trailing.bottom.equalToSuperview().offset(-8)
        }
    }
}
