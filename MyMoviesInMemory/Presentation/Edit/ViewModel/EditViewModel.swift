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
        let didTapSaveButton: Observable<Review>
    }
    
    // MARK: - Output
    
    struct Output {
        let starRating: Observable<Int>
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
        let rating = input.didDragStarRating
            .withUnretained(self)
            .map { owner, value in
                Int(floor(value))
            }
        
        return Output(starRating: rating)
    }
}
// 일단 movie 에서 review로 바꾸는 과정은 필요하니 movie가 필요함
// view에 뿌려질 데이터는 제목정도?
