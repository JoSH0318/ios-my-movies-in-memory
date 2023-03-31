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
    
    private let initialNoticeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont().fontWith(.extraLarge, .bold)
        label.textColor = .MGray
        label.text = "저장한 영화가 없습니다."
        label.numberOfLines = 0
        return label
    }()
    
    private(set) var reviewCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: CarouselLayout()
    )
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        registerCell()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func registerCell() {
        reviewCollectionView.register(
            ReviewCell.self,
            forCellWithReuseIdentifier: ReviewCell.identifier
        )
    }
    
    private func configureLayout() {
        backgroundColor = .MLight
        reviewCollectionView.backgroundColor = .MLight
        
        addSubview(reviewCollectionView)
        addSubview(initialNoticeLabel)
        
        initialNoticeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        reviewCollectionView.snp.makeConstraints{
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.1)
            $0.bottom.equalToSuperview().offset(-UIScreen.main.bounds.height * 0.1)
        }
    }
    
    func hideInitialNotice() {
        initialNoticeLabel.isHidden = true
    }
}
