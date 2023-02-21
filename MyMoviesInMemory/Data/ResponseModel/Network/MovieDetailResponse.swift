//
//  MovieDetailResponse.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/16.
//

import Foundation

// MARK: - MovieDetail

struct MovieDetailResponse: Codable {
    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let revenue, runtime: Int?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Genre

struct Genre: Codable {
    let id: Int
    let name: String
}

extension MovieDetailResponse {
    func toDomain(
        _ director: String,
        _ actors: String
    ) -> MovieDetail {
        return MovieDetail(
            id: String(self.id  ?? 0),
            title: self.title ?? "",
            originalTitle: self.originalTitle ?? "",
            posterPath: self.posterPath ?? "",
            genres: selectMainGenres(self.genres),
            runTime: String(self.runtime ?? 0),
            releaseDate: self.releaseDate ?? "",
            userRating: (self.voteAverage ?? 0.0) / 2 ,
            overview: self.overview ?? "",
            director: director,
            actors: actors
        )
    }
    
    private func selectMainGenres(_ genres: [Genre]?) -> String {
        guard let genres = genres else { return "" }
        let genresName = genres.map { $0.name }
        
        guard let firstGenreName = genresName[safe: 0] else { return "" }
        guard let secondGenreName = genresName[safe: 1] else { return "" }
        
        return firstGenreName + " " + secondGenreName
    }
}
