//
//  ImageDownloader.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/10.
//

import UIKit
import RxSwift

protocol ImageDownloaderType{
    func requestImage(
        _ url: String,
        completion: @escaping (Result<UIImage, NetworkError>) -> Void
    ) -> URLSessionDataTask?
}

final class ImageDownloader: ImageDownloaderType {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func requestImage(
        _ url: String,
        completion: @escaping (Result<UIImage, NetworkError>) -> Void
    ) -> URLSessionDataTask? {
        guard let url = URL(string: url) else {
            completion(.failure(NetworkError.invalidUrl))
            return nil
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                completion(.failure(.errorIsOccurred(error.debugDescription)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200..<300).contains(response.statusCode)
            else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(.invalidData))
                return
            }
            
            completion(.success(image))
        }
        task.resume()
        
        return task
    }
}
