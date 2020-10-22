//
//  SignUpPresenter.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 19/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

protocol SignUpViewDelegate {
    func showProgress()
    func hideProgress()
    func signUpDidSucceed()
    func signUpDidFailed(message: String)
}

class SignUpPresenter {
    private var signUpViewDelegate: SignUpViewDelegate?
    var validationService: ValidationService
    var userDefaults: UserDefaultsProtocol
    var client: ClientProtocol
    
    internal init(signUpViewDelegate: SignUpViewDelegate? = nil, validationService: ValidationService, client: ClientProtocol, userDefaults: UserDefaultsProtocol) {
        self.signUpViewDelegate = signUpViewDelegate
        self.validationService = validationService
        self.userDefaults = userDefaults
        self.client = client
    }
    
    func setViewDelegate(signUpViewDelagate: SignUpViewDelegate?){
        self.signUpViewDelegate = signUpViewDelagate
    }
    
    func signUp(_ name: String?, _ lastName: String?, _ email: String?, _ passwordA: String?, _ passwordB: String?){
        self.signUpViewDelegate?.showProgress()
        do
        {
            let validName = try validationService.validateName(name)
            let validLastName = try validationService.validateName(lastName)
            let validEmail = try validationService.validateEmail(email)
            let validPassword = try validationService.validatePassword(passwordA)
            _ = try validationService.passwordsMatching(passwordA!, passwordB!)
            
            client.signUp(validName, validLastName, validEmail, validPassword, completionHandler:  { result in
                switch result {
                case .success(let email):
                    self.createUserOnDB(validName, validLastName, email)
                case .failure(let error):
                    self.signUpViewDelegate?.signUpDidFailed(message: error.localizedDescription)
                }
                self.signUpViewDelegate?.hideProgress()
            })
        }
        catch {
            self.signUpViewDelegate?.signUpDidFailed(message: error.localizedDescription)
            self.signUpViewDelegate?.hideProgress()
        }
    }
    
    func createUserOnDB(_ name: String, _ lastName: String, _ email: String){
        client.createUserOnDB(name, lastName, email, completionHandler: { result in
            switch result {
            case .success(let email):
                self.signUpViewDelegate?.signUpDidSucceed()
                self.userDefaults.saveStringOnUserDefaults(email, Constants.UserDefaultsKeys.userEmail)
            case .failure(let error):
                self.signUpViewDelegate?.signUpDidFailed(message: error.localizedDescription)
            }
        })
    }
}
