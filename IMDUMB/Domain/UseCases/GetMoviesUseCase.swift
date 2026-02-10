//
//  GetMoviesUseCase.swift
//  IMDUMB
//
//  Created by GiAn on 9/02/26.
//

import Foundation

protocol GetMoviesUseCaseProtocol {
    func execute(completion: @escaping (Result<HomeContent, Error>) -> Void)
}

class GetMoviesUseCase: GetMoviesUseCaseProtocol {

    private let repository: MovieRepositoryProtocol

    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<HomeContent, Error>) -> Void) {
        let group = DispatchGroup()
        var trending = [Movie]()
        var topRated = [Movie]()
        var upcoming = [Movie]()
        var lastError: Error?

        group.enter()
        repository.fetchMovies(type: .popular) { result in
            if case .success(let movies) = result { trending = movies }
            else if case .failure(let error) = result { lastError = error }
            group.leave()
        }

        group.enter()
        repository.fetchMovies(type: .topRated) { result in
            if case .success(let movies) = result { topRated = movies }
            group.leave()
        }

        group.enter()
        repository.fetchMovies(type: .upcoming) { result in
            if case .success(let movies) = result { upcoming = movies }
            group.leave()
        }

        group.notify(queue: .main) {
            if let error = lastError {
                completion(.failure(error))
            } else {
                let content = HomeContent(trending: trending,
                                        topRated: topRated,
                                        upcoming: upcoming)
                completion(.success(content))
            }
        }
    }
}
