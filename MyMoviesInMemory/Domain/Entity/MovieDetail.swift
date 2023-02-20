//
//  MovieDetail.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/17.
//

import Foundation

struct MovieDetail {
    let id: String
    let title: String
    let originalTitle: String
    let posterPath: String
    let genres: String
    let runTime: String
    let releaseDate: String
    let userRating: Double
    let overview: String
    let director: String
    let actors: String
}

extension MovieDetail {
    func toDefaultReview() -> Review {
        return Review(
            id: self.id,
            title: self.title,
            originalTitle: self.originalTitle,
            posterPath: self.posterPath,
            genres: self.genres,
            runTime: self.runTime,
            releaseDate: self.releaseDate,
            userRating: self.userRating,
            overview: self.overview,
            director: self.director,
            actors: self.actors,
            personalRating: 0.0,
            shortComment: "",
            comment: "",
            recordDate: ""
        )
    }
}

