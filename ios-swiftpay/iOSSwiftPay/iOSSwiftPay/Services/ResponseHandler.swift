//
//  ResponseHandler.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 15/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

struct ResponseHandler{
    func handleError(_ errorCode : Int) -> ValidationError{
        if errorCode == 17011 { return ValidationError.noUserFound  }
        if errorCode == 17009 { return ValidationError.wrongPassword }
        if errorCode == 17020 { return ValidationError.noConnection }
        return ValidationError.unknownError
    }
}
