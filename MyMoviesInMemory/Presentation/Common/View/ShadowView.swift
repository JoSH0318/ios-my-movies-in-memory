//
//  ShadowOverView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/09.
//

import SnapKit

final class ShadowView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.layer.applyShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
