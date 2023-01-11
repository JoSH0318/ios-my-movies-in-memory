//
//  DummyMovieReview.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/30.
//

import Foundation

struct DummyMovieReview {
    let dummy1 = Review(
        title: "스타워즈",
        id: "test.com",
        subtitle: "The Last Jedi",
        imageUrl: "https://ssl.pstatic.net/imgmovie/mdi/mit110/1254/125488_P20_135324.jpg",
        openingYear: "2017",
        director: "라이언 존슨",
        actors: "데이지 리들리 | 테스터",
        userRating: 5.0,
        personalRating: 5.0,
        commentary: "test",
        recordDate: "2023.01.01"
    )
    
    let dummy2 = Review(
        title: "스타워즈11",
        id: "test.com11",
        subtitle: "The Last Jedi",
        imageUrl: "https://ssl.pstatic.net/imgmovie/mdi/mit110/1254/125488_P20_135324.jpg",
        openingYear: "2017",
        director: "라이언 존슨",
        actors: "데이지 리들리 | 테스터",
        userRating: 5.0,
        personalRating: 4.0,
        commentary: "test",
        recordDate: "2023.01.02"
    )
}
