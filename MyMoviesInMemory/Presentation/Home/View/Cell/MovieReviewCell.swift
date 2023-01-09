//
//  MovieReviewCell.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/09.
//

import SnapKit

final class MovieReviewCell: UICollectionViewCell {
    
    // MARK: - NameSpace
    
    private enum FontSize {
        static let title: CGFloat = 18.0
        static let subtitle: CGFloat = 16.0
        static let body: CGFloat = 12.0
    }
    
    // MARK: - Properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FontSize.title)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
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
    
    // MARK: - Override Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
        titleLabel.text = nil
    }
    
    // MARK: - Methods
    
    func configureCellContents(_ review: ReviewDAO) {
        titleLabel.text = review.title
    }
    
    private func configureView() {
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(posterImageView)
        mainStackView.addArrangedSubview(titleLabel)
    }
    
    private func configureConstraints() {
        mainStackView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
        
        posterImageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.bottom.equalToSuperview().offset(-8)
        }
    }
}

