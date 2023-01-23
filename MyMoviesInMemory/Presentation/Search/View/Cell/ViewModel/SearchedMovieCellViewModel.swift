//
//  SearchedMovieCellViewModel.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/15.
//

import Foundation
import RxSwift
import UIKit

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
        
        let posterImage = searchedMovie
            .withUnretained(self)
            .flatMap { owner, movie in
                owner.imageManager.downloadImage(movie.posterPath, owner.downloadTaskToken)
            }
        
        return Output(posterImage: posterImage, movie: searchedMovie)
    }
}
