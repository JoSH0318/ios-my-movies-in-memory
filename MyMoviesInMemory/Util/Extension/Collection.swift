//
//  Collection.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/03.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
