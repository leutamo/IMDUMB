//
//  ConfigRepositoryProtocol.swift
//  IMDUMB
//
//  Created by GiAn on 9/02/26.
//

import Foundation

protocol ConfigRepositoryProtocol {
    func fetchAppConfig(completion: @escaping (Result<AppConfig, Error>) -> Void)
}
