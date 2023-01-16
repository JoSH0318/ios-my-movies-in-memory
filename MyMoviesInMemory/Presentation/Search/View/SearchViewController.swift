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
    
    private let viewModel: SearchViewModel
    private let disposeBag = DisposeBag()
    private let searchBar = UISearchBar()
    private let searchCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Initializer
    
    init(_ viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        configureCollectionView()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Binding
    
    private func bind() {
        let searchedMovie = searchBar.rx.text.orEmpty.asObservable()
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
}
