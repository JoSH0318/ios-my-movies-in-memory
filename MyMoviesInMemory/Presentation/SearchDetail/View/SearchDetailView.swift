//
//  SearchDetailView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/23.
//

import SnapKit

final class SearchDetailView: UIView {
    
    // MARK: - Properties
    
    private let detailView = DetailView()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setupContents(
        _ posterImage: UIImage?,
        _ movie: Movie)
    {
        detailView.posterImageView.image = posterImage
        detailView.backgroundImageView.image = posterImage
        detailView.titleLabel.text = movie.title
        detailView.originalTitleLabel.text = movie.originalTitle
        detailView.genreLabel.text = movie.genres
        detailView.releaseLabel.text = "\(movie.releaseDate) | \(movie.originalLanguage)"
        detailView.ratingLabel.text = "\(movie.userRating)"
        detailView.overviewLabel.text = movie.overview
    }
    
    private func configureView() {
        addSubview(detailView)
        
        detailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
