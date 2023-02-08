//
//  SearchDetailView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/23.
//

import SnapKit

final class SearchDetailView: DetailView {
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setupContents(
        _ posterImage: UIImage?,
        _ movie: Movie)
    {
        posterImageView.image = posterImage
        backgroundImageView.image = posterImage
        titleLabel.text = movie.title
        originalTitleLabel.text = movie.originalTitle
        genreLabel.text = movie.genres
        releaseLabel.text = "\(movie.releaseDate) | \(movie.originalLanguage)"
        ratingLabel.text = "\(movie.userRating)"
        overviewLabel.text = movie.overview
    }
}
