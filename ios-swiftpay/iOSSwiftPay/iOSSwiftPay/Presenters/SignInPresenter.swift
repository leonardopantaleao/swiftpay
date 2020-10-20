//
//  SignInPresenter.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 01/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

protocol SignInViewDelegate {
    func showProgress()
    func hideProgress()
    func loginDidSucceed()
    func loginDidFailed(message: String)
    func navigateToSignUp()
}

class SignInPresenter{
    
    internal init(signInViewDelagate: SignInViewDelegate? = nil, validationService: ValidationService, client: ClientProtocol) {
        self.signInViewDelagate = signInViewDelagate
        self.validationService = validationService
        self.client = client
    }
    
    private var signInViewDelagate: SignInViewDelegate?
    var validationService: ValidationService
    var client: ClientProtocol
    
    func setViewDelegate(signInViewDelagate: SignInViewDelegate?){
        self.signInViewDelagate = signInViewDelagate
    }
    
    func signIn(_ email: String?, _ password: String?){
        self.signInViewDelagate?.showProgress()
        do
        {
            let validEmail = try validationService.validateEmail(email)
            let validPassword = try validationService.validatePassword(password)
            client.signIn(validEmail, validPassword, completionHandler: { result in
                switch result {
                case .success(_):
                    self.signInViewDelagate?.loginDidSucceed()
                case .failure(let error):
                    self.signInViewDelagate?.loginDidFailed(message: error.localizedDescription)
                }
                self.signInViewDelagate?.hideProgress()
            })
        }
        catch {
            self.signInViewDelagate?.loginDidFailed(message: error.localizedDescription)
            self.signInViewDelagate?.hideProgress()
        }
        
    }
    
    func navigateToSignUp(){
        self.signInViewDelagate?.navigateToSignUp();
    }
}
