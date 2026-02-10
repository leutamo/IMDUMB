//
//  MovieImage.swift
//  IMDUMB
//
//  Created by GiAn on 10/02/26.
//

import Foundation

struct MovieImagesResponse: Codable {
    let backdrops: [MovieImage]
}

struct MovieImage: Codable {
    let filePath: String
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
    
    var fullURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w780\(filePath)")
    }
}
