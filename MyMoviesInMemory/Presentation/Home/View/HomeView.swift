//
//  HomeView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/29.
//

import SnapKit
import UIKit

final class HomeView: UIView {
    
    // MARK: - Properties
    
    private(set) var reviewCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: CarouselLayout()
    )
    
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
        backgroundColor = UIColor.MBeige
        reviewCollectionView.backgroundColor = UIColor.MBeige
        
        addSubview(reviewCollectionView)
        
        reviewCollectionView.register(
            MovieReviewCell.self,
            forCellWithReuseIdentifier: MovieReviewCell.identifier
        )
    }
    
    private func configureConstraints() {
        reviewCollectionView.snp.makeConstraints{
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.1)
            $0.bottom.equalToSuperview().offset(-UIScreen.main.bounds.height * 0.1)
        }
    }
}
