//
//  ReviewDAO+CoreDataProperties.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/12.
//
//

import Foundation
import CoreData

extension ReviewDAO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReviewDAO> {
        return NSFetchRequest<ReviewDAO>(entityName: "ReviewDAO")
    }

    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var openingYear: String?
    @NSManaged public var director: String?
    @NSManaged public var actor: String?
    @NSManaged public var userRating: Double
    @NSManaged public var personalRating: Double
    @NSManaged public var id: String?
    @NSManaged public var commentary: String?
    @NSManaged public var recordDate: String?

    func toDomain() -> Review {
        return Review(
            title: self.title ?? "",
            id: self.id ?? "",
            subtitle: self.subtitle ?? "",
            imageUrl: self.imageUrl ?? "",
            openingYear: self.openingYear ?? "",
            director: self.director ?? "",
            actors: self.actor ?? "",
            userRating: self.userRating,
            personalRating: self.personalRating,
            commentary: self.commentary ?? "",
            recordDate: self.recordDate ?? ""
        )
    }
}

extension ReviewDAO : Identifiable {

}
