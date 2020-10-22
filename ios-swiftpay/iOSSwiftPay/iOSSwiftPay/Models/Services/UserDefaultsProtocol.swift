//
//  UserDefaultsProtocol.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 21/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

protocol UserDefaultsProtocol {
    func saveStringOnUserDefaults(_ value: String, _ key: String)
    func getStringOnUserDefaults(_ key: String) -> String
}
