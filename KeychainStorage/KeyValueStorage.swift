//
//  KeyValueStorage.swift
//  KeychainStorage
//
//  Created by Dan, Radu-Ionut (RO - Bucharest) on 25/05/2019.
//  Copyright © 2019 radude89. All rights reserved.
//

import Foundation

// MARK: - KV Storage

/// Base protocol for KeyValue storages, e.g. Keychain or UserDefaults
public protocol KeyValueStorage {
    
    /// Returns the string value of the given key.
    ///
    /// - Parameter key: The key we want to search the value.
    /// - Returns: The value of the given key.
    /// - Throws: Can throw errors, for example if data is invalid or if there was a transformation error.
    func string(forKey key: String) throws -> String?
    
    /// Returns the data value of the given key.
    ///
    /// - Parameter key: The key we want to search the value.
    /// - Returns: The value of the given key.
    /// - Throws: Can throw errors, for example if data is invalid or if there was a transformation error.
    func data(forKey key: String) throws -> Data?
    
    /// Returns the bool value of the given key.
    ///
    /// - Parameter key: The key we want to search the value.
    /// - Returns: The value of the given key.
    /// - Throws: Can throw errors, for example if data is invalid or if there was a transformation error.
    func bool(forKey key: String) throws -> Bool?
    
    /// Sets a string value at a given key.
    ///
    /// - Parameters:
    ///   - value: The value we want to store.
    ///   - key: The key where we want to store the value.
    /// - Throws: Can throw errors, for example if data is invalid or if there was a transformation error.
    func set(_ value: String, key: String) throws
    
    /// Sets a data value at a given key.
    ///
    /// - Parameters:
    ///   - value: The value we want to store.
    ///   - key: The key where we want to store the value.
    /// - Throws: Can throw errors, for example if data is invalid or if there was a transformation error.
    func set(_ value: Data, key: String) throws
    
    /// Sets a bool value at a given key.
    ///
    /// - Parameters:
    ///   - value: The value we want to store.
    ///   - key: The key where we want to store the value.
    /// - Throws: Can throw errors, for example if data is invalid or if there was a transformation error.
    func set(_ value: Bool, key: String) throws
    
    /// Removes the value at a given key.
    ///
    /// - Parameter key: The key we want to remove the value.
    /// - Throws: Can throw errors if the operation was unsuccessful.
    func removeValue(forKey key: String) throws
    
    /// Removes all values from the storage.
    ///
    /// - Throws: Can throw errors if a value failed to be removed from the storage.
    func removeAll() throws
}
