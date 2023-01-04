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
    
    private func generateRequest(by id: String) -> NSFetchRequest<MovieDAO> {
        let request: NSFetchRequest<MovieDAO> = MovieDAO.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id)
        request.returnsObjectsAsFaults = false
        request.predicate = predicate
        return request
    }
    
    private func fetchResult(from request: NSFetchRequest<MovieDAO>) -> MovieDAO? {
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
    func create(with movie: Movie, _ personalRating: Double) {
        let request = generateRequest(by: movie.id)
        
        if let objectToUpdate = fetchResult(from: request) {
            objectToUpdate.title = movie.title
            objectToUpdate.id = movie.id
            objectToUpdate.subtitle = movie.subtitle
            objectToUpdate.imageUrl = movie.imageUrl
            objectToUpdate.openingYear = movie.openingYear
            objectToUpdate.director = movie.director
            objectToUpdate.actor = movie.actors
            objectToUpdate.userRating = Double(movie.userRating) ?? 0
            objectToUpdate.personalRating = personalRating
        } else {
            let entity = MovieDAO(context: context)
            entity.title = movie.title
            entity.id = movie.id
            entity.subtitle = movie.subtitle
            entity.imageUrl = movie.imageUrl
            entity.openingYear = movie.openingYear
            entity.director = movie.director
            entity.actor = movie.actors
            entity.userRating = Double(movie.userRating) ?? 0
            entity.personalRating = personalRating
        }
        
        saveContext()
    }
    
    func fetch() -> Observable<[MovieDAO]> {
        return Observable.create { [weak self] emitter in
            let request = MovieDAO.fetchRequest()
            guard let movies = try? self?.context.fetch(request) else {
                emitter.onError(CoreDataError.readFail)
                return Disposables.create()
            }
            
            emitter.onNext(movies)
            emitter.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func update(with movie: Movie, _ personalRating: Double) {
        let request = generateRequest(by: movie.id)
        guard let objectToUpdate = fetchResult(from: request) else { return }
        objectToUpdate.title = movie.title
        objectToUpdate.id = movie.id
        objectToUpdate.subtitle = movie.subtitle
        objectToUpdate.imageUrl = movie.imageUrl
        objectToUpdate.openingYear = movie.openingYear
        objectToUpdate.director = movie.director
        objectToUpdate.actor = movie.actors
        objectToUpdate.userRating = Double(movie.userRating) ?? 0
        objectToUpdate.personalRating = personalRating
        
        saveContext()
    }
    
    func delete(_ movieDAO: MovieDAO) {
        let request = generateRequest(by: movieDAO.id ?? "")
        guard let objectToDelete = fetchResult(from: request) else { return }
        context.delete(objectToDelete)
        
        saveContext()
    }
}

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier ?? ""
    static let data = OSLog(subsystem: subsystem, category: "Data")
}