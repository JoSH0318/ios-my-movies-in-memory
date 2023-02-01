//
//  MovieResult.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/02.
//

import Foundation

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
            genreIDs: toGenre(self.genreIDs) ?? [],
            releaseDate: self.releaseDate ?? "",
            userRating: self.voteAverage ?? 0.0,
            originalLanguage: self.originalLanguage ?? "",
            overview: self.overview ?? ""
        )
    }
    
    private func toGenre(_ genreIDs: [Int]?) -> [String]? {
        let genres = self.genreIDs?
            .map { genreID in
                Genre(rawValue: genreID)?.description ?? ""
            }
        
        return genres
    }
}
