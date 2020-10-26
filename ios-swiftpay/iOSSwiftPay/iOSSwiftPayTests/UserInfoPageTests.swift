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
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).willReturn(userEmail)
        given(viewDelegate.showTryAgainMessageAndButton()).willReturn()
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.setUserName(any())).willReturn()
        given(client.getUserInfo(userEmail, completionHandler: any())).will { email, callback in
            callback(.failure(ValidationError.noConnection))
        }
        presenter.getAndShowUserName()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
        verify(viewDelegate.showTryAgainMessageAndButton()).wasCalled()
        verify(viewDelegate.setUserName(any())).wasNeverCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).wasCalled()
    }
    
    func testFetchUserInfoSuccessfully(){
        let userEmail = "email@email.com"
        let userName = "Name"
        let userLastName = "Last Name"
        given(client.saveResultOnUserDefaults(userName, Constants.UserDefaultsKeys.userName)).willReturn()
        given(client.saveResultOnUserDefaults(userLastName, Constants.UserDefaultsKeys.userLastName)).willReturn()
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).willReturn(userEmail)
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userName)).willReturn(userName)
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userLastName)).willReturn(userLastName)
        given(viewDelegate.showTryAgainMessageAndButton()).willReturn()
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.setUserName(any())).willReturn()
        given(client.getUserInfo(userEmail, completionHandler: any())).will { email, callback in
            callback(.success(userEmail))
        }
        presenter.getAndShowUserName()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
        verify(viewDelegate.showTryAgainMessageAndButton()).wasNeverCalled()
        verify(viewDelegate.setUserName(any())).wasCalled()
        verify(client.saveResultOnUserDefaults(userName, Constants.UserDefaultsKeys.userName)).wasNeverCalled()
        verify(client.saveResultOnUserDefaults(userLastName, Constants.UserDefaultsKeys.userLastName)).wasNeverCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).wasCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userName)).wasCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userLastName)).wasCalled()
    }
    
    func testFetchCurrentBalanceFailed(){
        let email = "panta@test.com"
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).willReturn(email)
        presenter.getAndShowCurrentBalance()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
    }
    
    func testFetchCurrentBalanceSuccess(){
        
    }
    
    func testFetchUserTransactionsFailed(){
        XCTFail()
    }
    
    func testFetchUserTransactionsSuccessfully(){
        XCTFail()
    }
}
