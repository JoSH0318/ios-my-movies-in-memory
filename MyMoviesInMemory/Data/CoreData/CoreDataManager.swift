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
            objectToUpdate.id = review.id
            objectToUpdate.title = review.title
            objectToUpdate.originalTitle = review.originalTitle
            objectToUpdate.posterPath = review.posterPath
            objectToUpdate.genres = review.genres
            objectToUpdate.runTime = review.runTime
            objectToUpdate.releaseDate = review.releaseDate
            objectToUpdate.userRating = review.userRating
            objectToUpdate.overview = review.overview
            objectToUpdate.director = review.director
            objectToUpdate.actors = review.actors
            objectToUpdate.personalRating = review.personalRating
            objectToUpdate.shortComment = review.shortComment
            objectToUpdate.comment = review.comment
            objectToUpdate.recordDate = review.recordDate
        } else {
            let entity = ReviewDAO(context: context)
            entity.id = review.id
            entity.title = review.title
            entity.originalTitle = review.originalTitle
            entity.posterPath = review.posterPath
            entity.genres = review.genres
            entity.runTime = review.runTime
            entity.releaseDate = review.releaseDate
            entity.userRating = review.userRating
            entity.overview = review.overview
            entity.director = review.director
            entity.actors = review.actors
            entity.personalRating = review.personalRating
            entity.shortComment = review.shortComment
            entity.comment = review.comment
            entity.recordDate = review.recordDate
        }
        
        saveContext()
    }
    
    func fetchAll() -> Observable<[ReviewDAO]> {
        return Observable.create { [weak self] emitter in
            let request = ReviewDAO.fetchRequest()
            guard let movies = try? self?.context.fetch(request).reversed() else {
                emitter.onError(CoreDataError.readFail)
                return Disposables.create()
            }
            let moviesArray = Array(movies)
            
            emitter.onNext(moviesArray)
            emitter.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func fetchOne(_ id: String) -> Observable<ReviewDAO> {
        return Observable.create { [weak self] emitter in
            guard let request = self?.generateRequest(by: id),
                  let fetchResult = self?.fetchResult(from: request)
            else {
                emitter.onError(CoreDataError.readFail)
                return Disposables.create()
            }
            
            emitter.onNext(fetchResult)
            emitter.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func update(with review: Review) {
        let request = generateRequest(by: review.id)
        guard let objectToUpdate = fetchResult(from: request) else { return }
        objectToUpdate.id = review.id
        objectToUpdate.title = review.title
        objectToUpdate.originalTitle = review.originalTitle
        objectToUpdate.posterPath = review.posterPath
        objectToUpdate.genres = review.genres
        objectToUpdate.runTime = review.runTime
        objectToUpdate.releaseDate = review.releaseDate
        objectToUpdate.userRating = review.userRating
        objectToUpdate.overview = review.overview
        objectToUpdate.director = review.director
        objectToUpdate.actors = review.actors
        objectToUpdate.personalRating = review.personalRating
        objectToUpdate.shortComment = review.shortComment
        objectToUpdate.comment = review.comment
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
