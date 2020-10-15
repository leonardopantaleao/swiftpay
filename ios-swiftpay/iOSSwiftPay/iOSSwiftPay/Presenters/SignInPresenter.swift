//
//  SignInPresenter.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 01/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

protocol SignInViewDelagate: NSObjectProtocol {
    func showProgress()
    func hideProgress()
    func loginDidSucceed()
    func loginDidFailed(message: String)
}

class SignInPresenter{
    weak private var signInViewDelagate: SignInViewDelagate?
    let validation = ValidationService()
    
    func setViewDelegate(signInViewDelagate: SignInViewDelagate?){
        self.signInViewDelagate = signInViewDelagate
    }
    
    func SignIn(_ email: String?, _ password: String?){
        do
        {
            let validEmail = try validation.validateEmail(email)
            let validPassword = try validation.validatePassword(password)
        }
        catch {
            self.signInViewDelagate?.loginDidFailed(message: error.localizedDescription)
        }
        
    }
}
