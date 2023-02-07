//
//  UIFont.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/08.
//

import UIKit

enum FontSize: CGFloat {
    case extraLarge = 20
    case large = 18
    case medium = 16
    case small = 14
    case extraSmall = 12
}

extension UIFont {
    func fontWith(_ size: FontSize) -> UIFont {
        
        return UIFont.systemFont(ofSize: size.rawValue)
    }
    
    func fontWith(
        _ size: FontSize,
        _ weight: UIFont.Weight
    ) -> UIFont {
        
        return UIFont.systemFont(
            ofSize: size.rawValue,
            weight: weight
        )
    }
}
