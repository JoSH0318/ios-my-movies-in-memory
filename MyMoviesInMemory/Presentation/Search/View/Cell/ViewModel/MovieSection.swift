//
//  MovieSection.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/03/28.
//

import RxDataSources

struct MovieSection {
    var items: [Movie]
}

extension MovieSection: SectionModelType {
    typealias Item = Movie
    
    init(original: MovieSection, items: [Movie]) {
        self = original
        self.items = items
    }
}
