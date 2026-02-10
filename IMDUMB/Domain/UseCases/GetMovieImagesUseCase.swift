//
//  GetMovieImagesUseCase.swift
//  IMDUMB
//
//  Created by GiAn on 10/02/26.
//

import Foundation

// MARK: - SOLID: Dependency Inversion Principle
// El Use Case depende de una abstracción (MovieRepositoryProtocol) en lugar de
// una implementación concreta. Esto desacopla la lógica de negocio de los
// detalles técnicos del repositorio como la red o la base de datos,
// permitiendo que el sistema que sea más flexible y mas fácil de testear mediante Mocks.

protocol GetMovieImagesUseCaseProtocol {
    func execute(movieId: Int, completion: @escaping (Result<[MovieImage], Error>) -> Void)
}

class GetMovieImagesUseCase: GetMovieImagesUseCaseProtocol {
    // Dependency Inversion (SOLID)
    private let repository: MovieRepositoryProtocol

    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    func execute(movieId: Int, completion: @escaping (Result<[MovieImage], Error>) -> Void) {
        repository.fetchMovieImages(id: movieId, completion: completion)
    }
}
