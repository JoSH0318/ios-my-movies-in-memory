//
//  HomeView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/29.
//

import SnapKit

final class HomeView: UIView {
    
    // MARK: - NameSpace
    
    private enum FontSize {
        static let title: CGFloat = 18.0
        static let subtitle: CGFloat = 16.0
        static let body: CGFloat = 12.0
    }
    
    // MARK: - Properties
    
    private(set) var reviewCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: CarouselLayout()
    )
    
    private let reviewDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FontSize.title)
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
    
    private func configureView() {
        addSubview(reviewCollectionView)
        addSubview(reviewDescriptionLabel)
        
        reviewCollectionView.register(
            MovieReviewCell.self,
            forCellWithReuseIdentifier: MovieReviewCell.identifier
        )
    }
    
    private func configureConstraints() {
        reviewCollectionView.snp.makeConstraints{
            $0.leading.top.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        reviewDescriptionLabel.snp.makeConstraints{
            $0.top.equalTo(reviewCollectionView.snp.bottom).offset(32)
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
