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
        let userEmail = "email@email.com"
        let userName = "Leonardo"
        given(viewDelegate.showTryAgainMessageAndButton()).willReturn()
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.setUserName(userName)).willReturn()
        given(client.getUserInfo(userEmail, completionHandler: any())).will { email, callback in
            callback(.failure(ValidationError.noConnection))
        }
        presenter.getAndShowUserName()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
        verify(viewDelegate.showTryAgainMessageAndButton()).wasCalled()
        verify(viewDelegate.setUserName(userName)).wasNeverCalled()
    }
    
    func testFetchUserInfoSuccessfully(){
        let userEmail = "email@email.com"
        let userName = "Leonardo"
        given(viewDelegate.showTryAgainMessageAndButton()).willReturn()
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.setUserName(userName)).willReturn()
        given(client.getUserInfo(userEmail, completionHandler: any())).will { email, callback in
            callback(.success(any()))
        }
        presenter.getAndShowUserName()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
        verify(viewDelegate.showTryAgainMessageAndButton()).wasNeverCalled()
        verify(viewDelegate.setUserName(userName)).wasCalled()
    }
    
    func testFetchUserTransactionsFailed(){
        XCTFail()
    }
    
    func testFetchUserTransactionsSuccessfully(){
        XCTFail()
    }
}
