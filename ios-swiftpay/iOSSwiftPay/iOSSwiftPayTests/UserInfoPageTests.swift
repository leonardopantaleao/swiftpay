//
//  UserInfoPageTests.swift
//  iOSSwiftPayTests
//
//  Created by Leonardo on 21/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

@testable import iOSSwiftPay
import XCTest
import Mockingbird
import Firebase

class UserInfoPageTests: XCTestCase {
    var client: ClientProtocolMock!
    var presenter: UserInfoPresenter!
    var viewDelegate: UserInfoDelegateMock!
    var userDefaults: UserDefaultsProtocolMock!
    
    override func setUp() {
        userDefaults = mock(UserDefaultsProtocol.self)
        client = mock(ClientProtocol.self)
        viewDelegate = mock(UserInfoDelegate.self)
        presenter = UserInfoPresenter(userInfoDelegate: viewDelegate, client: client, userDefaults: userDefaults)
        super.setUp()
    }
    
    func testFetchUserInfoFailed(){
        
        XCTFail()
    }
    
    func testFetchUserInfoSuccessfully(){
        
        XCTFail()
    }
    
    func testFetchUserTransactionsFailed(){
        XCTFail()
    }
    
    func testFetchUserTransactionsSuccessfully(){
        XCTFail()
    }
}
