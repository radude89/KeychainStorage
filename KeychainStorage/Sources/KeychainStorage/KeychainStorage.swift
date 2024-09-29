import Foundation
import Security

// MARK: - KeychainStorageError

/// Defines the keychain errors.
///
/// - unhandledError: Thrown when a keychain operation failed with a given `OSStatus`.
/// - invalidData: Thrown when the data expected was with an invalid format.
public enum KeychainStorageError: Error {
    case unhandledError(OSStatus)
    case invalidData
}

// MARK: - KeychainStorage

/// This class is a wrapper to the Keychain, defined by a service.
/// All Keychain items are considered generic passwords `kSecClassGenericPassword`.
public class KeychainStorage {
    
    /// Defines the service which all Keychain queries will use.
    private let service: String
    
    /// Base class initializer, where the service variable is set.
    ///
    /// - Parameter service: The service that will be used for all Keychain queries.
    public init(service: String) {
        self.service = service
    }
}

// MARK: - KeyValueStorage

extension KeychainStorage: KeyValueStorage {
    
    /// Sets a bool value in the Keychain.
    ///
    /// ### Usage Example: ###
    ///
    /// ````
    /// let storage = KeychainStorage(service: "com.foo")
    /// try storage.set(true, key: "myKey")
    /// ````
    ///
    /// - Parameters:
    ///   - value: The value to be set in the Keychain.
    ///   - key: The key we want to put the value.
    /// - Throws: Can throw an `unhandledError` with a status.
    public func set(_ value: Bool, key: String) throws {
        let bytes: [UInt8] = value ? [1] : [0]
        let data = Data(bytes)
        
        try set(data, key: key)
    }
    
    /// Sets a data value in the Keychain.
    ///
    /// ### Usage Example: ###
    ///
    /// ````
    /// let data = Data(base64Encoded: "encoded")!
    /// let storage = KeychainStorage(service: "com.foo")
    /// try storage.set(data, key: "myKey")
    /// ````
    ///
    /// - Parameters:
    ///   - value: The value to be set in the Keychain.
    ///   - key: The key we want to put the value.
    /// - Throws: Can throw an `unhandledError` with a status.
    public func set(_ value: Data, key: String) throws {
        let query = KeychainBasicQueryFactory.makeQuery(forService: service, key: key, value: value)
        
        // Delete anything that's already there, just in case
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status != noErr {
            throw KeychainStorageError.unhandledError(status)
        }
    }
    
    /// Sets a string value in the Keychain.
    ///
    /// ### Usage Example: ###
    ///
    /// ````
    /// let storage = KeychainStorage(service: "com.foo")
    /// try storage.set("Super secret value", key: "myKey")
    /// ````
    ///
    /// - Parameters:
    ///   - value: The value to be set in the Keychain.
    ///   - key: The key we want to put the value.
    /// - Throws: Can throw an `invalidData` storage error or an `unhandledError` with a status.
    public func set(_ value: String, key: String) throws {
        guard let data = value.data(using: .utf8) else {
            throw KeychainStorageError.invalidData
        }
        
        try set(data, key: key)
    }
    
    /// Returns the string value of the given key.
    ///
    /// ### Usage Example: ###
    ///
    /// ````
    /// let storage = KeychainStorage(service: "com.foo")
    /// if let myValue = try? storage.string(forKey: "myKey") {
    ///     // do something with `myValue`
    /// }
    /// ````
    ///
    /// - Parameter key: The key we want to search the value.
    /// - Returns: The value of the given key.
    /// - Throws: Can throw errors, for example if data is invalid or if there was a transformation error.
    public func string(forKey key: String) throws -> String? {
        guard let data = try data(forKey: key) else {
            return nil
        }
        
        guard let value = String(data: data, encoding: .utf8) else {
            throw KeychainStorageError.invalidData
        }
        
        return value
    }
    
    /// Returns the data value of the given key.
    ///
    /// ### Usage Example: ###
    ///
    /// ````
    /// let storage = KeychainStorage(service: "com.foo")
    /// if let myValue = try? data(forKey: "myKey") {
    ///     // do something with `myValue`
    /// }
    /// ````
    ///
    /// - Parameter key: The key we want to search the value.
    /// - Returns: The value of the given key.
    /// - Throws: Can throw an `unhandledError` with a status.
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
    
    /// Returns the bool value of the given key.
    ///
    /// ### Usage Example: ###
    ///
    /// ````
    /// let storage = KeychainStorage(service: "com.foo")
    /// if let myValue = try? bool(forKey: "myKey") {
    ///     // do something with `myValue`
    /// }
    /// ````
    ///
    /// - Parameter key: The key we want to search the value.
    /// - Returns: The value of the given key.
    /// - Throws: Can throw an `unhandledError` with a status.
    public func bool(forKey key: String) throws -> Bool? {
        guard let data = try data(forKey: key) else {
            return nil
        }
        
        if let value = data.first {
            return value == 1
        }
        
        return nil
    }
    
    /// Removes the value at a given key.
    ///
    /// - Parameter key: The key we want to remove the value.
    /// - Throws: Can throw errors if the operation was unsuccessful.
    public func removeValue(forKey key: String) throws {
        let query = KeychainBasicQueryFactory.makeDeleteQuery(forService: service, key: key)
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status != errSecItemNotFound && status != errSecSuccess {
            throw KeychainStorageError.unhandledError(status)
        }
    }
    
    /// Removes all values from the storage.
    ///
    /// - Throws: Can throw errors if a value failed to be removed from the storage.
    public func removeAll() throws {
        let query = KeychainBasicQueryFactory.makeDeleteQuery(forService: service)
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status != errSecItemNotFound && status != errSecSuccess {
            throw KeychainStorageError.unhandledError(status)
        }
    }
}
