//
//  ResponseHandlerTests.swift
//  iOSSwiftPayTests
//
//  Created by Leonardo on 15/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

@testable import SwiftPay
import XCTest
import Mockingbird
import Firebase

class ResponseHandlerTests: XCTestCase {
    var responseHandler: ResponseHandler!
    var client: ClientProtocol!
    
    override func setUp() {
        super.setUp()
        responseHandler = ResponseHandler()
        client = mock(ClientProtocol.self)
    }

    override func tearDown() {
        responseHandler = nil
        super.tearDown()
    }
    
    func test_user_not_found_error(){
        let errorCode = 17011
        let expectedError = ValidationError.noUserFound
        let error = responseHandler.handleError(errorCode)
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error.errorDescription)
    }
    
    func test_wrong_password_error(){
        let errorCode = 17009
        let expectedError = ValidationError.wrongPassword
        let error = responseHandler.handleError(errorCode)
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error.errorDescription)
    }
    
    func test_no_connection_error(){
        let errorCode = 17020
        let expectedError = ValidationError.noConnection
        let error = responseHandler.handleError(errorCode)
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error.errorDescription)
    }
    
    func test_unknown_error(){
        let errorCode = 00000
        let expectedError = ValidationError.unknownError
        let error = responseHandler.handleError(errorCode)
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error.errorDescription)
    }
}
