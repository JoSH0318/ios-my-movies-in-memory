//
//  SearchViewController.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/14.
//

import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class SearchViewController: UIViewController {
    
    typealias DataSource = RxCollectionViewSectionedReloadDataSource<MovieSection>
    
    // MARK: - Properties
    
    private let coordinator: SearchCoordinator
    private let viewModel: SearchViewModel
    private let disposeBag = DisposeBag()
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search Movies"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.showsCancelButton = false
        return searchController
    }()
    private lazy var searchCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: configureCollectionViewLayout()
    )
    private var dataSource = DataSource {_, collectionView, indexPath, item in
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchCell.identifier, for: indexPath
        ) as? SearchCell else { return SearchCell() }
        
        cell.bind(item)
        return cell
    }
    
    // MARK: - Initializer
    
    init(
        _ viewModel: SearchViewModel,
        _ coordinator: SearchCoordinator
    ) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        configureLayout()
        setUpSearchViewController()
        bind()
    }
    
    // MARK: - Bind
    
    private func bind() {
        let searchedMovie = searchController.searchBar.rx
            .searchButtonClicked
            .withLatestFrom(
                searchController.searchBar.rx
                    .text
                    .orEmpty
            )
            .map { $0 }
        
        let input = SearchViewModel.Input(didEndSearching: searchedMovie)
        let output = viewModel.transform(input)
        
        output
            .movies
            .map { movies in
                [MovieSection(items: movies)]
            }
            .bind(to: searchCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        searchCollectionView.rx.modelSelected(Movie.self)
            .withUnretained(self)
            .bind(onNext: { owner, movie in
                owner.coordinator.presentSearchDetailView(with: movie)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    
    private func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(
            width: UIScreen.main.bounds.width - (Design.defaultMargin * 2),
            height: UIScreen.main.bounds.height * Design.itemCountRatio
        )
        return flowLayout
    }
    
    private func registerCell() {
        searchCollectionView.register(
            SearchCell.self,
            forCellWithReuseIdentifier: SearchCell.identifier
        )
    }
    
    private func configureLayout() {
        searchCollectionView.backgroundColor = .MBeige
        
        view.addSubview(searchCollectionView)
        
        searchCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setUpSearchViewController() {
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "영화 찾기"
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension SearchViewController {
    private enum Design {
        static let defaultMargin: CGFloat = 20.0
        static let itemCountRatio: CGFloat = 0.2
    }
}

struct MovieSection {
    var items: [Movie]
}

extension MovieSection: SectionModelType {
    typealias Item = Movie
    
    init(original: MovieSection, items: [Movie]) {
        self = original
        self.items = items
    }
}
