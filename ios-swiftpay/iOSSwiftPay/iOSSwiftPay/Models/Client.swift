//
//  Client.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 17/08/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation


struct Client {
    internal init(name: String, lastName: String, email: String) {
        self.name = name
        self.lastName = lastName
        self.email = email
    }
    
    var name: String
    var lastName: String
    var email: String
}
