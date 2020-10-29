//
//  UserInfoPageTests.swift
//  iOSSwiftPayTests
//
//  Created by Leonardo on 21/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

@testable import iOSSwiftPay
import XCTest
import Mockingbird
import Firebase
import UIKit

class UserInfoPageTests: XCTestCase {
    var client: ClientProtocolMock!
    var presenter: UserInfoPresenter!
    var viewDelegate: UserInfoDelegateMock!
    var userDefaults: UserDefaultsProtocolMock!
    
    override func setUp() {
        userDefaults = mock(UserDefaultsProtocol.self)
        client = mock(ClientProtocol.self)
        viewDelegate = mock(UserInfoDelegate.self)
        presenter = UserInfoPresenter(userInfoDelegate: viewDelegate, client: client, userDefaults: userDefaults)
        super.setUp()
    }
    
    func testShowPositiveBalance(){
        let labelIsHidden = true
        let amountString = "R$ 0.20"
        given(viewDelegate.showBalanceLabel(color: .green)).willReturn()
        given(viewDelegate.hideBalanceLabel()).willReturn()
        presenter.toggleBalanceLabel(labelIsHidden, amountString)
        verify(viewDelegate.showBalanceLabel(color: .green)).wasCalled()
        verify(viewDelegate.hideBalanceLabel()).wasNeverCalled()
    }
    
    func testShowNegativeBalance(){
        let labelIsHidden = true
        let amountString = "R$ -5.20"
        given(viewDelegate.showBalanceLabel(color: .red)).willReturn()
        given(viewDelegate.hideBalanceLabel()).willReturn()
        presenter.toggleBalanceLabel(labelIsHidden, amountString)
        verify(viewDelegate.showBalanceLabel(color: .red)).wasCalled()
        verify(viewDelegate.hideBalanceLabel()).wasNeverCalled()
    }
    
    func testHideBalance(){
        let labelIsHidden = false
        let amountString = "R$ -5.20"
        given(viewDelegate.showBalanceLabel(color: .red)).willReturn()
        given(viewDelegate.hideBalanceLabel()).willReturn()
        presenter.toggleBalanceLabel(labelIsHidden, amountString)
        verify(viewDelegate.showBalanceLabel(color: .red)).wasNeverCalled()
        verify(viewDelegate.hideBalanceLabel()).wasCalled()
    }
    
    func testFetchUserInfoFailed(){
        let userEmail = "email@email.com"
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).willReturn(userEmail)
        given(viewDelegate.showTryAgainMessageAndButton()).willReturn()
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.setUserName(any())).willReturn()
        given(client.getUserInfo(userEmail, completionHandler: any())).will { email, callback in
            callback(.failure(ValidationError.noConnection))
        }
        presenter.fetchUserName()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
        verify(viewDelegate.showTryAgainMessageAndButton()).wasCalled()
        verify(viewDelegate.setUserName(any())).wasNeverCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).wasCalled()
    }
    
    func testFetchUserInfoSuccessfully(){
        let userEmail = "email@email.com"
        let userName = "Name"
        let userLastName = "Last Name"
        given(client.saveResultOnUserDefaults(userName, Constants.UserDefaultsKeys.userName)).willReturn()
        given(client.saveResultOnUserDefaults(userLastName, Constants.UserDefaultsKeys.userLastName)).willReturn()
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).willReturn(userEmail)
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userName)).willReturn(userName)
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userLastName)).willReturn(userLastName)
        given(viewDelegate.showTryAgainMessageAndButton()).willReturn()
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.setUserName(any())).willReturn()
        given(client.getUserInfo(userEmail, completionHandler: any())).will { email, callback in
            callback(.success(userEmail))
        }
        presenter.fetchUserName()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
        verify(viewDelegate.showTryAgainMessageAndButton()).wasNeverCalled()
        verify(viewDelegate.setUserName(any())).wasCalled()
        verify(client.saveResultOnUserDefaults(userName, Constants.UserDefaultsKeys.userName)).wasNeverCalled()
        verify(client.saveResultOnUserDefaults(userLastName, Constants.UserDefaultsKeys.userLastName)).wasNeverCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).wasCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userName)).wasCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userLastName)).wasCalled()
    }
    
    func testFetchTransactionsCurrentBalanceFailed(){
        let email = "panta@test.com"
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.showTryAgainMessageAndButton()).willReturn()
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).willReturn(email)
        given(client.getTransactionsBalance(email, completionHandler: any())).will { email, callback in
            callback(.failure(ValidationError.noConnection))
        }
        presenter.fetchTransactionsAndBalance()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
        verify(viewDelegate.showTryAgainMessageAndButton()).wasCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).wasCalled()
    }
    
    func testFetchTransactionsCurrentBalanceSuccessPositive(){
        let email = "panta@test.com"
        let resultBalance = 10.00
        let formattedBalance = String(format: "R$ %.02f", 10.00)
        let aTransaction: MoneyTransaction = MoneyTransaction(senderId: email, receiverId: email, amount: resultBalance, transactionDate: Date().timeIntervalSinceReferenceDate, type: Constants.TransactionTypes.deposit)
        let transactions: [MoneyTransaction] = [aTransaction]
        let encoder = JSONEncoder()
        let data = try? encoder.encode(transactions)
        let json = String(data: data!, encoding: .utf8)
        given(viewDelegate.setCurrentBalance(formattedBalance, .green)).willReturn()
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.showTryAgainMessageAndButton()).willReturn()
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.transactions)).willReturn(json!)
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).willReturn(email)
        given(client.getTransactionsBalance(email, completionHandler: any())).will { email, callback in
            callback(.success(resultBalance))
        }
        presenter.fetchTransactionsAndBalance()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
        verify(viewDelegate.showTryAgainMessageAndButton()).wasNeverCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).wasCalled()
        verify(viewDelegate.setCurrentBalance(formattedBalance, .green)).wasCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.transactions)).wasCalled()
    }
    
    func testFetchTransactionsCurrentBalanceSuccessNegative(){
        let email = "panta@test.com"
        let resultBalance = -2.50
        let formattedBalance = String(format: "R$ %.02f", -2.50)
        let aTransaction: MoneyTransaction = MoneyTransaction(senderId: email, receiverId: email, amount: resultBalance, transactionDate: Date().timeIntervalSinceReferenceDate, type: Constants.TransactionTypes.deposit)
        let transactions: [MoneyTransaction] = [aTransaction]
        let encoder = JSONEncoder()
        let data = try? encoder.encode(transactions)
        let json = String(data: data!, encoding: .utf8)
        given(viewDelegate.setCurrentBalance(formattedBalance, .red)).willReturn()
        given(viewDelegate.showProgress()).willReturn()
        given(viewDelegate.hideProgress()).willReturn()
        given(viewDelegate.showTryAgainMessageAndButton()).willReturn()
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.transactions)).willReturn(json!)
        given(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).willReturn(email)
        given(client.getTransactionsBalance(email, completionHandler: any())).will { email, callback in
            callback(.success(resultBalance))
        }
        presenter.fetchTransactionsAndBalance()
        verify(viewDelegate.showProgress()).wasCalled()
        verify(viewDelegate.hideProgress()).wasCalled()
        verify(viewDelegate.showTryAgainMessageAndButton()).wasNeverCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.userEmail)).wasCalled()
        verify(viewDelegate.setCurrentBalance(formattedBalance, .red)).wasCalled()
        verify(userDefaults.getStringOnUserDefaults(Constants.UserDefaultsKeys.transactions)).wasCalled()
    }
}
