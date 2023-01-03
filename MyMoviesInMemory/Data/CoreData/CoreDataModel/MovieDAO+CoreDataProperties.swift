//
//  MovieDAO+CoreDataProperties.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/01.
//
//

import Foundation
import CoreData


extension MovieDAO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDAO> {
        return NSFetchRequest<MovieDAO>(entityName: "MovieDAO")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var openingYear: String?
    @NSManaged public var director: String?
    @NSManaged public var actor: String?
    @NSManaged public var userRating: Double
    @NSManaged public var personalRating: Double

}

extension MovieDAO : Identifiable {

}
