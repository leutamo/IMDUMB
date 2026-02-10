//
//  SessionManager.swift
//  IMDUMB
//
//  Created by GiAn on 9/02/26.
//

import Foundation

class SessionManager {
    static let shared = SessionManager()
    
    var appConfig: AppConfig?
    
    private init() {}
}
