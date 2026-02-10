//
//  MovieRemoteDataStore.swift
//  IMDUMB
//
//  Created by GiAn on 9/02/26.
//

import Foundation
import Alamofire

class MovieRemoteDataStore: MovieRepositoryProtocol {
    
    private let apiKey = "502e812aac1a83c358af42faeb94c72f"
    private let baseUrl = "https://api.themoviedb.org/3"

    func fetchMovies(type: MovieEndpoint, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        let urlString = "\(baseUrl)/\(type.rawValue)?api_key=\(apiKey)&language=es-ES"
        
        AF.request(urlString).validate().responseDecodable(of: MovieResponse.self) { response in
            switch response.result {
            case .success(let movieResponse):
                completion(.success(movieResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMovieImages(id: Int, completion: @escaping (Result<[MovieImage], Error>) -> Void) {
        let url = "\(baseUrl)/movie/\(id)/images?api_key=\(apiKey)"
        
        AF.request(url).validate().responseDecodable(of: MovieImagesResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data.backdrops))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
