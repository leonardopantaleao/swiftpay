//
//  SettingsPresenter.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 30/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

protocol SettingsViewDelegate{
    func logOffApp()
}

class SettingsPresenter{
    internal init(viewDelegate: SettingsViewDelegate? = nil, userDefaults: UserDefaultsProtocol) {
        self.viewDelegate = viewDelegate
        self.userDefaults = userDefaults
    }
    
    private var viewDelegate: SettingsViewDelegate?
    var userDefaults: UserDefaultsProtocol
    
    func setViewDelegate(_ viewDelegate: SettingsViewDelegate){
        self.viewDelegate = viewDelegate
    }
    
    func logOff(){
        userDefaults.disposeUserDefaults()
        viewDelegate?.logOffApp()
    }
}
