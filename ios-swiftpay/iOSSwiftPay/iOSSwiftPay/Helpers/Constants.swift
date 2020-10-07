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
        static let firebaseNoUserFound = "firebaseNoUserFound"
        static let firebaseWrongPassword = "firebaseWrongPassword"
        static let firebaseNoConnection = "firebaseNoConnection"
        static let logOff = "logOff"
        static let moneyTransfer = "moneyTransfer"
        static let moneyDeposit = "moneyDeposit"
        static let insertAmount = "insertAmount"
    }
}
