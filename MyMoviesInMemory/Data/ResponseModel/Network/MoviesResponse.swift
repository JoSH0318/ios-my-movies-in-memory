//
//  MoviesResponse.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/21.
//

import Foundation
import RxSwift

// MARK: - MoviesResponse

struct MoviesResponse: Codable {
    let page: Int?
    let movieResults: [MovieResult]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case movieResults = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - MovieResult

struct MovieResult: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDs: [Int]?
    let id: Int?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension MovieResult {
    func toDomain() -> Movie {
        return Movie(
            id: self.id ?? -1,
            title: self.title ?? "",
            originalTitle: self.originalTitle ?? "",
            posterPath: self.posterPath ?? "",
            genreIDs: self.genreIDs ?? [],
            releaseDate: self.releaseDate ?? "",
            userRating: self.voteAverage ?? 0.0,
            originalLanguage: self.originalLanguage ?? "",
            overview: self.overview ?? ""
        )
    }
}

