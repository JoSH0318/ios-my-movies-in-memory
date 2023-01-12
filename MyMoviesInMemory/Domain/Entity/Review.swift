//
//  Review.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/09.
//

import Foundation

struct Review {
    let title: String
    let id: String
    let subtitle: String
    let imageUrl: String
    let openingYear: String
    let director: String
    let actors: String
    let userRating: Double
    let personalRating: Double
    let commentary: String
    let recordDate: String
}

extension Review {
    func toCellViewModelItem() -> MovieReviewCellViewModelItem {
        return MovieReviewCellViewModelItem(
            title: self.title,
            id: self.id,
            subtitle: self.subtitle,
            openingYear: self.openingYear,
            director: self.director,
            actors: self.actors,
            userRating: String(self.userRating),
            personalRating: String(self.personalRating),
            commentary: self.commentary,
            recordDate: self.recordDate
        )
    }
}
