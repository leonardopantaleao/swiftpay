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
    func showBalanceLabel(color: UIColor)
    func hideBalanceLabel()
    func setUserName(_ userName: String)
    func setCurrentBalance(_ formattedBalance: String, _ color: UIColor)
    func setTransactionsTable(_ moneyTransactions: [MoneyTransaction]?)
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
    
    func fetchUserName(){
        userInfoDelegate?.showProgress()
        let userEmail = userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)
        client.getUserInfo(userEmail, completionHandler: {
            result in
            switch result{
            case .success(_):
                let userName = self.userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userName)
                let userLastName = self.userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userLastName)
                let completeName = "\(userName) \(userLastName)"
                self.userInfoDelegate?.setUserName(completeName)
            case .failure(_):
                self.userInfoDelegate?.showTryAgainMessageAndButton()
            }
            self.userInfoDelegate?.hideProgress()
        })
    }
    
    func fetchTransactionsAndBalance(){
        userInfoDelegate?.showProgress()
        let userEmail = userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)
        client.getTransactionsBalance(userEmail, completionHandler: {
            result in
            switch result{
            case .success(let amount):
                let decoder = JSONDecoder()
                let transactionsJson = self.userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.transactions)
                let transactionsData = Data(transactionsJson.utf8)
                let transactions = try? decoder.decode([MoneyTransaction].self, from: transactionsData)
                self.userInfoDelegate?.setTransactionsTable(transactions)
                self.userInfoDelegate?.setCurrentBalance(String(format: "R$ %.02f", amount), amount >= 0.00 ? .green : .red)
            case .failure(_):
                self.userInfoDelegate?.showTryAgainMessageAndButton()
            }
            self.userInfoDelegate?.hideProgress()
        })
    }
    
    func toggleBalanceLabel(_ labelIsSecure: Bool, _ formattedAmount: String){
        let amount = Double(formattedAmount.replacingOccurrences(of: "R$ ", with: ""))!
        if(labelIsSecure){
            userInfoDelegate?.showBalanceLabel(color: amount >= 0.00 ? .green : .red)
        }
        else{
            userInfoDelegate?.hideBalanceLabel()
        }
    }
}
