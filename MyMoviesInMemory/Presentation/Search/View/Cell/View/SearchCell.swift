//
//  SearchedMovieCell.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/15.
//

import SnapKit
import RxSwift

final class SearchCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let summaryView = SummaryView()
    private var viewModel: SearchCellViewModel?
    private var disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    // MARK: - Bind
    
    func bind(_ searchedMovie: Movie) {
        viewModel = SearchCellViewModel()
        
        let searchedMovie: Observable<Movie> = Observable.just(searchedMovie)
        let input = SearchCellViewModel.Input(setupCell: searchedMovie)
        let output = viewModel?.transform(input)
            .searchCellViewModelItem
        
        output?
            .map { $0.posterPath }
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { owner, posterPath in
                owner.summaryView.posterImageView
                    .setImage(urlString: posterPath)
            })
            .disposed(by: disposeBag)
        
        output?
            .map { $0.title }
            .observe(on: MainScheduler.instance)
            .bind(to: summaryView.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        output?
            .map { $0.originalTitle }
            .bind(to: summaryView.originalTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        output?
            .map { $0.genres }
            .bind(to: summaryView.genreLabel.rx.text)
            .disposed(by: disposeBag)
        
        output?
            .map { $0.release }
            .bind(to: summaryView.releaseLabel.rx.text)
            .disposed(by: disposeBag)

        output?
            .map { $0.userRating }
            .bind(to: summaryView.ratingLabel.rx.text)
            .disposed(by: disposeBag)
        
        output?
            .map { $0.overview }
            .bind(to: summaryView.overviewLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    
    private func configureLayout() {
        let shadowView = ShadowView()
        
        contentView.addSubview(shadowView)
        shadowView.addSubview(summaryView)
        
        shadowView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        summaryView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
