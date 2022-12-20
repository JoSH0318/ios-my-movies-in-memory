//
//  MoviesResponse.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/21.
//

import Foundation

struct MoviesResponse: Decodable {
    let lastBuildDate: String
    let totalCount: Int
    let startPage: Int
    let moviesPerPage: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case lastBuildDate
        case totalCount = "total"
        case startPage = "start"
        case moviesPerPage = "display"
        case movies = "items"
    }
}

// MARK: - Movie
struct Movie: Decodable {
    let title: String
    let link: String
    let imageUrl: String
    let subtitle: String
    let pubDate: String
    let director: String
    let actor: String
    let userRating: String
    
    enum CodingKeys: String, CodingKey {
        case title, link, subtitle, pubDate, director, actor, userRating
        case imageUrl = "image"
    }
}