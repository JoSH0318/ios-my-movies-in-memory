//
//  Movie.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/29.
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let originalTitle: String
    let posterPath: String
    let genres: String
    let releaseDate: String
    let userRating: Double
    let originalLanguage: String
    let overview: String
}

extension Movie {
    func toDefaultReview() -> Review {
        return Review(
            id: String(self.id),
            title: self.title,
            originalTitle: self.originalTitle,
            posterPath: self.posterPath,
            genres: self.genres,
            releaseDate: self.releaseDate,
            userRating: self.userRating,
            originalLanguage: self.originalLanguage,
            overview: self.overview,
            personalRating: 0.0,
            shortComment: "",
            comment: "",
            recordDate: ""
        )
    }
}
