//
//  UserInfoPresenter.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 21/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation
import UIKit

protocol UserInfoDelegate{
    func showProgress()
    func hideProgress()
    func showTryAgainMessageAndButton()
    func hideTryAgainMessageAndButton()
    func showBalanceLabel()
    func hideBalanceLabel()
    func setUserName(_ userName: String)
    func setCurrentBalance(_ formattedBalance: String, _ color: UIColor)
    func setTransactionsTable(_ moneyTransactions: [MoneyTransaction])
}

class UserInfoPresenter{
    private var userInfoDelegate: UserInfoDelegate?
    var userDefaults: UserDefaultsProtocol
    var client: ClientProtocol
    
    internal init(userInfoDelegate: UserInfoDelegate? = nil, client: ClientProtocol, userDefaults: UserDefaultsProtocol) {
        self.userInfoDelegate = userInfoDelegate
        self.userDefaults = userDefaults
        self.client = client
    }
    
    func setViewDelegate(userInfoDelegate: UserInfoDelegate?){
        self.userInfoDelegate = userInfoDelegate
    }
    
    func getAndShowUserName(){
        
    }
    
    func getAndShowCurrentBalance(){
        
    }
    
    func getAndShowTransactions(){
        
    }
}
