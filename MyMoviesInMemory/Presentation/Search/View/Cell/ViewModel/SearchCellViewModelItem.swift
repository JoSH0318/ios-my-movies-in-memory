//
//  SearchCellViewModelItem.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/14.
//

import Foundation

struct SearchCellViewModelItem {
    
    // MARK: - Properties
    
    private let movie: Movie
    
    var posterPath: String {
        return movie.posterPath
    }
    
    var title: String {
        return movie.title
    }
    
    var originalTitle: String {
        return movie.originalTitle
    }
    
    var genres: String {
        return movie.genres
    }
    
    var release: String {
        return "\(movie.releaseDate) | \(movie.originalLanguage)"
    }
    
    var userRating: String {
        return "\(movie.userRating)"
    }
    
    var overview: String {
        return movie.overview
    }
    
    // MARK: - Initializer
    
    init(movie: Movie) {
        self.movie = movie
    }
}
