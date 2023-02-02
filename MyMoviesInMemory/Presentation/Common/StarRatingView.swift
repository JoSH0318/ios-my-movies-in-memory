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
        imageView.image = UIImage(systemName: "star")
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private let secondStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 2
        imageView.image = UIImage(systemName: "star")
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private let thirdStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 3
        imageView.image = UIImage(systemName: "star")
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private let fourthStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 4
        imageView.image = UIImage(systemName: "star")
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private let fifthStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 5
        imageView.image = UIImage(systemName: "star")
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private(set) var starRatingSlider: StarRatingSlider = {
        let slider = StarRatingSlider()
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.tintColor = .clear
        slider.thumbTintColor = .clear
        slider.minimumTrackTintColor = .clear
        slider.maximumTrackTintColor = .clear
        return slider
    }()
    
    private let starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
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
                    starImage.image = UIImage(systemName: "star.fill")
                } else if (2 * draggedValue - rating) <= 1 {
                    starImage.image = UIImage(systemName: "star.leadinghalf.filled")
                } else {
                    starImage.image = UIImage(systemName: "star")
                }
            }
        }
    }
    
    private func configureView() {
        backgroundColor = .MWhite
        layer.cornerRadius = 16
        clipsToBounds = true
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
            $0.width.equalTo(firstStarImageView.snp.height).multipliedBy(1.1)
        }
        
        secondStarImageView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(secondStarImageView.snp.height).multipliedBy(1.1)
        }
        
        thirdStarImageView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(thirdStarImageView.snp.height).multipliedBy(1.1)
        }
        
        fourthStarImageView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(fourthStarImageView.snp.height).multipliedBy(1.1)
        }
        
        fifthStarImageView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(fifthStarImageView.snp.height).multipliedBy(1.1)
        }
        
        starStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        starRatingSlider.snp.makeConstraints {
            $0.leading.equalTo(starStackView.snp.leading)
            $0.trailing.equalTo(starStackView.snp.trailing)
            $0.centerY.equalTo(starStackView.snp.centerY)
        }
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