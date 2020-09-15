//
//  ValidationService.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 14/09/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

struct ValidationService {
    func validateUsername(_ username: String?) throws -> String {
        guard let username = username else { throw ValidationError.invalidValue }
        guard username.count > 3 else { throw ValidationError.usernameTooShort }
        guard username.count < 20 else { throw ValidationError.usernameTooLong }
        return username
    }
    
    func validatePassword(_ password: String?) throws -> String {
        guard let password = password else { throw ValidationError.invalidValue }
        guard password.count >= 8 else { throw ValidationError.passwordTooShort }
        guard password.count < 20 else { throw ValidationError.passwordTooLong }
        guard isPasswordValid(password) else { throw ValidationError.passwordNotValid }
        return password
    }
}

func isPasswordValid(_ password : String) -> Bool {
    
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,20}")
    return passwordTest.evaluate(with: password)
}

enum ValidationError: LocalizedError {
    case invalidValue
    case passwordTooLong
    case passwordTooShort
    case usernameTooLong
    case usernameTooShort
    case passwordNotValid
    
    var errorDescription: String? {
        switch self {
        case .invalidValue:
            return NSLocalizedString("invalidValue", comment: "error message")
        case .passwordTooLong:
            return NSLocalizedString("passwordTooLong", comment: "error message")
        case .passwordTooShort:
            return NSLocalizedString("passwordTooShort", comment: "error message")
        case .usernameTooLong:
            return NSLocalizedString("usernameTooLong", comment: "error message")
        case .usernameTooShort:
            return NSLocalizedString("usernameTooShort", comment: "error message")
        case .passwordNotValid:
            return NSLocalizedString("notValidPassword", comment: "error message")
        }
    }
}
