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
    var userLogin : UserLoginService!
    var validationService: ValidationService!
    var mockClient: MockClient!
    
    override func setUp() {
        super.setUp()
        userLogin = UserLoginService()
        validationService = ValidationService()
        mockClient = MockClient()
    }
    
    func test_login_successful() {
        let expectedUserEmail = "leo@email.com"
        let expectedPassword = "password01#"
        var signUpResult : String = ""
        var signUpError : ValidationError?
        let expectation = self.expectation(description: "test_login_successful")
        mockClient.signIn(expectedUserEmail, expectedPassword, completionHandler: { result in
            switch result {
            case .success(let email):
                signUpResult = email
            case .failure(let error):
                signUpError = error
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(expectedUserEmail, signUpResult)
        XCTAssertNil(signUpError)
    }
    
    func test_login_no_user_found() {
        let noUserEmail = "leo@email.com.br"
        let expectedPassword = "password01#"
        let expectedError = ValidationError.noUserFound
        var signUpResult : String = ""
        var signUpError : ValidationError?
        weak var expectation = self.expectation(description: "test_login_no_user_found")
        mockClient.signIn(noUserEmail, expectedPassword, completionHandler: { result in
            switch result {
            case .success(let email):
                signUpResult = email
            case .failure(let error):
                signUpError = error
            }
            expectation?.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(expectedError, signUpError)
        XCTAssertEqual(expectedError.errorDescription, signUpError?.errorDescription)
        XCTAssertEqual("", signUpResult)
    }
    
    func test_login_wrong_password() {
        let noUserEmail = "leo@email.com"
        let expectedPassword = "password01!!"
        let expectedError = ValidationError.wrongPassword
        var signUpResult : String = ""
        var signUpError : ValidationError?
        let expectation = self.expectation(description: "test_login_wrong_password")
        mockClient.signIn(noUserEmail, expectedPassword, completionHandler: { result in
            switch result {
            case .success(let email):
                signUpResult = email
            case .failure(let error):
                signUpError = error
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(expectedError, signUpError)
        XCTAssertEqual(expectedError.errorDescription, signUpError?.errorDescription)
        XCTAssertEqual("", signUpResult)
    }
    
    override func tearDown() {
        userLogin = nil
        validationService = nil
        mockClient = nil
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
        let expectedError = ValidationError.erongPassword
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
        let expectedError = ValidationError.noUserFound
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
    
    func testCreateUserFirebase()
    {
        let email = "usuario_teste@test.com"
        let password = "funciona01!!"
        XCTAssertNoThrow(try? validationService.validateEmail(email))
        XCTAssertNoThrow(try? validationService.validatePassword(password))
        let expectation = self.expectation(description: "Login")
        var userData: User?
        var resultError: Error?
        userLogin.createUserOnFirebase(email, password, completionHandler: { result in
            switch result {
            case .success(let user):
                userData = user
            case .failure(let error):
                resultError = error
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: 25, handler: nil)
        XCTAssertNotNil(userData)
        XCTAssertEqual(userData?.email, email)
        XCTAssertNil(resultError)
    }
    
    func testCreateUserDB()
    {
        let email = "usuario_teste@test.com"
        let uid = "Efdcb1nAxgN96BQxwAKIVWQpRMC2"
        let calendar = Calendar.current
        var components = DateComponents()
        components.day = 25
        components.month = 1
        components.year = 1996
        components.hour = 2
        components.minute = 15
        components.second = 10
        let date = Calendar.current.startOfDay(for: calendar.date(from: components)!)
        XCTAssertNoThrow(try? validationService.validateEmail(email))
        let expectation = self.expectation(description: "Login")
        var resultUid : String?
        var resultError: Error?
        userLogin.createUserOnDB("Teste", "Silva Sauro", date.timeIntervalSinceReferenceDate, email, uid, completionHandler: { result in
            switch result {
            case .success(let uid):
                resultUid = uid
            case .failure(let error):
                resultError = error
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: 25, handler: nil)
        XCTAssertEqual(resultUid, uid)
        XCTAssertNil(resultError)
    }
}
