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
        static let subtitle: CGFloat = 14.0
        static let body: CGFloat = 12.0
    }
    
    private enum Design {
        static let inset: CGFloat = 20.0
        static let punchHoleRadius: CGFloat = 14.0
    }
    
    // MARK: - Properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private let movieTicketView = TicketView()
    private var viewModel: ReviewCellViewModel?
    private var disposeBag = DisposeBag()
    private var task: URLSessionDataTask?
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: FontSize.title)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private let originalTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FontSize.subtitle)
        label.textColor = .systemGray3
        label.setContentHuggingPriority(.init(1), for: .vertical)
        return label
    }()
    
    private let reviewSectionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let starRatingView: StarRatingView = {
        let starRatingView = StarRatingView()
        starRatingView.starRatingSlider.isUserInteractionEnabled = false
        starRatingView.backgroundColor = .clear
        return starRatingView
    }()
    
    private let shortCommentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FontSize.title)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private let barcodeSectionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let barcodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .barcode
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let recordDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FontSize.body)
        label.textAlignment = .right
        label.textColor = .systemGray4
        return label
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
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
        
        cancelTask()
        posterImageView.image = nil
        titleLabel.text = nil
        disposeBag = DisposeBag()
    }
    
    // MARK: - Bind
    
    func bind(_ review: Review) {
        viewModel = ReviewCellViewModel()
        
        let review: Observable<Review> = Observable.just(review)
        let input = ReviewCellViewModel.Input(didShowCell: review)
        let output = viewModel?.transform(input)
        
        output?
            .reviewCellViewModelItem
            .observe(on: MainScheduler.instance)
            .map { $0.posterPath }
            .withUnretained(self)
            .bind(onNext: { owner, posterPath in
                owner.task = owner
                    .posterImageView
                    .setImage(urlString: posterPath)
            })
            .disposed(by: disposeBag)
        
        output?
            .reviewCellViewModelItem
            .observe(on: MainScheduler.instance)
            .map { $0.title }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        output?
            .reviewCellViewModelItem
            .observe(on: MainScheduler.instance)
            .map { $0.originalTitle }
            .bind(to: originalTitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        output?
            .reviewCellViewModelItem
            .observe(on: MainScheduler.instance)
            .map { $0.personalRating }
            .withUnretained(self)
            .bind(onNext: { owner, rating in
                owner.starRatingView.dragStarSlider(rating)
            })
            .disposed(by: disposeBag)
        
        output?
            .reviewCellViewModelItem
            .observe(on: MainScheduler.instance)
            .map { $0.shortComment }
            .bind(to: shortCommentLabel.rx.text)
            .disposed(by: disposeBag)
        
        output?
            .reviewCellViewModelItem
            .observe(on: MainScheduler.instance)
            .map { $0.recordDate }
            .bind(to: recordDate.rx.text)
            .disposed(by: disposeBag)
        }
    
    // MARK: - Methods
    
    private func cancelTask() {
        task?.suspend()
        task?.cancel()
    }
    
    private func configureLayout() {
        backgroundColor = .clear
        
        contentView.addSubview(movieTicketView)
        
        movieTicketView.addSubview(posterImageView)
        movieTicketView.addSubview(titleStackView)
        movieTicketView.addSubview(reviewSectionStackView)
        movieTicketView.addSubview(barcodeSectionStackView)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(originalTitleLabel)
        
        reviewSectionStackView.addArrangedSubview(starRatingView)
        reviewSectionStackView.addArrangedSubview(shortCommentLabel)
        
        barcodeSectionStackView.addArrangedSubview(barcodeImageView)
        barcodeSectionStackView.addArrangedSubview(recordDate)
        
        movieTicketView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints{
            $0.height.equalTo(movieTicketView.snp.height).multipliedBy(0.5)
            $0.leading.top.trailing.equalToSuperview()
        }
        
        titleStackView.snp.makeConstraints {
            $0.top.equalTo(movieTicketView.snp.top)
                .offset(self.bounds.height * 0.5 + 4)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-32)
            $0.bottom.equalTo(movieTicketView.snp.bottom)
                .offset(-self.bounds.height * 0.4 - 16)
        }
        
        reviewSectionStackView.snp.makeConstraints {
            $0.top.equalTo(movieTicketView.snp.top)
                .offset(self.bounds.height * 0.6)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(movieTicketView.snp.bottom)
                .offset(-self.bounds.height * 0.15 - 16)
        }
        
        starRatingView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.4)
            $0.centerX.equalToSuperview().offset(40)
        }
        
        barcodeSectionStackView.snp.makeConstraints {
            $0.top.equalTo(movieTicketView.snp.top)
                .offset(self.bounds.height * 0.85 + 32)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        barcodeImageView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.4)
        }
    }
}
