//
//  CALayer.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/08.
//

import UIKit

extension CALayer {
    func applyShadow(
        _ shadowColor: CGColor = UIColor.black.cgColor,
        _ shadowOpacity: Float = 0.3,
        _ shadowRadius: CGFloat = 8
    ) {
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
        self.shadowRadius = shadowRadius
    }
}
