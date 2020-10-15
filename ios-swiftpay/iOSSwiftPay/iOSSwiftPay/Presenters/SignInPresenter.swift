//
//  SignInPresenter.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 01/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

protocol SignInViewDelagate {
    func showProgress()
    func hideProgress()
    func loginDidSucceed()
    func loginDidFailed(message: String)
}

class SignInPresenter{
    
    internal init(signInViewDelagate: SignInViewDelagate? = nil, validationService: ValidationService, client: ClientProtocol) {
        self.signInViewDelagate = signInViewDelagate
        self.validationService = validationService
        self.client = client
    }
    
    private var signInViewDelagate: SignInViewDelagate?
    var validationService: ValidationService
    var client: ClientProtocol
    
    func setViewDelegate(signInViewDelagate: SignInViewDelagate?){
        self.signInViewDelagate = signInViewDelagate
    }
    
    func SignIn(_ email: String?, _ password: String?){
        do
        {
            let validEmail = try validationService.validateEmail(email)
            let validPassword = try validationService.validatePassword(password)
        }
        catch {
            self.signInViewDelagate?.loginDidFailed(message: error.localizedDescription)
        }
        
    }
}
