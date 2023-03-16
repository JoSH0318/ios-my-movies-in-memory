//
//  SearchViewController.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/14.
//

import SnapKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
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
            .bind(to: searchCollectionView.rx.items(
                cellIdentifier: SearchCell.identifier,
                cellType: SearchCell.self
            )) { index, item, cell in
                cell.bind(item)
            }
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
            width: UIScreen.main.bounds.width - 40,
            height: UIScreen.main.bounds.height * 0.2
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
