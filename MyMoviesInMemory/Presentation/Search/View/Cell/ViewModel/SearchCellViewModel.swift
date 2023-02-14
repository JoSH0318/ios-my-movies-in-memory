//
//  SearchedMovieCellViewModel.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/15.
//

import Foundation
import RxSwift
import UIKit

final class SearchCellViewModel {
    
    // MARK: - Input
    
    struct Input {
        let setupCell: Observable<Movie>
    }
    
    // MARK: - Output
    
    struct Output {
        let searchCellViewModelItem: Observable<SearchCellViewModelItem>
    }
    
    // MARK: - Methods
    
    func transform(_ input: Input) -> Output {
        let searchCellViewModelItem = input.setupCell
            .map { movie in
                SearchCellViewModelItem(movie: movie)
            }
            
        
        return Output(searchCellViewModelItem: searchCellViewModelItem)
    }
}
