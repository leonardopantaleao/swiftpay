//
//  SignUpPageTests.swift
//  iOSSwiftPayTests
//
//  Created by Leonardo on 19/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//
@testable import iOSSwiftPay
import XCTest
import Mockingbird
import Firebase

class SignUpPageTests: XCTestCase {
    var validationService: ValidationService!
    var client: ClientProtocolMock!
    var presenter: SignUpPresenter!
    var viewDelegate: SignUpViewDelegateMock!
    
    override func setUp() {
        validationService = ValidationService()
        client = mock(ClientProtocol.self)
        viewDelegate = mock(SignUpViewDelegate.self)
        presenter = SignUpPresenter(signUpViewDelegate: viewDelegate, validationService: validationService, client: client)
        super.setUp()
    }
    
    override func tearDown() {
        validationService = nil
        client = nil
        super.tearDown()
    }
    
    func testSignUpWithEmptyEmail(){
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.signUpDidFailed(message: any())).willReturn()
        presenter.signUp("Nome", "Sobrenome", nil, "testesenha1#", "testesenha1#")
        verify(viewDelegate.signUpDidFailed(message: any())).wasCalled()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
    }
    
    func testSignUpWithEmptyPassword(){
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.signUpDidFailed(message: any())).willReturn()
        presenter.signUp("Nome", "Sobrenome", "email@email.com", nil, nil)
        verify(viewDelegate.signUpDidFailed(message: any())).wasCalled()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
    }
    
    func testSignUpWithEmptyName(){
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.signUpDidFailed(message: any())).willReturn()
        presenter.signUp(nil, "Sobrenome", "email@email.com", "testesenha1#", "testesenha1#")
        verify(viewDelegate.signUpDidFailed(message: any())).wasCalled()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
    }
    
    func testSignUpWithEmptyLastName(){
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.signUpDidFailed(message: any())).willReturn()
        presenter.signUp("Nome", nil, "email@email.com", "testesenha1#", "testesenha1#")
        verify(viewDelegate.signUpDidFailed(message: any())).wasCalled()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
    }
    
    func testSignUpWithInvalidEmail(){
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.signUpDidFailed(message: any())).willReturn()
        presenter.signUp("Nome", "Sobrenome", "invalidemail.com", "testesenha1#", "testesenha1#")
        verify(viewDelegate.signUpDidFailed(message: any())).wasCalled()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
    }
    
    func testSignUpWithInvalidPassword(){
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.signUpDidFailed(message: any())).willReturn()
        presenter.signUp("Nome", "Sobrenome", "email@email.com", "teste", nil)
        verify(viewDelegate.signUpDidFailed(message: any())).wasCalled()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
    }
    
    func testSignUpWithInvalidName(){
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.signUpDidFailed(message: any())).willReturn()
        presenter.signUp("Nome1", "Sobrenome", "email@email.com", "testesenha1#", "testesenha1#")
        verify(viewDelegate.signUpDidFailed(message: any())).wasCalled()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
    }
    
    func testSignUpWithInvalidLastName(){
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.signUpDidFailed(message: any())).willReturn()
        presenter.signUp("Nome", "$obrenome", "email@email.com", "testesenha1#", "testesenha1#")
        verify(viewDelegate.signUpDidFailed(message: any())).wasCalled()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
    }
    
    func testSignUpWithNotMatchingPasswords(){
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.signUpDidFailed(message: any())).willReturn()
        presenter.signUp("Nome", "Sobrenome", "email@email.com", "testesenha1#", "testesenha2#")
        verify(viewDelegate.signUpDidFailed(message: any())).wasCalled()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
    }
    
    func testSignUpWithAlreadyExistingEmail(){
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.signUpDidFailed(message: any())).willReturn()
        given(client.signUp(any(), any(), any(), any(), completionHandler: any())).will { name, lastName, email, password, callback in
            callback(.failure(ValidationError.userAlreadyExists))
        }
        presenter.signUp("Nome", "Sobrenome", "existing_email@email.com", "testesenha1#", "testesenha1#")
        verify(viewDelegate.signUpDidFailed(message: any())).wasCalled()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
    }
    
    func testSignUpNoConnection(){
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.signUpDidFailed(message: any())).willReturn()
        given(client.signUp(any(), any(), any(), any(), completionHandler: any())).will { name, lastName, email, password, callback in
            callback(.failure(ValidationError.noConnection))
        }
        presenter.signUp("Nome", "$obrenome", "existing_email@email.com", "testesenha1#", "testesenha1#")
        verify(viewDelegate.signUpDidFailed(message: any())).wasCalled()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
    }
    
    func testSignUpWithAllValidFields(){
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.signUpDidSucceed()).willReturn()
        given(client.signUp(any(), any(), any(), any(), completionHandler: any())).will { name, lastName, email, password, callback in
            callback(.success("email@email.com"))
        }
        presenter.signUp("Nome", "Sobrenome", "email@email.com", "testesenha1#", "testesenha1#")
        verify(viewDelegate.signUpDidSucceed()).wasCalled()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
    }
}
