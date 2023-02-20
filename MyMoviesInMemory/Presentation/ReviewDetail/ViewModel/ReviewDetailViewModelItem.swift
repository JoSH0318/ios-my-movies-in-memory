//
//  ReviewDetailViewModelItem.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/14.
//

import Foundation

struct ReviewDetailViewModelItem {
    
    // MARK: - Properties
    
    private let review: Review
    
    var title: String {
        return review.title
    }
    
    var originalTitle: String {
        return review.originalTitle
    }
    
    var posterPath: String {
        return review.posterPath
    }
    
    var genres: String {
        return review.genres
    }
    
    var release: String {
        return review.releaseDate
    }
    
    var rating: String {
        return MMIMNumberFormatter.shared.toRating(review.userRating)
    }
    
    var overview: String {
        return review.overview
    }
    
    var personalRatingOnTen: Int {
        return Int(review.personalRating * 2)
    }
    
    var shortComment: String {
        return review.shortComment
    }
    
    var comment: String {
        return review.comment
    }
    
    var recordDate: String {
        return review.recordDate
    }
    
    // MARK: - Initializer
    
    init(review: Review) {
        self.review = review
    }
}
