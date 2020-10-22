//
//  UserDefaultsService.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 21/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

struct UserDefaultsService: UserDefaultsProtocol{
    func saveStringOnUserDefaults(_ value: String, _ key: String){
        UserDefaults.standard.set(value, forKey: key)
    }

    func getStringOnUserDefaults(_ key: String) -> String {
        return UserDefaults.standard.value(forKey: key) as! String
    }
}

