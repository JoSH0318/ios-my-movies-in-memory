//
//  Movie.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/29.
//

import Foundation

//struct Movie {
//    let title: String
//    let id: String
//    let subtitle: String
//    let imageUrl: String
//    let openingYear: String
//    let director: String
//    let actors: String
//    let userRating: String
//}

struct Movie {
    let id: Int
    let title: String
    let originalTitle: String
    let posterPath: String
    let genreIDs: [Int]
    let releaseDate: String
    let userRating: Double
    let originalLanguage: String
    let overview: String
}
