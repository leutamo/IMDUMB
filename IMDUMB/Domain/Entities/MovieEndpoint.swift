//
//  MovieEndpoint.swift
//  IMDUMB
//
//  Created by GiAn on 9/02/26.
//

import Foundation

enum MovieEndpoint: String {
    case popular = "movie/popular"
    case topRated = "movie/top_rated"
    case upcoming = "movie/upcoming"
}

struct HomeContent {
    let trending: [Movie]
    let topRated: [Movie]
    let upcoming: [Movie]
}
