//
//  ConfigRepository.swift
//  IMDUMB
//
//  Created by GiAn on 9/02/26.
//

import Foundation

class ConfigRepository: ConfigRepositoryProtocol {
    
    private let remoteDataStore: FirebaseDataStoreProtocol
    
    init(remoteDataStore: FirebaseDataStoreProtocol) {
        self.remoteDataStore = remoteDataStore
    }
    
    func fetchAppConfig(completion: @escaping (Result<AppConfig, Error>) -> Void) {
        remoteDataStore.getRemoteData { data in
            guard let data = data,
                  let msg = data["welcome_message"] as? String,
                  let enabled = data["is_feature_enabled"] as? Bool else {
                completion(.failure(NSError(domain: "DataError", code: 0, userInfo: nil)))
                return
            }
            
            let config = AppConfig(welcomeMessage: msg, isFeatureEnabled: enabled)
            completion(.success(config))
        }
    }
}
