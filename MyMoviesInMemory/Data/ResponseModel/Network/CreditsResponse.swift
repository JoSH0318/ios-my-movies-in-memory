//
//  CreditsResponse.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/18.
//

import Foundation

// MARK: - CreditsResponse

struct CreditsResponse: Codable {
    let id: Int
    let cast: [Actor]
    let crew: [Director]
    
    enum CodingKeys: String, CodingKey {
        case id, cast, crew
    }
}

extension CreditsResponse {
    func toMovieOfficial() -> MovieOfficial {
        return MovieOfficial(
            actors: selectMainActors(self.cast),
            director: self.crew[safe: 0]?.name ?? ""
        )
    }

    private func selectMainActors(_ cast: [Actor]) -> String {
        let mainActors = cast
            .filter { $0.order < 4 }
            .compactMap { $0.name }
            .joined(separator: ", ")
        
        return mainActors
    }
}

// MARK: - Actor

struct Actor: Codable {
    let adult: Bool?
    let gender: Int?
    let id: Int?
    let department: String?
    let name: String?
    let originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String?
    let order: Int
    
    enum CodingKeys: String, CodingKey {
        case adult, gender, id, name, popularity, character, order
        case department = "known_for_department"
        case originalName = "original_name"
        case profilePath = "profile_path"
        case castID = "cast_id"
        case creditID = "credit_id"
    }
}

// MARK: - Director

struct Director: Codable {
    let adult: Bool?
    let gender: Int?
    let id: Int?
    let name: String?
    let originalName: String?
    let popularity: Double?
    let profilePath: String?
    let creditID: String?
    let department: String?
    let job: String?
    
    enum CodingKeys: String, CodingKey {
        case adult, gender, id, name, popularity, job
        case originalName = "original_name"
        case profilePath = "profile_path"
        case creditID = "credit_id"
        case department = "known_for_department"
    }
}

