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
        static let title: CGFloat = 16.0
        static let body: CGFloat = 12.0
        static let body2: CGFloat = 10.0
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
        label.textColor = .systemGray2
        return label
    }()
    
    private let totalInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        return stackView
    }()
    
    private let nameTagStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private let genreTagLabel: UILabel = {
        let label = UILabel()
        label.text = "장르"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
        label.textColor = .MGray
        return label
    }()
    
    private let releaseTagLabel: UILabel = {
        let label = UILabel()
        label.text = "개봉"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
        label.textColor = .MGray
        return label
    }()
    
    private let ratingTagLabel: UILabel = {
        let label = UILabel()
        label.text = "평점"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
        label.textColor = .MGray
        return label
    }()

    private let movieInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
        return label
    }()
    
    private let releaseLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.body2)
        label.numberOfLines = 0
        label.setContentHuggingPriority(.init(1), for: .vertical)
        return label
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureUI()
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
            .map { "\($0.genreIDs)" }
            .bind(to: genreLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.transform(input)
            .movie
            .map { "\($0.releaseDate) | \($0.originalLanguage)" }
            .bind(to: releaseLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel?.transform(input)
            .movie
            .compactMap { "\($0.userRating)" }
            .bind(to: ratingLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.transform(input)
            .movie
            .map { $0.overview }
            .bind(to: overviewLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func configureView() {
        backgroundColor = .MWhite
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
    private func configureUI() {
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(originalTitleLabel)
        addSubview(totalInfoStackView)
        addSubview(overviewLabel)
        
        totalInfoStackView.addArrangedSubview(nameTagStackView)
        totalInfoStackView.addArrangedSubview(movieInfoStackView)
        
        nameTagStackView.addArrangedSubview(genreTagLabel)
        nameTagStackView.addArrangedSubview(releaseTagLabel)
        nameTagStackView.addArrangedSubview(ratingTagLabel)
        
        movieInfoStackView.addArrangedSubview(genreLabel)
        movieInfoStackView.addArrangedSubview(releaseLabel)
        movieInfoStackView.addArrangedSubview(ratingLabel)
    }
    
    private func configureConstraints() {
        posterImageView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(self.snp.width).dividedBy(3)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(posterImageView.snp.trailing).offset(16)
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        originalTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(posterImageView.snp.trailing).offset(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        totalInfoStackView.snp.makeConstraints {
            $0.leading.equalTo(posterImageView.snp.trailing).offset(16)
            $0.top.equalTo(originalTitleLabel.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        nameTagStackView.snp.makeConstraints {
            $0.width.equalTo(self.snp.width).dividedBy(10)
        }
        
        overviewLabel.snp.makeConstraints {
            $0.leading.equalTo(posterImageView.snp.trailing).offset(16)
            $0.top.equalTo(totalInfoStackView.snp.bottom).offset(8)
            $0.trailing.bottom.equalToSuperview().offset(-16)
        }
    }
}
