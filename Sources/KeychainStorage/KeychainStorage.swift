import Foundation
import Security

// MARK: - KeychainStorageError

/// An enumeration representing errors that can occur while accessing the Keychain.
///
/// - unhandledError: Thrown when a Keychain operation fails with a specific `OSStatus`.
/// - invalidData: Thrown when the data received is in an invalid format.
public enum KeychainStorageError: Error {
    case unhandledError(OSStatus)
    case invalidData
}

// MARK: - KeychainStorage

/// A class that acts as a wrapper for Keychain operations, associated with a specific service.
/// All Keychain items are treated as generic passwords, represented by `kSecClassGenericPassword`.
public class KeychainStorage {
    
    /// The service that will be used for all Keychain queries.
    private let service: String
    
    /// Initializes a new instance of `KeychainStorage` with the specified service.
    ///
    /// - Parameter service: The service that will be used for all Keychain queries.
    public init(service: String) {
        self.service = service
    }
}

// MARK: - KeyValueStorage

extension KeychainStorage: KeyValueStorage {
    
    /// Stores a Boolean value in the Keychain.
    ///
    /// ### Usage Example: ###
    /// ```swift
    /// let storage = KeychainStorage(service: "com.foo")
    /// try storage.set(true, key: "myKey")
    /// ```
    ///
    /// - Parameters:
    ///   - value: The Boolean value to be stored in the Keychain.
    ///   - key: The key under which the value will be stored.
    /// - Throws: Throws `KeychainStorageError.unhandledError` if the operation fails.
    public func set(_ value: Bool, key: String) throws {
        let bytes: [UInt8] = value ? [1] : [0]
        let data = Data(bytes)
        
        try set(data, key: key)
    }
    
    /// Stores a Data value in the Keychain.
    ///
    /// ### Usage Example: ###
    /// ```swift
    /// let data = Data(base64Encoded: "encoded")!
    /// let storage = KeychainStorage(service: "com.foo")
    /// try storage.set(data, key: "myKey")
    /// ```
    ///
    /// - Parameters:
    ///   - value: The Data value to be stored in the Keychain.
    ///   - key: The key under which the value will be stored.
    /// - Throws: Throws `KeychainStorageError.unhandledError` if the operation fails.
    public func set(_ value: Data, key: String) throws {
        let query = KeychainBasicQueryFactory.makeQuery(forService: service, key: key, value: value)
        
        // Remove any existing item at the specified key to avoid duplication
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status != noErr {
            throw KeychainStorageError.unhandledError(status)
        }
    }
    
    /// Stores a String value in the Keychain.
    ///
    /// ### Usage Example: ###
    /// ```swift
    /// let storage = KeychainStorage(service: "com.foo")
    /// try storage.set("Super secret value", key: "myKey")
    /// ```
    ///
    /// - Parameters:
    ///   - value: The String value to be stored in the Keychain.
    ///   - key: The key under which the value will be stored.
    /// - Throws: Throws `KeychainStorageError.invalidData` if the value cannot be converted to Data or `KeychainStorageError.unhandledError` if the operation fails.
    public func set(_ value: String, key: String) throws {
        guard let data = value.data(using: .utf8) else {
            throw KeychainStorageError.invalidData
        }
        
        try set(data, key: key)
    }
    
    /// Retrieves the String value associated with the specified key.
    ///
    /// ### Usage Example: ###
    /// ```swift
    /// let storage = KeychainStorage(service: "com.foo")
    /// if let myValue = try? storage.string(forKey: "myKey") {
    ///     // Use `myValue`
    /// }
    /// ```
    ///
    /// - Parameter key: The key for which to retrieve the value.
    /// - Returns: The String value associated with the key, or `nil` if not found.
    /// - Throws: Throws `KeychainStorageError.invalidData` if the data is invalid or cannot be converted.
    public func string(forKey key: String) throws -> String? {
        guard let data = try data(forKey: key) else {
            return nil
        }
        
        guard let value = String(data: data, encoding: .utf8) else {
            throw KeychainStorageError.invalidData
        }
        
        return value
    }
    
    /// Retrieves the Data value associated with the specified key.
    ///
    /// ### Usage Example: ###
    /// ```swift
    /// let storage = KeychainStorage(service: "com.foo")
    /// if let myValue = try? storage.data(forKey: "myKey") {
    ///     // Use `myValue`
    /// }
    /// ```
    ///
    /// - Parameter key: The key for which to retrieve the value.
    /// - Returns: The Data value associated with the key, or `nil` if not found.
    /// - Throws: Throws `KeychainStorageError.unhandledError` if the operation fails.
    public func data(forKey key: String) throws -> Data? {
        let query = KeychainBasicQueryFactory.makeQuery(forService: service, key: key)
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecItemNotFound {
            return nil
        }
        
        guard status == noErr else {
            throw KeychainStorageError.unhandledError(status)
        }
        
        if let resultDictionary = result as? [String: Any],
           let data = resultDictionary[kSecValueData as String] as? Data {
            return data
        }
        
        return nil
    }
    
    /// Retrieves the Boolean value associated with the specified key.
    ///
    /// ### Usage Example: ###
    /// ```swift
    /// let storage = KeychainStorage(service: "com.foo")
    /// if let myValue = try? storage.bool(forKey: "myKey") {
    ///     // Use `myValue`
    /// }
    /// ```
    ///
    /// - Parameter key: The key for which to retrieve the value.
    /// - Returns: The Boolean value associated with the key, or `nil` if not found.
    /// - Throws: Throws `KeychainStorageError.unhandledError` if the operation fails.
    public func bool(forKey key: String) throws -> Bool? {
        guard let data = try data(forKey: key) else {
            return nil
        }
        
        if let value = data.first {
            return value == 1
        }
        
        return nil
    }
    
    /// Removes the value associated with the specified key from the Keychain.
    ///
    /// - Parameter key: The key for which to remove the value.
    /// - Throws: Throws `KeychainStorageError.unhandledError` if the operation fails.
    public func removeValue(forKey key: String) throws {
        let query = KeychainBasicQueryFactory.makeDeleteQuery(forService: service, key: key)
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status != errSecItemNotFound && status != errSecSuccess {
            throw KeychainStorageError.unhandledError(status)
        }
    }
    
    /// Removes all values associated with the service from the Keychain.
    ///
    /// - Throws: Throws `KeychainStorageError.unhandledError` if the operation fails.
    public func removeAll() throws {
        let query = KeychainBasicQueryFactory.makeDeleteQuery(forService: service)
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status != errSecItemNotFound && status != errSecSuccess {
            throw KeychainStorageError.unhandledError(status)
        }
    }
}
