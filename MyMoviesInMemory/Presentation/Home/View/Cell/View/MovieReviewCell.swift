//
//  MovieReviewCell.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/09.
//

import SnapKit
import RxSwift

final class MovieReviewCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    private enum FontSize {
        static let title: CGFloat = 18.0
        static let subtitle: CGFloat = 16.0
        static let body: CGFloat = 12.0
    }
    
    private enum Design {
        static let inset: CGFloat = 8
        static let aspectRatio = 860 / 600
    }
    
    // MARK: - Properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private var viewModel: MovieReviewCellViewModel?
    private let disposeBag = DisposeBag()
    
    private let movieTicketView: MovieTicketView = {
        let ticketView = MovieTicketView()
        return ticketView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FontSize.title)
        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private let personalRatingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FontSize.title)
        label.textAlignment = .center
        return label
    }()
    
    private let commentaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FontSize.title)
        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return label
    }()
    
    private let recordDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FontSize.subtitle)
        label.textAlignment = .right
        label.textColor = .systemGray4
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
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Override Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // 여기에서도 viewModel transform/bind를 해줘야 하는지?
        viewModel?.onPrepareForReuse()
        posterImageView.image = nil
        titleLabel.text = nil
    }
    
    // MARK: - Methods
    
    func configureContents(_ review: Review) {
        viewModel = MovieReviewCellViewModel()
        
        let review: Observable<Review> = Observable.just(review)
        let input = MovieReviewCellViewModel.Input(setupCell: review)
        
        viewModel?.transform(input)
            .posterImage
            .bind(to: posterImageView.rx.image)
            .disposed(by: disposeBag)
        
        let reviewCellViewModelItem = viewModel?.transform(input)
            .review
            .share()
        
        reviewCellViewModelItem?
            .map { $0.title }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        reviewCellViewModelItem?
            .map { $0.personalRating }
            .bind(to: personalRatingLabel.rx.text)
            .disposed(by: disposeBag)
        
        reviewCellViewModelItem?
            .map { $0.commentary }
            .bind(to: commentaryLabel.rx.text)
            .disposed(by: disposeBag)
        
        reviewCellViewModelItem?
            .map { $0.recordDate }
            .bind(to: recordDate.rx.text)
            .disposed(by: disposeBag)
        }
    
    private func configureCell() {
        backgroundColor = .clear
        
        contentView.addSubview(movieTicketView)
        movieTicketView.addSubview(posterImageView)
        movieTicketView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(personalRatingLabel)
        mainStackView.addArrangedSubview(commentaryLabel)
        mainStackView.addArrangedSubview(recordDate)
    }
    
    private func configureConstraints() {
        movieTicketView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints{
            $0.height.equalTo(self.bounds.width * 1.1)
            $0.leading.top.trailing.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints{
            $0.top.equalTo(posterImageView.snp.bottom).offset(Design.inset * 2)
            $0.leading.leading.equalToSuperview().offset(Design.inset)
            $0.trailing.bottom.equalToSuperview().offset(-Design.inset)
        }
    }
}

