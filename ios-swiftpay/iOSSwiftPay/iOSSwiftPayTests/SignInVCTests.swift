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
        let expectation = self.expectation(description: "Login")
        let expectedUserId = "xbgUvnvbb1P4CGdTaRS240S8IjU2"
        var userId : String = ""
        try? userLogin.signUp("panta@test.com", "funciona01#", validationService, completionHandler: { result in
            userId = result
            expectation.fulfill()
        })
        waitForExpectations(timeout: 25, handler: nil)
        XCTAssertEqual(expectedUserId, userId)
    }
    
    func testLoginCorrectEmailAndPassword()
    {
        
    }
    
    func testLoginWrongPassword()
    {
        
    }
    
}
