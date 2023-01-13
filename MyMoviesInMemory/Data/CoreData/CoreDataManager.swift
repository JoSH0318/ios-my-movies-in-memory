//
//  CoreDataManager.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/29.
//

import Foundation
import CoreData
import RxSwift
import OSLog

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MMIMCoreDataModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                os_log(.error, log: .data, "%@", "loadPersistentStores Error Occured.")
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(CoreDataError.saveFail.description)
            }
        }
    }
    
    private func generateRequest(by id: String) -> NSFetchRequest<ReviewDAO> {
        let request: NSFetchRequest<ReviewDAO> = ReviewDAO.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id)
        request.returnsObjectsAsFaults = false
        request.predicate = predicate
        return request
    }
    
    private func fetchResult(from request: NSFetchRequest<ReviewDAO>) -> ReviewDAO? {
        guard let fetchResult = try? context.fetch(request),
              let movieDAO = fetchResult.first
        else {
            return nil
        }
        return movieDAO
    }
}

// MARK: - CRUD

extension CoreDataManager {
    func create(with review: Review) {
        let request = generateRequest(by: review.id)
        
        if let objectToUpdate = fetchResult(from: request) {
            objectToUpdate.title = review.title
            objectToUpdate.id = review.id
            objectToUpdate.subtitle = review.subtitle
            objectToUpdate.imageUrl = review.imageUrl
            objectToUpdate.openingYear = review.openingYear
            objectToUpdate.director = review.director
            objectToUpdate.actor = review.actors
            objectToUpdate.userRating = review.userRating
            objectToUpdate.personalRating = review.personalRating
            objectToUpdate.commentary = review.commentary
            objectToUpdate.recordDate = review.recordDate
        } else {
            let entity = ReviewDAO(context: context)
            entity.title = review.title
            entity.id = review.id
            entity.subtitle = review.subtitle
            entity.imageUrl = review.imageUrl
            entity.openingYear = review.openingYear
            entity.director = review.director
            entity.actor = review.actors
            entity.userRating = review.userRating
            entity.personalRating = review.personalRating
            entity.commentary = review.commentary
            entity.recordDate = review.recordDate
        }
        
        saveContext()
    }
    
    func fetch() -> Observable<[ReviewDAO]> {
        return Observable.create { [weak self] emitter in
            let request = ReviewDAO.fetchRequest()
            guard let movies = try? self?.context.fetch(request) else {
                emitter.onError(CoreDataError.readFail)
                return Disposables.create()
            }
            
            emitter.onNext(movies)
            emitter.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func update(with review: Review) {
        let request = generateRequest(by: review.id)
        guard let objectToUpdate = fetchResult(from: request) else { return }
        objectToUpdate.title = review.title
        objectToUpdate.id = review.id
        objectToUpdate.subtitle = review.subtitle
        objectToUpdate.imageUrl = review.imageUrl
        objectToUpdate.openingYear = review.openingYear
        objectToUpdate.director = review.director
        objectToUpdate.actor = review.actors
        objectToUpdate.userRating = review.userRating
        objectToUpdate.personalRating = review.personalRating
        objectToUpdate.commentary = review.commentary
        objectToUpdate.recordDate = review.recordDate
        
        saveContext()
    }
    
    func delete(_ review: Review) {
        let request = generateRequest(by: review.id)
        guard let objectToDelete = fetchResult(from: request) else { return }
        context.delete(objectToDelete)
        
        saveContext()
    }
}

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier ?? ""
    static let data = OSLog(subsystem: subsystem, category: "Data")
}
