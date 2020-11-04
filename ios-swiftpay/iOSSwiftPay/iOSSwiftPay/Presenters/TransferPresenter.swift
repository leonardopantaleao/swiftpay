//
//  TransferPresenter.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 26/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation
import UIKit

protocol TransferViewDelegate{
    func showProgress()
    func hideProgress()
    func showMessage(_ message: String?, _ color: UIColor)
}

class TransferPresenter{
    internal init(viewDelegate: TransferViewDelegate? = nil, userDefaults: UserDefaultsProtocol, client: ClientProtocol, validationService: ValidationService) {
        self.viewDelegate = viewDelegate
        self.userDefaults = userDefaults
        self.client = client
        self.validationService = validationService
    }
    
    private var viewDelegate: TransferViewDelegate?
    var userDefaults: UserDefaultsProtocol
    var client: ClientProtocol
    var validationService: ValidationService
    
    func setViewDelegate(_ viewDelegate: TransferViewDelegate){
        self.viewDelegate = viewDelegate
    }
    
    func performTransferTransaction(_ email: String?, _ amount: String?){
        let senderEmail = userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)
        var doubleAmount: Double = 0
        var receiverEmail: String = ""
        do {
            doubleAmount = try validationService.validateAmount(amount)
            receiverEmail = try validationService.validateEmail(email)
        } catch let error{
            let err = error as! ValidationError
            viewDelegate?.showMessage(err.localizedDescription, .red)
        }
        guard doubleAmount > 0 else { return }
        guard receiverEmail != "" else { return }
        viewDelegate?.showProgress()
        client.performTransaction(senderEmail, receiverEmail, doubleAmount, Constants.TransactionTypes.transfer, Date().timeIntervalSinceReferenceDate, completionHandler: { result in
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
