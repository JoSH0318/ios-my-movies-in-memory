//
//  ReviewSection.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/03/28.
//

import RxDataSources

struct ReviewSection {
    var items: [Review]
}

extension ReviewSection: SectionModelType {
    typealias Item = Review
    
    init(original: ReviewSection, items: [Review]) {
        self = original
        self.items = items
    }
}
