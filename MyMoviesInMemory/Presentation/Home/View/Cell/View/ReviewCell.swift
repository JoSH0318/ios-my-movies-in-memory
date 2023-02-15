//
//  MovieReviewCell.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/09.
//

import SnapKit
import RxSwift

final class ReviewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
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
        stackView.spacing = 4
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont().fontWith(.large, .bold)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private let originalTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont().fontWith(.small)
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
        label.font = UIFont().fontWith(.large)
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
        label.font = UIFont().fontWith(.large)
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
        
        let shadowView = ShadowView()
        
        contentView.addSubview(shadowView)
        shadowView.addSubview(movieTicketView)
        
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
        
        shadowView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        movieTicketView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints{
            $0.height.equalTo(movieTicketView.snp.height)
                .multipliedBy(Design.posterSectionRadius)
            $0.leading.top.trailing.equalToSuperview()
        }
        
        titleStackView.snp.makeConstraints {
            $0.top.equalTo(movieTicketView.snp.top)
                .offset(self.bounds.height * Design.posterSectionRadius + (Design.defaultMargin / 2))
            $0.leading.equalToSuperview().offset(Design.defaultMargin * 2)
            $0.trailing.equalToSuperview().offset(-Design.defaultMargin * 2)
            $0.bottom.equalTo(movieTicketView.snp.bottom)
                .offset(-self.bounds.height * (1 - Design.reviewSectionRadius) - (Design.defaultMargin / 2))
        }
        
        reviewSectionStackView.snp.makeConstraints {
            $0.top.equalTo(movieTicketView.snp.top)
                .offset(self.bounds.height * Design.reviewSectionRadius)
            $0.leading.equalToSuperview().offset(Design.defaultMargin)
            $0.trailing.equalToSuperview().offset(-Design.defaultMargin)
            $0.bottom.equalTo(movieTicketView.snp.bottom)
                .offset(-self.bounds.height * (1 - Design.dateSectionRadius) - Design.defaultMargin)
        }
        
        starRatingView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(Design.starRatingViewRadius)
            $0.centerX.equalToSuperview()
        }
        
        barcodeSectionStackView.snp.makeConstraints {
            $0.top.equalTo(movieTicketView.snp.top)
                .offset(self.bounds.height * Design.dateSectionRadius + (Design.defaultMargin * 2))
            $0.leading.equalToSuperview().offset(Design.defaultMargin)
            $0.trailing.equalToSuperview().offset(-Design.defaultMargin)
            $0.bottom.equalToSuperview().offset(-Design.defaultMargin / 2)
        }
        
        barcodeImageView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(Design.barcodeRadius)
        }
    }
}

extension ReviewCell {
    private enum Design {
        static let defaultMargin: CGFloat = 16.0
        static let titleMargin: CGFloat = 20.0
        
        static let posterSectionRadius: CGFloat = 0.5
        static let reviewSectionRadius: CGFloat = 0.6
        static let dateSectionRadius: CGFloat = 0.85
        
        static let starRatingViewRadius: CGFloat = 0.4
        static let barcodeRadius: CGFloat = 0.4
    }
}
