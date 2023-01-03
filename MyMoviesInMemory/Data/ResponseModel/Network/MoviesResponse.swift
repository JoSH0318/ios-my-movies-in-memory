//
//  MoviesResponse.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/21.
//

import Foundation

struct MoviesResponse: Decodable {
    let lastBuildDate: String?
    let totalCount: Int?
    let startPage: Int?
    let moviesPerPage: Int?
    let items: [MovieItem]?
    
    enum CodingKeys: String, CodingKey {
        case lastBuildDate, items
        case totalCount = "total"
        case startPage = "start"
        case moviesPerPage = "display"
    }
}

// MARK: - MovieItem
struct MovieItem: Decodable {
    let title: String?
    let link: String?
    let imageUrl: String?
    let subtitle: String?
    let pubDate: String?
    let director: String?
    let actor: String?
    let userRating: String?
    
    enum CodingKeys: String, CodingKey {
        case title, link, subtitle, pubDate, director, actor, userRating
        case imageUrl = "image"
    }
    
    func toDomain() -> Movie {
        return Movie(
            title: self.title ?? "",
            id: self.link ?? "",
            subtitle: self.subtitle ?? "",
            imageUrl: self.imageUrl ?? "",
            openingYear: self.pubDate ?? "",
            director: self.director ?? "",
            actor: self.actor ?? "",
            userRating: self.userRating ?? ""
        )
    }
}
