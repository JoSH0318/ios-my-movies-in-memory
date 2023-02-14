//
//  ReviewCellViewModelItem.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/14.
//

import Foundation

struct ReviewCellViewModelItem {
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
    
    var releaseDate: String {
        return review.releaseDate
    }
    
    var personalRating: Int {
        return Int(review.personalRating * 2)
    }
    
    var shortComment: String {
        return review.shortComment
    }
    
    var recordDate: String {
        return review.recordDate
    }
    
    init(review: Review) {
        self.review = review
    }
}
