//
//  KeychainQueryFactoryTests.swift
//  KeychainStorageTests
//
//  Created by Dan, Radu-Ionut (RO - Bucharest) on 26/05/2019.
//  Copyright © 2019 radude89. All rights reserved.
//

import XCTest
@testable import KeychainStorage

final class KeychainQueryFactoryTests: XCTestCase {
    
    func test_makeQueryForService_setService() {
        let expectedService = "com.test"
        
        let queryDictionary = KeychainBasicQueryFactory.makeQuery(forService: expectedService)
        let service = queryDictionary[kSecAttrService as String] as! String
        
        XCTAssertEqual(service, expectedService)
        XCTAssertGreaterThan(queryDictionary.count, 2)
    }
    
    func test_makeQuery_setServiceAndKey() {
        let expectedService = "com.test"
        let expectedKey = "key.test"
        
        let queryDictionary = KeychainBasicQueryFactory.makeQuery(forService: expectedService, key: expectedKey)
        let service = queryDictionary[kSecAttrService as String] as! String
        let key = queryDictionary[kSecAttrAccount as String] as! String
        
        XCTAssertEqual(service, expectedService)
        XCTAssertEqual(key, expectedKey)
        XCTAssertGreaterThan(queryDictionary.count, 2)
    }
    
    func test_makeQuery_setServiceAndKeyValue() {
        let expectedService = "com.test"
        let expectedKey = "key.test"
        let expectedValue = "value.test".data(using: .utf8)!
        
        let queryDictionary = KeychainBasicQueryFactory.makeQuery(forService: expectedService, key: expectedKey, value: expectedValue)
        let service = queryDictionary[kSecAttrService as String] as! String
        let key = queryDictionary[kSecAttrAccount as String] as! String
        let value = queryDictionary[kSecValueData as String] as! Data
        
        XCTAssertEqual(service, expectedService)
        XCTAssertEqual(key, expectedKey)
        XCTAssertEqual(value, expectedValue)
        XCTAssertGreaterThan(queryDictionary.count, 3)
    }
    
    func test_makeDeleteQuery_withoutKey() {
        let expectedService = "com.test"
        
        let queryDictionary = KeychainBasicQueryFactory.makeDeleteQuery(forService: expectedService)
        let service = queryDictionary[kSecAttrService as String] as! String
        
        XCTAssertEqual(service, expectedService)
        XCTAssertGreaterThanOrEqual(queryDictionary.count, 2)
    }
    
    func test_makeDeleteQuery_withKey() {
        let expectedService = "com.test"
        let expectedKey = "key.test"
        
        let queryDictionary = KeychainBasicQueryFactory.makeDeleteQuery(forService: expectedService, key: expectedKey)
        let service = queryDictionary[kSecAttrService as String] as! String
        let key = queryDictionary[kSecAttrAccount as String] as! String
        
        XCTAssertEqual(service, expectedService)
        XCTAssertEqual(key, expectedKey)
        XCTAssertGreaterThanOrEqual(queryDictionary.count, 3)
    }

}
