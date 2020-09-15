//
//  ValidationServiceTests.swift
//  iOSSwiftPayTests
//
//  Created by Leonardo on 14/09/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

@testable import iOSSwiftPay
import XCTest


class ValidationServiceTests: XCTestCase {
    var validation: ValidationService!
    
    override func setUp() {
        super.setUp()
        validation = ValidationService()
    }

    override func tearDown() {
        validation = nil
        super.tearDown()
    }
    
    func test_is_valid_password() throws {
        XCTAssertNoThrow(try validation.validatePassword("testesenha01#"))
    }
    
    func test_password_is_nil() throws {
        let expectedError = ValidationError.invalidValue
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validatePassword(nil)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_password_too_short() throws {
        let expectedError = ValidationError.passwordTooShort
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validatePassword("leo")) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_password_too_long() throws {
        let expectedError = ValidationError.passwordTooLong
        var error: ValidationError?
        let password = "teste senha muito longa"
        
        XCTAssertTrue(password.count == 23)
        
        XCTAssertThrowsError(try validation.validatePassword(password)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
}
