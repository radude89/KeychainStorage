import Foundation
import Security

// MARK: - KeychainBasicQueryConfiguration

/// A structure that defines a basic configuration for querying Keychain items.
struct KeychainBasicQueryConfiguration {
    
    /// The item class value, represented by `kSecClass`.
    /// This can be one of the following:
    /// - `kSecClassGenericPassword`: Generic password item.
    /// - `kSecClassInternetPassword`: Internet password item.
    /// - `kSecClassCertificate`: Certificate item.
    /// - `kSecClassKey`: Cryptographic key item.
    /// - `kSecClassIdentity`: Identity item.
    let secClass: String
    
    /// The matching limit for a Keychain query.
    /// This can be either:
    /// - `kSecMatchLimitAll`: Allows an unlimited number of matched items.
    /// - `kSecMatchLimitOne`: Only matches a single item.
    let matchLimit: String
    
    /// Indicates whether the associated data should be returned.
    let returnData: Bool
    
    /// Indicates whether the attributes should be returned.
    let returnAttributes: Bool
    
    /// Initializes a new configuration with the specified parameters.
    ///
    /// - Parameters:
    ///   - secClass: The item class value. Defaults to `kSecClassGenericPassword`.
    ///   - matchLimit: The match limit for the query. Defaults to `kSecMatchLimitOne`.
    ///   - returnData: A flag indicating whether to return data. Defaults to `true`.
    ///   - returnAttributes: A flag indicating whether to return attributes. Defaults to `true`.
    init(
        secClass: String = kSecClassGenericPassword as String,
        matchLimit: String = kSecMatchLimitOne as String,
        returnData: Bool = true,
        returnAttributes: Bool = true
    ) {
        self.secClass = secClass
        self.matchLimit = matchLimit
        self.returnData = returnData
        self.returnAttributes = returnAttributes
    }
}

// MARK: - KeychainBasicQueryFactory

/// A typealias representing a dictionary for Keychain queries.
typealias KeychainQuery = [String: Any]

/// A factory for creating Keychain queries.
enum KeychainBasicQueryFactory {
    
    /// Creates a Keychain query based on the provided service, account key, value, and configuration.
    ///
    /// - Parameters:
    ///   - service: The Keychain item's service.
    ///   - key: The item's account name. Can be `nil`.
    ///   - value: The item's value. Can be `nil`.
    ///   - configuration: The configuration settings for the Keychain query. Defaults to a new instance of `KeychainBasicQueryConfiguration`.
    /// - Returns: A dictionary representing the Keychain query.
    static func makeQuery(forService service: String,
                          key: String? = nil,
                          value: Data? = nil,
                          configuration: KeychainBasicQueryConfiguration = KeychainBasicQueryConfiguration()) -> KeychainQuery {
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
    
    /// Creates a query for deleting Keychain items based on the provided service, account key, and configuration.
    ///
    /// - Parameters:
    ///   - service: The Keychain item's service.
    ///   - key: The item's account name. Can be `nil`.
    ///   - configuration: The configuration settings for the Keychain query. Defaults to a new instance of `KeychainBasicQueryConfiguration`.
    /// - Returns: A dictionary representing the Keychain delete query.
    static func makeDeleteQuery(forService service: String,
                                key: String? = nil,
                                configuration: KeychainBasicQueryConfiguration = KeychainBasicQueryConfiguration()) -> KeychainQuery {
        var queryDictionary: [String: Any] = [:]
        queryDictionary[kSecAttrService as String] = service
        queryDictionary[kSecClass as String] = configuration.secClass
        
        if let key = key {
            queryDictionary[kSecAttrAccount as String] = key
        }
        
        return queryDictionary
    }
}
