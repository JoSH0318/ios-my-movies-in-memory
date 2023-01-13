//
//  PosterRepository.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/01/13.
//

import Foundation
import RxSwift

final class PosterRepository {
    private let networkProvider: NetworkProvider
    
    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
    
    func fetchPosterUrl(_ posetUrl: String) -> Observable<String> {
        
        let endpoint = EndpointStorage
            .OMDbMovieAPI(posetUrl)
            .asEndpoint
        
        return networkProvider.execute(endpoint: endpoint)
            .decode(type: PosterResponse.self, decoder: JSONDecoder())
            .map { response in
                response.posterImageUrl
            }
    }
}
