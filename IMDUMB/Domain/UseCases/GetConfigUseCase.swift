//
//  GetConfigUseCase.swift
//  IMDUMB
//
//  Created by GiAn on 9/02/26.
//

protocol GetConfigUseCaseProtocol {
    func execute(completion: @escaping (Result<AppConfig, Error>) -> Void)
}

class GetConfigUseCase: GetConfigUseCaseProtocol {
    private let repository: ConfigRepositoryProtocol

    init(repository: ConfigRepositoryProtocol) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<AppConfig, Error>) -> Void) {
        repository.fetchAppConfig(completion: completion)
    }
}
