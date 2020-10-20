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
    
    func testIsValidPassword() throws {
        XCTAssertNoThrow(try validation.validatePassword("testesenha01#"))
    }
    
    func testPasswordIsNil() throws {
        let expectedError = ValidationError.invalidValue
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validatePassword(nil)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func testPasswordTooShort() throws {
        let expectedError = ValidationError.passwordNotValid
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validatePassword("leo")) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func testPasswordTooLong() throws {
        let expectedError = ValidationError.passwordNotValid
        var error: ValidationError?
        let password = "teste senha muito longa"
        
        XCTAssertTrue(password.count == 23)
        
        XCTAssertThrowsError(try validation.validatePassword(password)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func testEmailIsNil() throws {
        let expectedError = ValidationError.invalidValue
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validateEmail(nil)) { throwError in
            error = throwError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func testIsValidEmail() throws {
        XCTAssertNoThrow(try validation.validateEmail("leonardopspl@gmail.com"))
        XCTAssertThrowsError(try validation.validateEmail("teste.com"))
        XCTAssertThrowsError(try validation.validateEmail(".@com"))
        XCTAssertThrowsError(try validation.validateEmail("leo@com.1"))
    }
    
    func testPasswordsNotMatching() throws {
        let expectedError = ValidationError.passwordsDontMatch
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.passwordsMatching("passwordMatch#", "passwordMatch1#")) { throwError in
            error = throwError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func testPasswordsMatch() throws {
        XCTAssertNoThrow(try validation.passwordsMatching("passwordMatch#", "passwordMatch#"))
        XCTAssertThrowsError(try validation.passwordsMatching("", "passwordMatch#"))
        XCTAssertThrowsError(try validation.passwordsMatching("passwordMatch#", ""))
    }
    
    func testNameisNil() throws {
        let expectedError = ValidationError.invalidValue
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validateName(nil)) { throwError in
            error = throwError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func testIsInvalidName() throws {
        XCTAssertNoThrow(try validation.validateName("Leonardo"))
        XCTAssertNoThrow(try validation.validateName("Leão"))
        XCTAssertNoThrow(try validation.validateName("Panta Leão"))
        XCTAssertNoThrow(try validation.validateName("Roberto Carlos"))
        XCTAssertNoThrow(try validation.validateName("Roberto Fulano Carlos"))
        XCTAssertThrowsError(try validation.validateName("Leonardo1"))
        XCTAssertThrowsError(try validation.validateName("Leonardo  "))
        XCTAssertThrowsError(try validation.validateName("Leonardo 123"))
    }
}
