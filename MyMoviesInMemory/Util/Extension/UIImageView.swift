//
//  UIImageView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/15.
//

import UIKit

extension UIImageView {
    @discardableResult
    func setImage(urlString: String) -> URLSessionDataTask? {
        if let cacheImage = ImageCacheManager.shared.retrive(forKey: urlString) {
            self.image = cacheImage
            return nil
        }
        
        let posterPath = "https://image.tmdb.org/t/p/w300" + urlString + "?" + UserInfo.apiKey
        guard let url = URL(string: posterPath) else { return nil }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                DispatchQueue.main.async { [weak self] in
                    self?.image = UIImage()
                }
                return
            }
            DispatchQueue.main.async { [weak self] in
                if let data = data, let image = UIImage(data: data) {
                    ImageCacheManager.shared.set(object: image, forKey: urlString)
                    self?.image = image
                }
            }
        }
        task.resume()
        
        return task
    }
}
