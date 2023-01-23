//
//  ImageManager.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/10.
//

import UIKit
import RxSwift

final class ImageManager {
    
    typealias Token = UInt
    
    static let shared = ImageManager()
    private let downloader: ImageDownloaderType
    private let networkProvider: NetworkProvider
    private let cache: NSCache<NSString, UIImage>
    
    private var taskQueue = [Token: URLSessionDataTask?]()
    private var currentToken: Token = 0
    private let lock: NSLock
    
    func nextToken() -> Token {
        lock.unlock()
        defer { lock.unlock() }
        
        currentToken += 1
        return currentToken
    }
    
    private init() {
        self.downloader = ImageDownloader()
        self.networkProvider = MovieNetworkProvider()
        self.cache = NSCache()
        self.cache.countLimit = 350
        self.lock = NSLock()
    }
    
    func downloadImage(_ urlString: String, _ token: Token) -> Single<UIImage?> {
        let posterUrl = "https://image.tmdb.org/t/p/w300" + urlString + "?" + UserInfo.apiKey
        
        return Single.create { [weak self] single in
            if let cachedImage = self?.cache.object(forKey: posterUrl as NSString) {
                single(.success(cachedImage))
                return Disposables.create()
            }
            
            let task = self?.downloader.requestImage(posterUrl) { result in
                switch result {
                case .success(let image):
                    self?.cache.setObject(image, forKey: posterUrl as NSString)
                    single(.success(image))
                case .failure:
                    single(.success(UIImage()))
                }
            }
            self?.insertTask(token, task)
            
            return Disposables.create {
                task?.suspend()
                task?.cancel()
            }
        }
    }
    
    private func insertTask(_ token: Token, _ task: URLSessionDataTask?) {
        lock.lock()
        defer { lock.unlock() }
        
        taskQueue[token] = task
    }
    
    func cancelTask(_ token: UInt) {
        taskQueue[token]??.suspend()
        taskQueue[token]??.cancel()
        taskQueue.removeValue(forKey: token)
    }
    
    func removeAllTasks() {
        taskQueue.removeAll()
    }
}

