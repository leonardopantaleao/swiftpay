//
//  UserInfoViewController.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 07/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UserInfoDelegate {
    func showProgress() {
        view.isUserInteractionEnabled = false
        transactionsTableView.isHidden = true
        tryAgainBtn.isHidden = true
        errorLabel.isHidden = true
        transactionActivityIndicator?.startAnimating()
    }
    
    func hideProgress() {
        view.isUserInteractionEnabled = true
        transactionsTableView.isHidden = false
        tryAgainBtn.isHidden = false
        errorLabel.isHidden = false
        transactionActivityIndicator?.stopAnimating()
    }
    
    func showTryAgainMessageAndButton() {
        errorLabel.isHidden = false
        tryAgainBtn.isHidden = false
        transactionsTableView.isHidden = true
    }
    
    func hideTryAgainMessageAndButton() {
        errorLabel.isHidden = true
        tryAgainBtn.isHidden = true
        transactionsTableView.isHidden = false
    }
    
    func showBalanceLabel(color: UIColor) {
        balanceTxField.isSecureTextEntry = false
        balanceTxField.textColor = color
    }
    
    func hideBalanceLabel() {
        balanceTxField.isSecureTextEntry = true
        balanceTxField.textColor = .black
    }
    
    func setUserName(_ userName: String) {
        userNameLabel.text = userName
    }
    
    func setCurrentBalance(_ formattedBalance: String, _ color: UIColor) {
        balanceTxField.text = formattedBalance
        balanceTxField.textColor = balanceTxField.isSecureTextEntry ? .black : color
    }
    
    var transactions : [MoneyTransaction] = []
    func setTransactionsTable(_ moneyTransactions: [MoneyTransaction]?) {
        guard let transactions = moneyTransactions else { return }
        self.transactions = transactions
        transactionsTableView.dataSource = self
        transactionsTableView.delegate = self
        transactionsTableView.register(MoneyTransactionTableViewCell.self, forCellReuseIdentifier: "transactionCell")
        transactionsTableView.reloadData()
    }
    
    private let userInfoPresenter: UserInfoPresenter
    
    init(userInfoPresenter: UserInfoPresenter) {
        self.userInfoPresenter = userInfoPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! MoneyTransactionTableViewCell
        let transaction = transactions[indexPath.row]
        cell.transactionIconImage.image = UIImage(named: transaction.type == "transfer" ? Constants.Assets.rowIconMoneyTransfer : Constants.Assets.rowIconMoneyDeposit)
        cell.transactionTitle.text = transaction.type == "transfer" ? NSLocalizedString(Constants.LocalizedStrings.transfer, comment: "money transfer string") : NSLocalizedString(Constants.LocalizedStrings.deposit, comment: "money deposit string")
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        cell.transactionSubtitle.text = formatter.string(from: Date(timeIntervalSinceReferenceDate: transaction.transactionDate))
        let userEmail = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.userEmail)
        let transactionSymbol = "\(transaction.type == "transfer" && transaction.receiverId != userEmail ? "-" : "+")"
        let currencyFormatter = NumberFormatter()
        currencyFormatter.locale = Locale.init(identifier: "pt_BR")
        currencyFormatter.numberStyle = .currency
        let transactionAmount = "\(transactionSymbol) \(currencyFormatter.string(from: transaction.amount as NSNumber) ?? "")"
        cell.transactionAmount.text = "\(transactionAmount)"
        cell.transactionAmount.textColor = transaction.receiverId == userEmail ? .green : .red
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    let userImage : UIImageView = {
        let image = UIImage(named: Constants.Assets.user)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userNameLabel : UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let balanceLabel : UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString(Constants.LocalizedStrings.balance, comment: "current balance label")
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let balanceTxField : UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 180, height: 50))
        textField.isSecureTextEntry = true
        textField.isEnabled = false
        textField.borderStyle = .none
        textField.minimumFontSize = 28.0
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let showBalanceBtn : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let transactionLabel : UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString(Constants.LocalizedStrings.transactions, comment: "transactions label")
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let transactionsTableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let transactionActivityIndicator: UIActivityIndicatorView? = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let errorLabel : UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.isHidden = true
        return label
    }()
    
    let tryAgainBtn : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString(Constants.LocalizedStrings.tryAgain, comment: "try again button text"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInfoPresenter.setViewDelegate(userInfoDelegate: self)
        addSubViews()
        setUpLayout()
        setButtonsResponders()
        styleVisualElements()
        setTexts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userInfoPresenter.fetchUserName()
        userInfoPresenter.fetchTransactionsAndBalance()
    }
    
    private func setTexts(){
        userNameLabel.text = NSLocalizedString(Constants.LocalizedStrings.loading, comment: "loading user name label")
        showBalanceBtn.setTitle(NSLocalizedString(Constants.LocalizedStrings.show, comment: "show balance button"), for: .normal)
    }
    
    private func addSubViews(){
        view.addSubview(userImage)
        view.addSubview(transactionActivityIndicator!)
        view.addSubview(userNameLabel)
        view.addSubview(balanceLabel)
        view.addSubview(balanceTxField)
        view.addSubview(showBalanceBtn)
        view.addSubview(transactionLabel)
        view.addSubview(transactionsTableView)
        view.addSubview(errorLabel)
        view.addSubview(tryAgainBtn)
    }
    
    private func setUpLayout(){
        //Logo image on top
        userImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        //Activity indicator anchors
        transactionActivityIndicator?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        transactionActivityIndicator?.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 10).isActive = true
        //Name label anchors
        userNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        userNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userNameLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 40).isActive = true
        //Balance label anchors
        balanceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        balanceLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor).isActive = true
        balanceLabel.heightAnchor.constraint(equalTo: userNameLabel.heightAnchor).isActive = true
        //Balance text field anchors
        balanceTxField.leftAnchor.constraint(equalTo: balanceLabel.rightAnchor, constant: 10).isActive = true
        balanceTxField.centerYAnchor.constraint(equalTo: balanceLabel.centerYAnchor).isActive = true
        balanceTxField.heightAnchor.constraint(equalTo: userNameLabel.heightAnchor).isActive = true
        balanceTxField.widthAnchor.constraint(equalToConstant: 180).isActive = true
        //Show balance button anchors
        showBalanceBtn.leftAnchor.constraint(equalTo: balanceTxField.rightAnchor).isActive = true
        showBalanceBtn.centerYAnchor.constraint(equalTo: balanceLabel.centerYAnchor).isActive = true
        showBalanceBtn.heightAnchor.constraint(equalTo: userNameLabel.heightAnchor).isActive = true
        showBalanceBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //Transactions label anchors
        transactionLabel.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor).isActive = true
        transactionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        transactionLabel.heightAnchor.constraint(equalTo: userNameLabel.heightAnchor).isActive = true
        //Transactions table view anchors
        transactionsTableView.topAnchor.constraint(equalTo: transactionLabel.bottomAnchor, constant: 20).isActive = true
        transactionsTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        transactionsTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        transactionsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        //ErrorLabel anchors
        errorLabel.topAnchor.constraint(equalTo: transactionLabel.bottomAnchor, constant: 20).isActive = true
        errorLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        errorLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        errorLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        //TryAgainBtn anchors
        tryAgainBtn.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 20).isActive = true
        tryAgainBtn.leftAnchor.constraint(equalTo: errorLabel.leftAnchor).isActive = true
        tryAgainBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setButtonsResponders(){
        showBalanceBtn.addTarget(self, action: #selector(showBalanceBtnTapped), for: .touchUpInside)
    }
    
    @objc func showBalanceBtnTapped(sender: UIButton!){
        userInfoPresenter.toggleBalanceLabel(balanceTxField.isSecureTextEntry)
    }
    
    private func styleVisualElements()
    {
        view.backgroundColor = .white
        userNameLabel.font = .boldSystemFont(ofSize: 20)
        Utilities.styleFilledButton(showBalanceBtn)
        Utilities.styleFilledButton(tryAgainBtn)
    }
}
    
