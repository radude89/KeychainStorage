import Foundation

// MARK: - Key-Value Storage

/// A protocol defining a generic key-value storage interface.
/// Conforming types can implement storage solutions such as Keychain or UserDefaults.
public protocol KeyValueStorage {
    
    /// Retrieves the string value associated with the specified key.
    ///
    /// - Parameter key: The key for which to retrieve the value.
    /// - Returns: The string value associated with the key, or `nil` if not found.
    /// - Throws: Throws an error if the data is invalid or if a transformation error occurs.
    func string(forKey key: String) throws -> String?
    
    /// Retrieves the data value associated with the specified key.
    ///
    /// - Parameter key: The key for which to retrieve the value.
    /// - Returns: The data value associated with the key, or `nil` if not found.
    /// - Throws: Throws an error if the data is invalid or if a transformation error occurs.
    func data(forKey key: String) throws -> Data?
    
    /// Retrieves the Boolean value associated with the specified key.
    ///
    /// - Parameter key: The key for which to retrieve the value.
    /// - Returns: The Boolean value associated with the key, or `nil` if not found.
    /// - Throws: Throws an error if the data is invalid or if a transformation error occurs.
    func bool(forKey key: String) throws -> Bool?
    
    /// Stores a string value at the specified key.
    ///
    /// - Parameters:
    ///   - value: The string value to be stored.
    ///   - key: The key under which to store the value.
    /// - Throws: Throws an error if the data is invalid or if a transformation error occurs.
    func set(_ value: String, key: String) throws
    
    /// Stores a data value at the specified key.
    ///
    /// - Parameters:
    ///   - value: The data value to be stored.
    ///   - key: The key under which to store the value.
    /// - Throws: Throws an error if the data is invalid or if a transformation error occurs.
    func set(_ value: Data, key: String) throws
    
    /// Stores a Boolean value at the specified key.
    ///
    /// - Parameters:
    ///   - value: The Boolean value to be stored.
    ///   - key: The key under which to store the value.
    /// - Throws: Throws an error if the data is invalid or if a transformation error occurs.
    func set(_ value: Bool, key: String) throws
    
    /// Removes the value associated with the specified key.
    ///
    /// - Parameter key: The key for which to remove the value.
    /// - Throws: Throws an error if the operation is unsuccessful.
    func removeValue(forKey key: String) throws
    
    /// Removes all values from the storage.
    ///
    /// - Throws: Throws an error if any value fails to be removed from the storage.
    func removeAll() throws
}
