//
//  SignInPageTests.swift
//  iOSSwiftPayTests
//
//  Created by Leonardo on 15/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

@testable import SwiftPay
import XCTest
import Mockingbird
import Firebase

class SignInPageTests: XCTestCase {
    var validationService: ValidationService!
    var client: ClientProtocolMock!
    var presenter: SignInPresenter!
    var viewDelegate: SignInViewDelegateMock!
    var userDefaults: UserDefaultsProtocolMock!
    
    override func setUp() {
        validationService = ValidationService()
        userDefaults = mock(UserDefaultsProtocol.self)
        client = mock(ClientProtocol.self)
        viewDelegate = mock(SignInViewDelegate.self)
        presenter = SignInPresenter(signInViewDelagate: viewDelegate, validationService: validationService, client: client, userDefaults: userDefaults)
        super.setUp()
    }
    
    override func tearDown() {
        validationService = nil
        userDefaults = nil
        client = nil
        presenter = nil
        viewDelegate = nil
        super.tearDown()
    }
    
    func testLoginWithEmptyEmail(){
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.loginDidFailed(message: any())).willReturn()
        presenter.signIn(nil, nil)
        verify(viewDelegate.loginDidFailed(message: any())).wasCalled()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
    }
    
    func testLoginWithInvalidEmail(){
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.loginDidFailed(message: any())).willReturn()
        presenter.signIn("invalidEmail", nil)
        verify(viewDelegate.loginDidFailed(message: any())).wasCalled()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
    }
    
    func testLoginWithEmptyPassword(){
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.loginDidFailed(message: any())).willReturn()
        presenter.signIn("email@email.com", nil)
        verify(viewDelegate.loginDidFailed(message: any())).wasCalled()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
    }
    
    func testLoginWithInvalidPassword(){
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.loginDidFailed(message: any())).willReturn()
        presenter.signIn("email@email.com", "invalid")
        verify(viewDelegate.loginDidFailed(message: any())).wasCalled()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
    }
    
    func testLoginWithWrongPassword(){
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.loginDidFailed(message: any())).willReturn()
        given(client.signIn(any(), any(), completionHandler: any())).will { email, password, callback in
            callback(.failure(ValidationError.wrongPassword))
        }
        presenter.signIn("email@email.com", "funciona01!!")
        verify(viewDelegate.loginDidFailed(message: any())).wasCalled()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
    }
    
    func testLoginWithNonExistingEmail(){
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.loginDidFailed(message: any())).willReturn()
        given(client.signIn(any(), any(), completionHandler: any())).will { email, password, callback in
            callback(.failure(ValidationError.noUserFound))
        }
        presenter.signIn("no_email@email.com", "funciona01!!")
        verify(viewDelegate.loginDidFailed(message: any())).wasCalled()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
    }
    
    func testLoginNoConnection(){
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.loginDidFailed(message: any())).willReturn()
        given(client.signIn(any(), any(), completionHandler: any())).will { email, password, callback in
            callback(.failure(ValidationError.noConnection))
        }
        presenter.signIn("email@email.com", "funciona01!!")
        verify(viewDelegate.loginDidFailed(message: any())).wasCalled()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
    }
    
    func testLoginWithAllFilledCorrectly(){
        let enteredEmail = "email@email.com"
        given(userDefaults.saveStringOnUserDefaults(enteredEmail, Constants.UserDefaultsKeys.userEmail)).willReturn()
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.loginDidSucceed()).willReturn()
        given(client.signIn(any(), any(), completionHandler: any())).will { email, password, callback in
            callback(.success(enteredEmail))
        }
        presenter.signIn(enteredEmail, "funciona01#")
        verify(viewDelegate.loginDidSucceed()).wasCalled()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
        verify(userDefaults.saveStringOnUserDefaults(enteredEmail, Constants.UserDefaultsKeys.userEmail)).wasCalled()
    }
}
