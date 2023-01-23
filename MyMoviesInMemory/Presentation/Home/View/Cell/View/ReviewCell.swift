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
        static let title: CGFloat = 20.0
        static let subtitle: CGFloat = 16.0
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
    
    private var viewModel: ReviewCellViewModel?
    private let disposeBag = DisposeBag()
    
    private let movieTicketView: TicketView = {
        let ticketView = TicketView()
        return ticketView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let firstSectionStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: FontSize.title)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private let personalRatingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FontSize.title)
        label.textAlignment = .right
        return label
    }()
    
    private let commentaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FontSize.title)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private let thirdSectionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let linerCodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.linerCode
        imageView.contentMode = .scaleToFill
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
    
    func bind(_ review: Review) {
        viewModel = ReviewCellViewModel()
        
        let review: Observable<Review> = Observable.just(review)
        let input = ReviewCellViewModel.Input(setupCell: review)
        
        let reviewCellViewModelItem = viewModel?.transform(input)
            .reviewItem
            .share()
        
        reviewCellViewModelItem?
            .map { $0.posterImage }
            .bind(to: posterImageView.rx.image)
            .disposed(by: disposeBag)
        
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
        movieTicketView.addSubview(totalStackView)
        
        totalStackView.addArrangedSubview(firstSectionStackView)
        totalStackView.addArrangedSubview(commentaryLabel)
        totalStackView.addArrangedSubview(thirdSectionStackView)
        
        firstSectionStackView.addArrangedSubview(titleLabel)
        firstSectionStackView.addArrangedSubview(personalRatingLabel)
        thirdSectionStackView.addArrangedSubview(linerCodeImageView)
        thirdSectionStackView.addArrangedSubview(recordDate)
    }
    
    private func configureConstraints() {
        movieTicketView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints{
            $0.height.equalTo(self.bounds.height * 0.5)
            $0.leading.top.trailing.equalToSuperview()
        }
        
        totalStackView.snp.makeConstraints{
            $0.top.equalTo(posterImageView.snp.bottom)
            $0.leading.leading.equalToSuperview().offset(Design.inset)
            $0.trailing.equalToSuperview().offset(-Design.inset)
            $0.bottom.equalToSuperview()
        }
        
        firstSectionStackView.snp.makeConstraints{
            $0.height.equalTo(self.bounds.height * 0.1)
        }
        
        thirdSectionStackView.snp.makeConstraints{
            $0.height.equalTo(self.bounds.height * 0.15)
        }
        
        linerCodeImageView.snp.makeConstraints{
            $0.height.equalTo(self.bounds.height * 0.07)
        }
    }
}
