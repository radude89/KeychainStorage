//
//  KeychainQueryFactory.swift
//  KeychainStorage
//
//  Created by Dan, Radu-Ionut (RO - Bucharest) on 25/05/2019.
//  Copyright © 2019 radude89. All rights reserved.
//

import Foundation
import Security

// MARK: - KeychainQueryBasicConfiguration

/// This structure defines a basic configuration for making queries for Keychain items.
struct KeychainBasicQueryConfiguration {
    
    /// Defines the item class value, kSecClass.
    /// Can be a:
    /// * generic password item (kSecClassGenericPassword)
    /// * Internet password item (kSecClassInternetPassword)
    /// * certificate item (kSecClassCertificate)
    /// * cryptographic key item (kSecClassKey)
    /// * identity item (kSecClassIdentity)
    let secClass: String
    
    /// Defines the matching limit for a Keychain item.
    /// Can be either `kSecMatchLimitAll`, where an unlimited number of items can be matched
    /// or `kSecMatchLimitOne`, where a single item will be matched.
    let matchLimit: String
    
    /// Determines if data should be returned or not.
    let returnData: Bool
    
    /// Determines if attributes should be returned or not
    let returnAttributes: Bool
    
    /// Default initializer where all parameters are set.
    ///
    /// - Parameters:
    ///   - secClass: Sets the item class value.
    ///   - matchLimit: Sets the match limit of the query.
    ///   - returnData: Sets the parameter for returning data or not.
    ///   - returnAttributes: Sets the parameter for returning attributes or not.
    init(secClass: String = kSecClassGenericPassword as String,
         matchLimit: String = kSecMatchLimitOne as String,
         returnData: Bool = true,
         returnAttributes: Bool = true) {
        self.secClass = secClass
        self.matchLimit = matchLimit
        self.returnData = returnData
        self.returnAttributes = returnAttributes
    }
}

// MARK: - KeychainBasicQueryFactory

/// Creates queries for accessing the Keychain
enum KeychainBasicQueryFactory {
    
    /// Makes a Keychain query based on a service, configuration, account and value.
    ///
    /// - Parameters:
    ///   - service: The Keychain item's service.
    ///   - key: The item's account name. Can be nil.
    ///   - value: The item's value. Can be nil.
    ///   - configuration: The configuration of the Keychain query.
    /// - Returns: The Keychain query.
    static func makeQuery(forService service: String,
                          key: String? = nil,
                          value: Data? = nil,
                          configuration: KeychainBasicQueryConfiguration = KeychainBasicQueryConfiguration()) -> [String: Any] {
        var queryDictionary: [String: Any] = [:]
        queryDictionary[kSecAttrService as String] = service
        queryDictionary[kSecClass as String] = configuration.secClass
        
        if let key = key {
            queryDictionary[kSecAttrAccount as String] = key
        }
        
        if let value = value {
            queryDictionary[kSecValueData as String] = value
        } else {
            queryDictionary[kSecMatchLimit as String] = configuration.matchLimit
            queryDictionary[kSecReturnData as String] = configuration.returnData
            queryDictionary[kSecReturnAttributes as String] = configuration.returnAttributes
        }
        
        return queryDictionary
    }
}
