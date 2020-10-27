//
//  HomeViewController.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 08/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()
        let userInfoPresenter = UserInfoPresenter(client: FirebaseFirestoreClient(), userDefaults: UserDefaultsService())
        let depositPresenter = DepositPresenter(userDefaults: UserDefaultsService(), client: FirebaseFirestoreClient(), validationService: ValidationService())
        let transferPresenter = TransferPresenter(userDefaults: UserDefaultsService(), client: FirebaseFirestoreClient(), validationService: ValidationService())
        viewControllers = [ UserInfoViewController(userInfoPresenter: userInfoPresenter), DepositViewController(presenter: depositPresenter), TransferViewController(presenter: transferPresenter), SettingsViewController() ]
        setBarItems()
        selectedViewController = viewControllers![0]
    }
    
    private func setBarItems(){
        viewControllers![0].tabBarItem = UITabBarItem(title: NSLocalizedString(Constants.LocalizedStrings.home, comment: "home view controller"), image: UIImage(named: Constants.Assets.home), tag: 0)
        viewControllers![1].tabBarItem = UITabBarItem(title: NSLocalizedString(Constants.LocalizedStrings.toDeposit, comment: "deposit view controller"), image: UIImage(named: Constants.Assets.rowIconMoneyDeposit), tag: 0)
        viewControllers![2].tabBarItem = UITabBarItem(title: NSLocalizedString(Constants.LocalizedStrings.toTransfer, comment: "transfer view controller"), image: UIImage(named: Constants.Assets.rowIconMoneyTransfer), tag: 0)
        viewControllers![3].tabBarItem = UITabBarItem(title: NSLocalizedString(Constants.LocalizedStrings.settings, comment: "settings view controller"), image: UIImage(named: Constants.Assets.settings), tag: 0)
    }

}
