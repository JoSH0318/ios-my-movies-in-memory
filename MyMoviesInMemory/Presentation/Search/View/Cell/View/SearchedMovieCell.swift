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
        static let subtitle: CGFloat = 16.0
        static let body: CGFloat = 12.0
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
    
    private let totalStackView: UIStackView = {
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
    
    private let subtitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        return stackView
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.subtitle)
        return label
    }()
    
    private let openingYearLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.subtitle)
        label.textColor = .systemGray3
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()
    
    private let userRatingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.subtitle)
        return label
    }()
    
    private let directorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.subtitle)
        return label
    }()
    
    private let actorsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: FontSize.subtitle)
        label.numberOfLines = 2
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
            .bind(to: posterImageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel?.transform(input)
            .movie
            .map { $0.title }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.transform(input)
            .movie
            .map { $0.subtitle }
            .bind(to: subtitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.transform(input)
            .movie
            .map { $0.openingYear }
            .bind(to: openingYearLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.transform(input)
            .movie
            .compactMap { String($0.userRating) }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.transform(input)
            .movie
            .map { $0.director }
            .bind(to: directorLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel?.transform(input)
            .movie
            .map { $0.actors }
            .bind(to: actorsLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func configureCell() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(totalStackView)
        
        subtitleStackView.addArrangedSubview(subtitleLabel)
        subtitleStackView.addArrangedSubview(openingYearLabel)
        
        totalStackView.addArrangedSubview(titleLabel)
        totalStackView.addArrangedSubview(subtitleStackView)
        totalStackView.addArrangedSubview(userRatingLabel)
        totalStackView.addArrangedSubview(directorLabel)
        totalStackView.addArrangedSubview(actorsLabel)
    }
    
    private func configureConstraints() {
        posterImageView.snp.makeConstraints{
            $0.leading.top.bottom.equalToSuperview()
        }
        
        totalStackView.snp.makeConstraints{
            $0.leading.equalTo(posterImageView.snp.trailing).offset(16)
            $0.top.trailing.bottom.equalToSuperview().offset(16)
        }
    }
}
