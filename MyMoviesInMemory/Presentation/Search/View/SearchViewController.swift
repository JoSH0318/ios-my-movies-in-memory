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
    private let searchBar = UISearchBar()
    private lazy var searchCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: configureCollectionViewLayout()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Initializer
    
    init(
        _ viewModel: SearchViewModel,
        _ coordinator: SearchCoordinator
    ) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        configureCollectionView()
        configureNavigationItem()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Binding
    
    private func bind() {
        let searchedMovie = searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(10), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
        let input = SearchViewModel.Input(didEndSearching: searchedMovie)

        viewModel.transform(input)
            .movies
            .bind(to: searchCollectionView.rx.items(
                cellIdentifier: SearchedMovieCell.identifier,
                cellType: SearchedMovieCell.self
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
    
    private func configureCollectionView() {
        searchCollectionView.register(
            SearchedMovieCell.self,
            forCellWithReuseIdentifier: SearchedMovieCell.identifier
        )
        
        searchCollectionView.backgroundColor = UIColor.MBeige
        
        view.addSubview(searchCollectionView)
        
        searchCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.2)
        return flowLayout
    }
    
    private func configureNavigationItem() {
        searchBar.placeholder = "Search Movie"
        self.navigationItem.titleView = searchBar
    }
}
