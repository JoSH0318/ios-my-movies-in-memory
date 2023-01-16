//
//  SearchedMovieCellViewModel.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/15.
//

import Foundation
import RxSwift

final class SearchedMovieCellViewModel {
    
    // MARK: - Input
    
    struct Input {
        let setupCell: Observable<Movie>
    }
    
    // MARK: - Output
    
    struct Output {
        let posterImage: Observable<UIImage?>
        let movie: Observable<Movie>
    }
    
    // MARK: - Properties
    
    private let imageManager = ImageManager.shared
    private let downloadTaskToken: UInt
    
    // MARK: - Initializer
    
    init() {
        self.downloadTaskToken = imageManager.nextToken()
    }
    
    // MARK: - Methods
    
    func transform(_ input: Input) -> Output {
        let searchedMovie = input.setupCell
            .share()
        
        let posterImageUrl = searchedMovie
            .withUnretained(self)
            .flatMap { owner, movie in
                owner.imageManager.fetchPosterImageUrl(movie.subtitle)
            }
        
        let posterImage = posterImageUrl
            .withUnretained(self)
            .flatMap { owner, imageUrl in
                owner.imageManager
                    .downloadImage(imageUrl, owner.downloadTaskToken)
                    .asObservable()
            }
        
        return Output(posterImage: posterImage, movie: searchedMovie)
    }
}
