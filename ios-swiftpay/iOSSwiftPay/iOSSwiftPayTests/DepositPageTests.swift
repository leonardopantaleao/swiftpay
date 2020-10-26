//
//  DepositPageTests.swift
//  iOSSwiftPayTests
//
//  Created by Leonardo on 26/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

@testable import iOSSwiftPay
import XCTest
import Mockingbird
import Firebase
import UIKit

class DepositPageTests: XCTestCase {
    var client: ClientProtocolMock!
    var presenter: DepositPresenter!
    var viewDelegate: DepositViewDelegateMock!
    var userDefaults: UserDefaultsProtocolMock!
    var validationService: ValidationService!
    
    override func setUp() {
        validationService = ValidationService()
        userDefaults = mock(UserDefaultsProtocol.self)
        client = mock(ClientProtocol.self)
        viewDelegate = mock(DepositViewDelegate.self)
        presenter = DepositPresenter(viewDelegate: viewDelegate, userDefaults: userDefaults, client: client, validationService: validationService)
        super.setUp()
    }
    
    func testEmptyValueInserted(){
        let userEmail = "email@email.com"
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).willReturn(userEmail)
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.showMessage(any(), any())).willReturn()
        presenter.performDepositTransaction(nil)
        verify(viewDelegate.showProgress()).wasNeverCalled()
        verify(viewDelegate.hideProgress()).wasNeverCalled()
        verify(viewDelegate.showMessage(any(), any())).wasCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).wasCalled()
    }
    
    func testInvalidValueInserted(){
        let userEmail = "email@email.com"
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).willReturn(userEmail)
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.showMessage(any(), any())).willReturn()
        presenter.performDepositTransaction("123.456")
        verify(viewDelegate.showProgress()).wasNeverCalled()
        verify(viewDelegate.hideProgress()).wasNeverCalled()
        verify(viewDelegate.showMessage(any(), any())).wasCalled()
        verify(userDefaults.getStringOnUserDefaults(any())).wasCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).wasCalled()
    }
    
    func testDepositTransactionDidFail(){
        let userEmail = "email@email.com"
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).willReturn(userEmail)
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.showMessage(Constants.LocalizedStrings.transactionFail, .red)).willReturn()
        given(client.performTransaction(any(), any(), any(), any(), any(), completionHandler: any())).will { (senderEmail, receiverEmail, amount, type, timeInterval, callback) in
            callback(.failure(ValidationError.noConnection))
        }
        presenter.performDepositTransaction("123.45")
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
        verify(viewDelegate.showMessage(Constants.LocalizedStrings.transactionFail, .red)).wasCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).wasCalled()
    }
    
    func testDepositTransactionDidSucceed(){
        let userEmail = "email@email.com"
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).willReturn(userEmail)
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.showMessage(Constants.LocalizedStrings.transactionSuccess, .green)).willReturn()
        given(client.performTransaction(userEmail, any(), any(), any(), any(), completionHandler: any())).will { (senderEmail, receiverEmail, amount, type, timeInterval, callback) in
            callback(.success(userEmail))
        }
        presenter.performDepositTransaction("123.45")
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
        verify(viewDelegate.showMessage(Constants.LocalizedStrings.transactionSuccess, .green)).wasCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).wasCalled()
    }
}
