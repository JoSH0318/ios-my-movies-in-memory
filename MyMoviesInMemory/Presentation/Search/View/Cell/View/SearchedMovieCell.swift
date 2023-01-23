//
//  SearchedMovieCell.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/15.
//

import SnapKit
import RxSwift

final class SearchedMovieCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    private enum FontSize {
        static let title: CGFloat = 20.0
        static let body: CGFloat = 14.0
    }
    
    // MARK: - Properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private var viewModel: SearchedMovieCellViewModel?
    private var disposeBag = DisposeBag()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        return imageView
    }()
    
    private let informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.title, weight: .bold)
        return label
    }()
    
    private let originalTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
        label.textColor = .systemGray3
        return label
    }()
    
    private let summaryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        return stackView
    }()
    
    private let summaryNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
        label.textColor = .systemGray
        label.text = "개요"
        return label
    }()
    
    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
        label.setContentHuggingPriority(.init(rawValue: 1), for: .horizontal)
        return label
    }()
    
    private let releaseDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        return stackView
    }()
    
    private let releaseDateNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
        label.textColor = .systemGray
        label.text = "개봉일"
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
        return label
    }()
    
    private let userRatingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        return stackView
    }()
    
    private let userRatingNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
        label.textColor = .systemGray
        label.text = "평점"
        return label
    }()
    
    private let userRatingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PrepareForReuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    // MARK: - Methods
    
    func bind(_ searchedMovie: Movie) {
        viewModel = SearchedMovieCellViewModel()
        
        let searchedMovie: Observable<Movie> = Observable.just(searchedMovie)
        let input = SearchedMovieCellViewModel.Input(setupCell: searchedMovie)
        
        viewModel?.transform(input)
            .posterImage
            .observe(on: MainScheduler.instance)
            .bind(to: posterImageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel?.transform(input)
            .movie
            .map { $0.title }
            .observe(on: MainScheduler.instance)
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.transform(input)
            .movie
            .map { $0.originalTitle }
            .bind(to: originalTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.transform(input)
            .movie
            .map { "\($0.genreIDs) | \($0.originalLanguage)" }
            .bind(to: summaryLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.transform(input)
            .movie
            .map { String($0.releaseDate) }
            .bind(to: releaseDateLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel?.transform(input)
            .movie
            .compactMap { String($0.userRating) }
            .bind(to: userRatingLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.transform(input)
            .movie
            .map { $0.overview }
            .bind(to: overviewLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func configureCell() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(informationStackView)
        
        summaryStackView.addArrangedSubview(summaryNameLabel)
        summaryStackView.addArrangedSubview(summaryLabel)
        
        releaseDateStackView.addArrangedSubview(releaseDateNameLabel)
        releaseDateStackView.addArrangedSubview(releaseDateLabel)
        
        userRatingStackView.addArrangedSubview(userRatingNameLabel)
        userRatingStackView.addArrangedSubview(userRatingLabel)
        
        informationStackView.addArrangedSubview(summaryStackView)
        informationStackView.addArrangedSubview(releaseDateStackView)
        informationStackView.addArrangedSubview(userRatingStackView)
        informationStackView.addArrangedSubview(overviewLabel)
    }
    
    private func configureConstraints() {
        posterImageView.snp.makeConstraints{
            $0.leading.top.bottom.equalTo(contentView)
            $0.width.equalTo(contentView.snp.width).dividedBy(3)
        }
        
        informationStackView.snp.makeConstraints{
            $0.leading.equalTo(posterImageView.snp.trailing).offset(16)
            $0.top.equalToSuperview().offset(16)
            $0.trailing.bottom.equalToSuperview().offset(-16)
        }
    }
}
