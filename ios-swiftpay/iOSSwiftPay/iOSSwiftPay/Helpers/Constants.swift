//
//  Constants.swift
//  CustomLoginDemo
//
//  Created by Christopher Ching on 2019-07-23.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct Storyboard {
        
        static let homeViewController = "HomeVC"
        
    }
    
    struct ScreenInfo {
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
    }
    
    struct Assets {
        static let swiftPayLogo = "swiftPayLogo"
        static let moneyTransfer = "moneyTransfer"
        static let moneyDeposit = "moneyDeposit"
        static let user = "user"
        static let rowIconMoneyTransfer = "rowIconMoneyTransfer"
        static let rowIconMoneyDeposit = "rowIconMoneyDeposit"
        static let home = "home"
        static let settings = "settings"
    }
    
    struct LocalizedStrings {
        static let namePlaceholder = "namePlaceholder"
        static let lastNamePlaceholder = "lastNamePlaceholder"
        static let emailPlaceholder = "emailPlaceholder"
        static let passwordPlaceholder = "passwordPlaceholder"
        static let signInBtnText = "signInBtnText"
        static let createAccountBtnText = "createAccountBtnText"
        static let copyright = "copyright"
        static let invalidValue = "invalidValue"
        static let notValidPassword = "notValidPassword"
        static let notValidEmail = "notValidEmail"
        static let noUserFound = "firebaseNoUserFound"
        static let wrongPassword = "firebaseWrongPassword"
        static let noConnection = "firebaseNoConnection"
        static let logOff = "logOff"
        static let moneyTransfer = "moneyTransfer"
        static let moneyDeposit = "moneyDeposit"
        static let insertAmount = "insertAmount"
        static let balance = "balance"
        static let transactions = "transactions"
        static let show = "show"
        static let transfer = "transfer"
        static let deposit = "deposit"
        static let to = "to"
        static let home = "home"
        static let settings = "settings"
        static let toTransfer = "toTransfer"
        static let toDeposit = "toDeposit"
        static let unknownError = "unknownError"
        static let passwordsNotMatching = "passwordsNotMatching"
        static let notValidName = "notValidName"
        static let userAlreadyExists = "userAlreadyExists"
    }
}
