//
//  SummaryView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/31.
//

import SnapKit

final class SummaryView: UIView {
    
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
        stackView.spacing = Design.vStackSpacing
        return stackView
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Design.vStackSpacing / 2
        return stackView
    }()
    
    private(set) var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.medium, .bold)
        return label
    }()
    
    private(set) var originalTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.extraSmall)
        label.textColor = .systemGray3
        label.setContentHuggingPriority(.init(1), for: .vertical)
        return label
    }()
    
    private(set) var genreStackView: ContentStackView = {
        let stackView = ContentStackView(Constant.genreTagName, .small)
        stackView.spacing = Design.hStackSpacing
        return stackView
    }()
    
    private(set) var releaseStackView: ContentStackView = {
        let stackView = ContentStackView(Constant.releaseTagName, .small)
        stackView.spacing = Design.hStackSpacing
        return stackView
    }()
    
    private(set) var ratingStackView: ContentStackView = {
        let stackView = ContentStackView(Constant.ratingTagName, .small)
        stackView.spacing = Design.hStackSpacing
        return stackView
    }()
    
    private(set) var overviewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont().fontWith(.extraSmall)
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
        layer.cornerRadius = Design.cornerRadius
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
    }
    
    private func configureConstraints() {
        posterImageView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(self.snp.width).dividedBy(3)
        }
        
        informationStackView.snp.makeConstraints {
            $0.leading.equalTo(posterImageView.snp.trailing).offset(Design.defaultMargin)
            $0.top.equalToSuperview().offset(Design.defaultMargin / 2)
            $0.trailing.bottom.equalToSuperview().offset(-Design.defaultMargin / 2)
        }
        
        titleStackView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.25)
        }
    }
}

extension SummaryView {
    private enum Design {
        static let defaultMargin: CGFloat = 16.0
        static let cornerRadius: CGFloat = 16.0
        static let hStackSpacing: CGFloat = 16.0
        static let vStackSpacing: CGFloat = 4.0
    }
    
    private enum Constant {
        static let genreTagName: String = "장르"
        static let releaseTagName: String = "개봉"
        static let ratingTagName: String = "평점"
    }
}
