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
    
    // MARK: - Methods
    
//    func toDefaultReview() -> Review {
//        return Review(
//            id: String(movieDetail.id),
//            title: movieDetail.title,
//            originalTitle: <#T##String#>,
//            posterPath: <#T##String#>,
//            genres: <#T##String#>,
//            releaseDate: <#T##String#>,
//            userRating: <#T##Double#>,
//            originalLanguage: <#T##String#>,
//            overview: <#T##String#>,
//            personalRating: <#T##Double#>,
//            shortComment: <#T##String#>,
//            comment: <#T##String#>,
//            recordDate: <#T##String#>
//        )
//    }
}
