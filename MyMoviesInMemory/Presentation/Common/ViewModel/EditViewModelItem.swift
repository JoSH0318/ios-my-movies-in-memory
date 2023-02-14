//
//  EditViewModelItem.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/05.
//

import Foundation

struct EditViewModelItem {
    
    // MARK: - Properties
    
    private let review: Review
    
    var posterPath: String {
        return review.posterPath
    }
    
    var title: String {
        return review.title
    }
    
    var originalTitle: String {
        return review.originalTitle
    }
    
    var genres: String {
        return review.genres
    }
    
    var release: String {
        return "\(review.releaseDate) | \(review.originalLanguage)"
    }
    
    var rating: String {
        return "\(review.userRating)"
    }
    
    var personalRatingOnTen: Int {
        return Int(review.personalRating * 2)
    }
    
    var overview: String {
        return review.overview
    }
    
    var shortComment: String {
        return review.shortComment
    }
    
    var comment: String {
        return review.comment
    }
    
    // MARK: - Initializer
    
    init(review: Review) {
        self.review = review
    }
}
