//
//  EditView.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/01.
//

import SnapKit

final class EditView: UIView {
    
    // MARK: - Constant
    
    private enum FontSize {
        static let title: CGFloat = 16.0
    }
    
    // MARK: - Properties
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let summaryView = SummaryView()
    
    private(set) var starRatingView = StarRatingView()
    
    private let oneLineCommentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "📝 나만의 영화 한 줄평을 적어보세요"
        textField.font = .systemFont(ofSize: FontSize.title)
        return textField
    }()
    
    private let movieReportTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "📝 영화의 감상평을 적어보세요."
        textField.textAlignment = .left
        textField.font = .systemFont(ofSize: FontSize.title)
        textField.setContentHuggingPriority(.init(1), for: .vertical)
        return textField
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
    
    // MARK: - Methods
    
    func bind() {}
    
    func dragStarSlider(_ rating: Int) {
        starRatingView.dragStarSlider(rating)
    }
    
    private func configureView() {
        backgroundColor = .MBeige
    }
    
    private func configureUI() {
        addSubview(mainStackView)

        mainStackView.addArrangedSubview(summaryView)
        mainStackView.addArrangedSubview(starRatingView)
        mainStackView.addArrangedSubview(oneLineCommentTextField)
        mainStackView.addArrangedSubview(movieReportTextField)
    }
    
    private func configureConstraints() {
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.bottom.equalToSuperview().offset(-20)
        }
        
        summaryView.snp.makeConstraints {
            $0.height.equalTo(self.snp.height).multipliedBy(0.2)
        }
        
        starRatingView.snp.makeConstraints {
            $0.height.equalTo(self.snp.height).multipliedBy(0.07)
        }
        
        oneLineCommentTextField.snp.makeConstraints {
            $0.height.equalTo(self.snp.height).multipliedBy(0.1)
        }
    }
}
