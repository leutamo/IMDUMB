//
//  MovieRepositoryProtocol.swift
//  IMDUMB
//
//  Created by GiAn on 9/02/26.
//

protocol MovieRepositoryProtocol {
    func fetchMovies(type: MovieEndpoint, completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchMovieImages(id: Int, completion: @escaping (Result<[MovieImage], Error>) -> Void)
}
