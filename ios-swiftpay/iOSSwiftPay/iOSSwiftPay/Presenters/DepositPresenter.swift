//
//  DepositPresenter.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 26/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation
import UIKit

protocol DepositViewDelegate{
    func showProgress()
    func hideProgress()
    func showMessage(_ message: String?, _ color: UIColor)
}

class DepositPresenter{
    internal init(viewDelegate: DepositViewDelegate? = nil, userDefaults: UserDefaultsProtocol, client: ClientProtocol, validationService: ValidationService) {
        self.viewDelegate = viewDelegate
        self.userDefaults = userDefaults
        self.client = client
        self.validationService = validationService
    }
    
    
    private var viewDelegate: DepositViewDelegate?
    var userDefaults: UserDefaultsProtocol
    var client: ClientProtocol
    var validationService: ValidationService
    
    
    
    func setViewDelegate(_ viewDelegate: DepositViewDelegate){
        self.viewDelegate = viewDelegate
    }
    
    func performDepositTransaction(_ amount: String?){
        let email = userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)
        var doubleAmount: Double = 0
        do {
            doubleAmount = try validationService.validateAmount(amount)
        } catch let error{
            let err = error as! ValidationError
            viewDelegate?.showMessage(err.localizedDescription, .red)
        }
        guard doubleAmount > 0 else { return }
        viewDelegate?.showProgress()
        client.performTransaction(email, email, doubleAmount, Constants.TransactionTypes.deposit, Date().timeIntervalSinceReferenceDate, completionHandler: { result in
            switch result{
            case .success(_):
                self.viewDelegate?.showMessage(NSLocalizedString(Constants.LocalizedStrings.transactionSuccess, comment: "transaction success message"), .green)
            case .failure(_):
                self.viewDelegate?.showMessage(NSLocalizedString(Constants.LocalizedStrings.transactionFail, comment: "transaction fail message"), .red)
            }
            self.viewDelegate?.hideProgress()
        })
    }
}
