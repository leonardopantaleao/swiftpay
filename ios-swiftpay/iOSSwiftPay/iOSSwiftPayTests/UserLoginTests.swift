//
//  SignInVCTests.swift
//  iOSSwiftPayTests
//
//  Created by Leonardo on 17/09/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

@testable import iOSSwiftPay
import Firebase
import XCTest

class SignInVCTests: XCTestCase {
    var userLogin : UserLogin!
    var validationService: ValidationService!
    
    override func setUp() {
        super.setUp()
        userLogin = UserLogin()
        validationService = ValidationService()
    }
    
    override func tearDown() {
        userLogin = nil
        validationService = nil
        super.tearDown()
    }
    
    func testLoginSuccessfully()
    {
        let email = "panta@test.com"
        let password = "funciona01#"
        XCTAssertNoThrow(try? validationService.validateEmail(email))
        XCTAssertNoThrow(try? validationService.validatePassword(password))
        let expectation = self.expectation(description: "Login")
        let expectedUserId = "xbgUvnvbb1P4CGdTaRS240S8IjU2"
        var signUpResult : String = ""
        userLogin.signUp(email, password, completionHandler: { result in
            switch result {
            case .success(let uid):
                signUpResult = uid
            case .failure(let error):
                signUpResult = error.localizedDescription
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: 25, handler: nil)
        XCTAssertEqual(expectedUserId, signUpResult)
    }
    
    func testLoginWrongPassword()
    {
        let email = "panta@test.com"
        let password = "funciona01!!"
        XCTAssertNoThrow(try? validationService.validateEmail(email))
        XCTAssertNoThrow(try? validationService.validatePassword(password))
        let expectedError = ValidationError.firebaseWrongPassword
        let expectation = self.expectation(description: "Login")
        var signUpResult : String = ""
        var signUpError : ValidationError?
        userLogin.signUp(email, password, completionHandler: { result in
            switch result {
            case .success(let uid):
                signUpResult = uid
            case .failure(let error):
                signUpError = error
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: 25, handler: nil)
        XCTAssertEqual(expectedError, signUpError)
        XCTAssertEqual(expectedError.errorDescription, signUpError?.errorDescription)
        XCTAssertEqual("", signUpResult)
    }
    
    func testLoginNoUserFound()
    {
        let email = "nouser@test.com"
        let password = "funciona01!!"
        XCTAssertNoThrow(try? validationService.validateEmail(email))
        XCTAssertNoThrow(try? validationService.validatePassword(password))
        let expectedError = ValidationError.firebaseNoUserFound
        let expectation = self.expectation(description: "Login")
        var signUpResult : String = ""
        var signUpError : ValidationError?
        userLogin.signUp(email, password, completionHandler: { result in
            switch result {
            case .success(let uid):
                signUpResult = uid
            case .failure(let error):
                signUpError = error
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: 25, handler: nil)
        XCTAssertEqual(expectedError, signUpError)
        XCTAssertEqual(expectedError.errorDescription, signUpError?.errorDescription)
        XCTAssertEqual("", signUpResult)
    }
    
}
