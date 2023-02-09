//
//  SearchedMovieCell.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/15.
//

import SnapKit
import RxSwift

final class SearchedMovieCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        return String(describing: self)
    }
    private let summaryView = SummaryView()
    private var viewModel: SearchedMovieCellViewModel?
    private var disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PrepareForReuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    // MARK: - Bind
    
    func bind(_ searchedMovie: Movie) {
        viewModel = SearchedMovieCellViewModel()
        
        let searchedMovie: Observable<Movie> = Observable.just(searchedMovie)
        let input = SearchedMovieCellViewModel.Input(setupCell: searchedMovie)
        let output = viewModel?.transform(input)
        
        output?
            .posterImage
            .observe(on: MainScheduler.instance)
            .bind(to: summaryView.posterImageView.rx.image)
            .disposed(by: disposeBag)
        
        output?
            .movie
            .map { $0.title }
            .observe(on: MainScheduler.instance)
            .bind(to: summaryView.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        output?
            .movie
            .map { $0.originalTitle }
            .bind(to: summaryView.originalTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        output?
            .movie
            .map { "\($0.genres)" }
            .bind(to: summaryView.genreLabel.rx.text)
            .disposed(by: disposeBag)
        
        output?
            .movie
            .map { "\($0.releaseDate) | \($0.originalLanguage)" }
            .bind(to: summaryView.releaseLabel.rx.text)
            .disposed(by: disposeBag)

        output?
            .movie
            .compactMap { "\($0.userRating)" }
            .bind(to: summaryView.ratingLabel.rx.text)
            .disposed(by: disposeBag)
        
        output?
            .movie
            .map { $0.overview }
            .bind(to: summaryView.overviewLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    
    private func configureLayout() {
        contentView.addSubview(summaryView)
        
        summaryView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
