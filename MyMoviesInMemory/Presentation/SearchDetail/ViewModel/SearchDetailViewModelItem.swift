//
//  SearchDetailViewModelItem.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/14.
//

import Foundation

struct SearchDetailViewModelItem {
    
    // MARK: - Properties
    
    private let movieDetail: MovieDetail
    
    var posterPath: String {
        return movieDetail.posterPath
    }
        
    var title: String {
        return movieDetail.title
    }
    
    var originalTitle: String {
        return movieDetail.originalTitle
    }
    
    var summary: String {
        return "\(movieDetail.genres)  |  \(movieDetail.runTime)h"
    }
    
    var director: String {
        return movieDetail.director
    }
    
    var actors: String {
        return movieDetail.actors
    }
    
    var releaseDate: String {
        return movieDetail.releaseDate
    }
    
    var rating: String {
        return MMIMNumberFormatter.shared.toRating(movieDetail.userRating)
    }
    
    var overview: String {
        return movieDetail.overview
    }
    
    // MARK: - Initializer
    
    init(movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
    }
}
