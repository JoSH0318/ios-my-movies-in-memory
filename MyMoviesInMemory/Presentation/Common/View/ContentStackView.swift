//
//  ContentStackView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/03/25.
//

import SnapKit

final class ContentStackView: UIStackView {
    
    // MARK: - Properties
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .systemGray
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private(set) var contentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.setContentHuggingPriority(.init(1), for: .horizontal)
        return label
    }()
    
    // MARK: - Initializer
    
    init(_ tagName: String, _ fontSize: FontSize) {
        super.init(frame: .zero)
        configureContentStackView(tagName)
        setupFont(fontSize)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func configureContentStackView(_ tagTitle: String) {
        configureLayout()
        tagLabel.text = tagTitle
    }
    
    private func configureLayout() {
        self.alignment = .top
        
        addArrangedSubview(tagLabel)
        addArrangedSubview(contentLabel)
    }
    
    private func setupFont(_ fontSize: FontSize) {
        tagLabel.font = UIFont().fontWith(fontSize, .bold)
        contentLabel.font = UIFont().fontWith(fontSize)
    }
}
