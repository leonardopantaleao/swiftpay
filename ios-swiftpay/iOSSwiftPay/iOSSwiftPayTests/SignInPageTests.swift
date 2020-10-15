//
//  SignInPageTests.swift
//  iOSSwiftPayTests
//
//  Created by Leonardo on 15/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

@testable import iOSSwiftPay
import XCTest
import Mockingbird
import Firebase

class SignInPageTests: XCTestCase {
    var validationService: ValidationService!
    var client: ClientProtocol!
    var presenter: SignInPresenter!
    
    override func setUp() {
        super.setUp()
        validationService = ValidationService()
        client = mock(ClientProtocol.self)
        presenter = SignInPresenter(validationService: validationService, client: client)
    }
    
    override func tearDown() {
        validationService = nil
        client = nil
        super.tearDown()
    }
    
    func testLoginWithEmptyEmail(){
        let email = ""
        let password = ""
        
        XCTFail()
    }
    
    func testLoginWithInvalidEmail(){
        
        XCTFail()
    }
    
    func testLoginWithEmptyPassword(){
        XCTFail()
    }
    
    func testLoginWithInvalidPassword(){
        XCTFail()
    }
    
    func testLoginWithWrongPassword(){
        XCTFail()
    }
    
    func testLoginWithNonExistingEmail(){
        XCTFail()
    }
    
    func testLoginWithAllFilledCorrectly(){
        XCTFail()
    }
}
