//
//  Movie.swift
//  IMDUMB
//
//  Created by GiAn on 9/02/26.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let voteAverage: Double?
    
    // Mapeamos los nombres del JSON (snake_case) a Swift (camelCase)
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}

// Estructura para agrupar por categorías (Netflix Style)
struct MovieCategory {
    let title: String
    let movies: [Movie]
}
