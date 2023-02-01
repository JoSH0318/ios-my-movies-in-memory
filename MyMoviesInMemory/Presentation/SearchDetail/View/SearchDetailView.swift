//
//  SearchDetailView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/23.
//

import SnapKit
import UIKit

final class SearchDetailView: UIView {
    
    // MARK: - Constants
    
    private enum FontSize {
        static let title: CGFloat = 20.0
        static let subtitle: CGFloat = 18.0
        static let body: CGFloat = 14.0
    }
    
    // MARK: - Properties
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = false
        return imageView
    }()
    
    private let informationView: UIView = {
        let view = UIView()
        view.backgroundColor = .MWhite
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        return stackView
    }()
    
    private let nameTagStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    
    private let titleNameTagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.subtitle, weight: .bold)
        label.textColor = .systemGray
        label.text = "제목"
        return label
    }()
    
    private let originalTitleNameTagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.subtitle, weight: .bold)
        label.textColor = .systemGray
        label.text = "원제"
        return label
    }()
    
    private let summaryNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.subtitle, weight: .bold)
        label.textColor = .systemGray
        label.text = "개요"
        return label
    }()
    
    private let releaseDateNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.subtitle, weight: .bold)
        label.textColor = .systemGray
        label.text = "개봉일"
        return label
    }()
    
    private let userRatingNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.subtitle, weight: .bold)
        label.textColor = .systemGray
        label.text = "평점"
        return label
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.subtitle, weight: .bold)
        return label
    }()
    
    private let originalTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.subtitle)
        return label
    }()
    
    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.subtitle)
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.subtitle)
        return label
    }()
    
    private let userRatingLabel: UILabel = {
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
        posterImageView.image = posterImage
        titleLabel.text = movie.title
        originalTitleLabel.text = movie.originalTitle
        summaryLabel.text = "\(movie.genreIDs) | \(movie.originalLanguage)"
        releaseDateLabel.text = movie.releaseDate
        userRatingLabel.text = "\(movie.userRating)"
        overviewLabel.text = movie.overview
    }
    
    private func configureView() {
        backgroundColor = .MBeige
        
        addSubview(posterImageView)
        addSubview(informationView)
        
        informationView.addSubview(informationStackView)
        informationView.addSubview(overviewLabel)
        
        informationStackView.addArrangedSubview(nameTagStackView)
        informationStackView.addArrangedSubview(contentStackView)
        
        nameTagStackView.addArrangedSubview(titleNameTagLabel)
        nameTagStackView.addArrangedSubview(originalTitleNameTagLabel)
        nameTagStackView.addArrangedSubview(summaryNameLabel)
        nameTagStackView.addArrangedSubview(releaseDateNameLabel)
        nameTagStackView.addArrangedSubview(userRatingNameLabel)
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(originalTitleLabel)
        contentStackView.addArrangedSubview(summaryLabel)
        contentStackView.addArrangedSubview(releaseDateLabel)
        contentStackView.addArrangedSubview(userRatingLabel)
    }
    
    private func configureConstraints() {
        posterImageView.snp.makeConstraints {
            $0.height.equalTo(self.snp.height).dividedBy(2.5)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide)
        }
        
        informationView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-32)
        }
        
        informationStackView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        overviewLabel.snp.makeConstraints {
            $0.top.equalTo(informationStackView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.greaterThanOrEqualToSuperview().offset(-16)
        }
    }
}
