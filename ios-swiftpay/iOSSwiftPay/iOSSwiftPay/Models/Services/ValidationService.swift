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
    
    func validateName(_ name: String?) throws -> String {
        guard let name = name else { throw ValidationError.invalidValue }
        guard isNameValid(name) else { throw ValidationError.nameNotValid}
        return name
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
    
    func passwordsMatching(_ passwordA: String, _ passwordB: String) throws -> Bool {
        guard passwordA == passwordB else { throw ValidationError.passwordsDontMatch}
        return true
    }
    
    func isNameValid(_ name: String) -> Bool {
        let nameRedEx = "([A-Z]{1}[a-záàâãéèêíïóôõöúçñ]{2,}[ ]?)+"
        let namePred = NSPredicate(format: "SELF MATCHES %@", nameRedEx)
        return namePred.evaluate(with: name)
    }
}

enum ValidationError: LocalizedError {
    case invalidValue
    case passwordNotValid
    case emailNotValid
    case noUserFound
    case wrongPassword
    case noConnection
    case unknownError
    case passwordsDontMatch
    case nameNotValid
    case userAlreadyExists
    
    var errorDescription: String? {
        switch self {
        case .invalidValue:
            return NSLocalizedString(Constants.LocalizedStrings.invalidValue, comment: "error message")
        case .passwordNotValid:
            return NSLocalizedString(Constants.LocalizedStrings.notValidPassword, comment: "error message")
        case .emailNotValid:
            return NSLocalizedString(Constants.LocalizedStrings.notValidEmail, comment: "error message")
        case .noUserFound:
            return NSLocalizedString(Constants.LocalizedStrings.noUserFound, comment: "error message")
        case .wrongPassword:
            return NSLocalizedString(Constants.LocalizedStrings.wrongPassword, comment: "error message")
        case .noConnection:
            return NSLocalizedString(Constants.LocalizedStrings.noConnection, comment: "error message")
        case .unknownError:
            return NSLocalizedString(Constants.LocalizedStrings.unknownError, comment: "error message")
        case .passwordsDontMatch:
            return NSLocalizedString(Constants.LocalizedStrings.passwordsNotMatching, comment: "error message")
        case .nameNotValid:
            return NSLocalizedString(Constants.LocalizedStrings.notValidName, comment: "error message")
        case .userAlreadyExists:
            return NSLocalizedString(Constants.LocalizedStrings.userAlreadyExists, comment: "error message")
        }
    }
}
