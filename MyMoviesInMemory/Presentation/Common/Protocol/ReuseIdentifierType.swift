//
//  ReuseIdentifierType.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/15.
//

import UIKit

protocol ReuseIdentifierType {
    static var identifier: String { get }
}

extension ReuseIdentifierType {
    static var identifier: String {
        return String(describing: Self.self)
    }
}

extension UICollectionViewCell: ReuseIdentifierType {}
