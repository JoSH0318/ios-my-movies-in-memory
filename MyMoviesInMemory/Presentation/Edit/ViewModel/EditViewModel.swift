//
//  EditViewModel.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/30.
//

import RxSwift

final class EditViewModel {
    
    // MARK: - Input
    
    struct Input {
        let didShowView: Observable<Void>
        let didDragStarRating: Observable<Float>
        let didTapSaveButton: Observable<EditViewModelItem>
        let didEditCommentView: Observable<(String?, String)>
        let didEditShortCommentView: Observable<(String?, String)>
    }
    
    // MARK: - Output
    
    struct Output {
        let movieWithPoster: Observable<(UIImage?, Movie)>
        let starRating: Observable<Int>
        let commentViewEditingStatus: Observable<Void>
        let shortCommentViewEditingStatus: Observable<Void>
        let popEditViewTrigger: Observable<Void>
    }
    
    // MARK: - Properties
    
    private let reviewUseCase: ReviewUseCaseType
    private let movie: Movie
    private let posterImage: UIImage?
    
    // MARK: - Initializer
    
    init(
        reviewUseCase: ReviewUseCaseType,
        movie: Movie,
        posterImage: UIImage?
    ) {
        self.reviewUseCase = reviewUseCase
        self.movie = movie
        self.posterImage = posterImage
    }
    
    // MARK: - Methods
    
    func transform(_ input: Input) -> Output {
        let movieWithPoster = input.didShowView
            .withUnretained(self)
            .map { owner, _ in
                (owner.posterImage, owner.movie)
            }
        
        let rating = input.didDragStarRating
            .withUnretained(self)
            .map { owner, value in
                Int(floor(value))
            }
        
        let isBeginEditingCommentView = input.didEditCommentView
            .filter { $0.0 == $0.1 }
            .map { _ in }
        
        let isBeginEditingShortCommentView = input.didEditShortCommentView
            .filter { $0.0 == $0.1 }
            .map { _ in }
        
        let popEditViewTrigger = input.didTapSaveButton
            .withUnretained(self)
            .map { owner, data in
                let dataToSave = Review(
                    id: String(owner.movie.id),
                    title: owner.movie.title,
                    originalTitle: owner.movie.originalTitle,
                    posterPath: owner.movie.posterPath,
                    genres: owner.movie.genres,
                    releaseDate: owner.movie.releaseDate,
                    userRating: owner.movie.userRating,
                    originalLanguage: owner.movie.originalLanguage,
                    overview: owner.movie.overview,
                    personalRating: Double(data.personalRating),
                    shortComment: data.shortComment ?? "",
                    comment: data.comment ?? "",
                    recordDate: MMIMDateFormatter.shared.toDateString(Date())
                )
                owner.reviewUseCase.save(dataToSave)
            }
        
        return Output(
            movieWithPoster: movieWithPoster,
            starRating: rating,
            commentViewEditingStatus: isBeginEditingCommentView,
            shortCommentViewEditingStatus: isBeginEditingShortCommentView,
            popEditViewTrigger: popEditViewTrigger
        )
    }
}
