//
//  KeychainStorageTests.swift
//  KeychainStorageTests
//
//  Created by Dan, Radu-Ionut (RO - Bucharest) on 26/05/2019.
//  Copyright © 2019 radude89. All rights reserved.
//

import XCTest
@testable import KeychainStorage

final class KeychainStorageTests: XCTestCase {
    
    var sut: KeychainStorage!
    private let service = "com.test.service"
    private let key = "test.key"
    
    override func setUp() {
        super.setUp()
        sut = KeychainStorage(service: service)
    }
    
    override func tearDown() {
        try? sut.removeAll()
        super.tearDown()
    }
    
    func test_keychainWrapper_init() {
        XCTAssertNotNil(sut)
    }
    
    func test_keychainWrapper_stringForKey() {
        let expectedValue = "test.value"
        
        do {
            try sut.set(expectedValue, key: key)
            let actualValue = try sut.string(forKey: key)
            XCTAssertEqual(actualValue, expectedValue)
        } catch {
            XCTFail("Thrown error \(error)")
        }
    }
    
    func test_keychainWrapper_stringForKey_isNil() {
        XCTAssertNil(try sut.string(forKey: key))
    }
    
    func test_keychainWrapper_boolForKey() {
        do {
            let expectedValue = true
            try sut.set(expectedValue, key: key)
            
            let actualValue = try sut.bool(forKey: key)
            
            XCTAssertEqual(actualValue, expectedValue)
        } catch {
            XCTFail("Thrown error \(error)")
        }
    }
    
    func test_keychainWrapper_boolForKey_isNil() {
        XCTAssertNil(try sut.bool(forKey: key))
    }
    
    func test_keychainWrapper_removesStringValue() {
        do {
            let expectedValue = "test.value"
            try sut.set(expectedValue, key: key)
            
            try sut.removeValue(forKey: key)
            
            XCTAssertNil(try sut.string(forKey: key))
        } catch {
            XCTFail("Thrown error \(error)")
        }
    }
    
    func test_keychainWrapper_removesBoolValue() {
        do {
            let expectedValue = false
            try sut.set(expectedValue, key: key)
            
            try sut.removeValue(forKey: key)
            
            XCTAssertNil(try sut.bool(forKey: key))
        } catch {
            XCTFail("Thrown error \(error)")
        }
    }
    
    func test_keychainWrapper_overWritesStringValue() {
        do {
            let initialValue = "initial.test.value"
            try sut.set(initialValue, key: key)
            
            let expectedValue = "test.value"
            try sut.set(expectedValue, key: key)
        }  catch {
            XCTFail("Thrown error \(error)")
        }
    }
    
    func test_keychainWrapper_overwritesBoolValue() {
        do {
            let initialValue = false
            try sut.set(initialValue, key: key)
            
            let expectedValue = true
            try sut.set(expectedValue, key: key)
            
            let actualValue = try sut.bool(forKey: key)
            
            XCTAssertEqual(actualValue, expectedValue)
        }  catch {
            XCTFail("Thrown error \(error)")
        }
    }
    
    func test_keychainWrapper_removesValuesByService() {
        do {
            let expectedValue = "test.value"
            let keychainWrapper = KeychainStorage(service: "\(service).two")
            
            try sut.set(expectedValue, key: key)
            try keychainWrapper.set(expectedValue, key: key)
            try sut.removeAll()
            let actualValue = try keychainWrapper.string(forKey: key)
            
            XCTAssertNil(try sut.string(forKey: key))
            XCTAssertEqual(actualValue, expectedValue)
            
            try keychainWrapper.removeAll()
        }  catch {
            XCTFail("Thrown error \(error)")
        }
    }

}
