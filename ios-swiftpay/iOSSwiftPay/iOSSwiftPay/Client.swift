//
//  Client.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 17/08/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation


struct Client: Codable{
    var name: String
    var lastName: String
    var dateOfBirth: Date
    var email: String
    var uid: String
}
