//
//  FirebaseDataStore.swift
//  IMDUMB
//
//  Created by GiAn on 9/02/26.
//

import Foundation
import FirebaseDatabase

protocol FirebaseDataStoreProtocol {
    func getRemoteData(completion: @escaping ([String: Any]?) -> Void)
}

class FirebaseDataStore: FirebaseDataStoreProtocol {
    private let ref = Database.database().reference()

    func getRemoteData(completion: @escaping ([String: Any]?) -> Void) {
        ref.child("app_config").observeSingleEvent(of: .value) { snapshot in
            completion(snapshot.value as? [String: Any])
        }
    }
}
