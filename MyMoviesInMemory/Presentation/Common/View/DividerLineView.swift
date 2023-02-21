//
//  DividerLineView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/21.
//

import UIKit

final class DividerLineView: UIView {
    init(height: CGFloat = 0.5) {
        super.init(frame: .zero)
        
        configureLayout(height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout(_ height: CGFloat) {
        backgroundColor = .systemGray5
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
