//
//  Genre.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/02.
//

import Foundation

enum Genre: Int {
    case action = 28
    case animated = 16
    case documentary = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case comedy = 35
    case war = 10752
    case crime = 80
    case music = 10402
    case mystery = 9648
    case romance = 10749
    case sciFi = 878
    case horror = 27
    case TVMovie = 10770
    case thriller = 53
    case western = 37
    case adventure = 12
    case etc = -1
    
    var description: String {
        switch self {
        case .action:
            return "액션"
        case .animated:
            return "애니메이션"
        case .documentary:
            return "다큐"
        case .drama:
            return "드라마"
        case .family:
            return "가족"
        case .fantasy:
            return "판타지"
        case .history:
            return "역사"
        case .comedy:
            return "코미디"
        case .war:
            return "액션"
        case .crime:
            return "범죄"
        case .music:
            return "음악"
        case .mystery:
            return "미스테리"
        case .romance:
            return "로맨스"
        case .sciFi:
            return "SF"
        case .horror:
            return "호러"
        case .TVMovie:
            return "TV영화"
        case .thriller:
            return "스릴러"
        case .western:
            return "서부극"
        case .adventure:
            return "어드벤처"
        case .etc:
            return ""
        }
    }
}
