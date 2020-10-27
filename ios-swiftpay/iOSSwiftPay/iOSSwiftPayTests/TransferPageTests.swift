//
//  TransferPageTests.swift
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

class TransferPageTests: XCTestCase {
    var client: ClientProtocolMock!
    var presenter: TransferPresenter!
    var viewDelegate: TransferViewDelegateMock!
    var userDefaults: UserDefaultsProtocolMock!
    var validationService: ValidationService!
    
    override func setUp() {
        validationService = ValidationService()
        userDefaults = mock(UserDefaultsProtocol.self)
        client = mock(ClientProtocol.self)
        viewDelegate = mock(TransferViewDelegate.self)
        presenter = TransferPresenter(viewDelegate: viewDelegate, userDefaults: userDefaults, client: client, validationService: validationService)
        super.setUp()
    }
    
    func testEmptyValueInserted(){
        let userEmail = "email@email.com"
        let receiverEmail = "receiver@email.com"
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).willReturn(userEmail)
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.showMessage(any(), any())).willReturn()
        presenter.performTransferTransaction(nil, receiverEmail)
        verify(viewDelegate.showProgress()).wasNeverCalled()
        verify(viewDelegate.hideProgress()).wasNeverCalled()
        verify(viewDelegate.showMessage(any(), any())).wasCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).wasCalled()
    }
    
    func testInvalidValueInserted(){
        let userEmail = "email@email.com"
        let receiverEmail = "receiver@email.com"
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).willReturn(userEmail)
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.showMessage(any(), any())).willReturn()
        presenter.performTransferTransaction("123.456", receiverEmail)
        verify(viewDelegate.showProgress()).wasNeverCalled()
        verify(viewDelegate.hideProgress()).wasNeverCalled()
        verify(viewDelegate.showMessage(any(), any())).wasCalled()
        verify(userDefaults.getStringOnUserDefaults(any())).wasCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).wasCalled()
    }
    
    func testTransferTransactionDidFail(){
        let userEmail = "email@email.com"
        let receiverEmail = "receiver@email.com"
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).willReturn(userEmail)
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.showMessage(any(), .red)).willReturn()
        given(client.performTransaction(userEmail, receiverEmail, any(), any(), any(), completionHandler: any())).will { (senderEmail, receiverEmail, amount, type, timeInterval, callback) in
            callback(.failure(ValidationError.noConnection))
        }
        presenter.performTransferTransaction(receiverEmail, "123,25")
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
        verify(viewDelegate.showMessage(any(), .red)).wasCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).wasCalled()
    }
    
    func testTransferTransactionDidSucceed(){
        let userEmail = "email@email.com"
        let receiverEmail = "receiver@email.com"
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).willReturn(userEmail)
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.showMessage(any(), .green)).willReturn()
        given(client.performTransaction(userEmail, receiverEmail, any(), any(), any(), completionHandler: any())).will { (senderEmail, receiverEmail, amount, type, timeInterval, callback) in
            callback(.success(userEmail))
        }
        presenter.performTransferTransaction(receiverEmail, "123,25")
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
        verify(viewDelegate.showMessage(any(), .green)).wasCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).wasCalled()
    }
}
