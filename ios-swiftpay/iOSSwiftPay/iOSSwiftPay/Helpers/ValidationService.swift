//
//  ValidationService.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 14/09/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

struct ValidationService {
    
    func validatePassword(_ password: String?) throws -> String {
        guard let password = password else { throw ValidationError.invalidValue }
        guard isPasswordValid(password) else { throw ValidationError.passwordNotValid }
        return password
    }
    
    func validateEmail(_ email: String?) throws -> String {
        guard let email = email else { throw ValidationError.invalidValue }
        guard isEmailValid(email) else { throw ValidationError.emailNotValid }
        return email
    }
}

func isPasswordValid(_ password : String) -> Bool {
    
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,20}")
    return passwordTest.evaluate(with: password)
}

func isEmailValid(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

enum ValidationError: LocalizedError {
    case invalidValue
    case passwordNotValid
    case emailNotValid
    case firebaseNoUserFound
    case firebaseWrongPassword
    case firebaseNoConnection
    
    var errorDescription: String? {
        switch self {
        case .invalidValue:
            return NSLocalizedString("invalidValue", comment: "error message")
        case .passwordNotValid:
            return NSLocalizedString("notValidPassword", comment: "error message")
        case .emailNotValid:
            return NSLocalizedString("notValidEmail", comment: "error message")
        case .firebaseNoUserFound:
            return NSLocalizedString("firebaseNoUserFound", comment: "error message")
        case .firebaseWrongPassword:
            return NSLocalizedString("firebaseWrongPassword", comment: "error message")
        case .firebaseNoConnection:
            return NSLocalizedString("firebaseNoConnection", comment: "error message")
        }
    }
}
