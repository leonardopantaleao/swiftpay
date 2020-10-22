//
//  DatabaseError.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 22/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

enum DatabaseError: LocalizedError {
    case noConnection
    
    var errorDescription: String? {
        switch self {
        case .noConnection:
            return NSLocalizedString(Constants.LocalizedStrings.noConnection, comment: "error message")
        }
    }
}
