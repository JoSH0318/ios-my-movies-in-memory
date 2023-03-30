//
//  StarRatingView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/31.
//

import SnapKit

final class StarRatingView: UIView {
    
    // MARK: - Properties
    
    private let firstStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 1
        imageView.image = .emptyStar
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private let secondStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 2
        imageView.image = .emptyStar
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private let thirdStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 3
        imageView.image = .emptyStar
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private let fourthStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 4
        imageView.image = .emptyStar
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private let fifthStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 5
        imageView.image = .emptyStar
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private(set) var starRatingSlider: StarRatingSlider = {
        let slider = StarRatingSlider()
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.thumbTintColor = .clear
        slider.minimumTrackTintColor = .clear
        slider.maximumTrackTintColor = .clear
        return slider
    }()
    
    private let starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = Design.defaultMargin / 2
        return stackView
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
    
    func dragStarSlider(_ rating: Int) {
        for draggedValue in 1...5 {
            if let starImage = viewWithTag(draggedValue) as? UIImageView {
                if draggedValue <= rating / 2 {
                    starImage.image = .fullStar
                } else if (2 * draggedValue - rating) <= 1 {
                    starImage.image = .halfStar
                } else {
                    starImage.image = .emptyStar
                }
            }
        }
    }
    
    private func configureView() {
        backgroundColor = .MWhite
    }
    
    private func configureUI() {
        addSubview(starStackView)
        addSubview(starRatingSlider)
        
        starStackView.addArrangedSubview(firstStarImageView)
        starStackView.addArrangedSubview(secondStarImageView)
        starStackView.addArrangedSubview(thirdStarImageView)
        starStackView.addArrangedSubview(fourthStarImageView)
        starStackView.addArrangedSubview(fifthStarImageView)
    }
    
    private func configureConstraints() {
        firstStarImageView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(firstStarImageView.snp.height)
        }
        
        secondStarImageView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(secondStarImageView.snp.height)
        }
        
        thirdStarImageView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(thirdStarImageView.snp.height)
        }
        
        fourthStarImageView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(fourthStarImageView.snp.height)
        }
        
        fifthStarImageView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(fifthStarImageView.snp.height)
        }
        
        starStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        starRatingSlider.snp.makeConstraints {
            $0.edges.equalTo(starStackView)
        }
    }
}

extension StarRatingView {
    private enum Design {
        static let defaultMargin: CGFloat = 16.0
    }
}

final class StarRatingSlider: UISlider {
    override func beginTracking(
        _ touch: UITouch,
        with event: UIEvent?
    ) -> Bool {
        let width = self.frame.size.width
        let tapPoint = touch.location(in: self)
        let fPercent = tapPoint.x/width
        let nNewValue = self.maximumValue * Float(fPercent)
        if nNewValue != self.value {
            self.value = nNewValue
        }
        return true
    }
}
