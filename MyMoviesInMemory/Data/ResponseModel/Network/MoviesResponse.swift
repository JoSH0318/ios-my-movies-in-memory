//
//  MoviesResponse.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/21.
//

import Foundation

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
