//
//  ReviewDAO+CoreDataProperties.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/20.
//
//

import Foundation
import CoreData


extension ReviewDAO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReviewDAO> {
        return NSFetchRequest<ReviewDAO>(entityName: "ReviewDAO")
    }
    
    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var genres: String?
    @NSManaged public var country: String?
    @NSManaged public var runTime: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var userRating: Double
    @NSManaged public var overview: String?
    @NSManaged public var director: String?
    @NSManaged public var actors: String?
    @NSManaged public var personalRating: Double
    @NSManaged public var shortComment: String?
    @NSManaged public var comment: String?
    @NSManaged public var recordDate: String?
}

extension ReviewDAO {
    func toDomain() -> Review {
        return Review(
            id: self.id ?? "",
            title: self.title ?? "",
            originalTitle: self.originalTitle ?? "",
            posterPath: self.posterPath ?? "",
            genres: self.genres ?? "",
            runTime: self.runTime ?? "",
            releaseDate: self.releaseDate ?? "",
            userRating: self.userRating,
            overview: self.overview ?? "",
            director: self.director ?? "",
            actors: self.actors ?? "",
            personalRating: self.personalRating,
            shortComment: self.shortComment ?? "",
            comment: self.comment ?? "",
            recordDate: self.recordDate ?? ""
        )
    }
}

extension ReviewDAO : Identifiable {}
