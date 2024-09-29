//
//  MyAppKeychain.swift
//  KeychainStorageExample
//
//  Created by Dan, Radu-Ionut (RO - Bucharest) on 26/05/2019.
//  Copyright © 2019 radude89. All rights reserved.
//

import Foundation
import KeychainStorage

final class MyAppKeychain {
    
    private enum Keys {
        static let rememberMe = "myapp_remember"
        static let secret = "myapp_secret"
    }
    
    let storage: KeyValueStorage
    static let shared: MyAppKeychain = .init()
    
    init(storage: KeyValueStorage = KeychainStorage(service: "com.keychainstorage.example")) {
        self.storage = storage
    }
    
}

extension MyAppKeychain {
    var rememberMe: Bool? {
        get {
            return try? storage.bool(forKey: Keys.rememberMe)
        }
        set {
            if let newValue = newValue {
                try? storage.set(newValue, key: Keys.rememberMe)
            } else {
                try? storage.removeValue(forKey: Keys.rememberMe)
            }
        }
    }
    
    var secret: String? {
        get {
            return try? storage.string(forKey: Keys.secret)
        }
        set {
            if let newValue = newValue {
                try? storage.set(newValue, key: Keys.secret)
            } else {
                try? storage.removeValue(forKey: Keys.secret)
            }
        }
    }
}
