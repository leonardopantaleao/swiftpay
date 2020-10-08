//
//  UserInfoViewController.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 07/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! MoneyTransactionTableViewCell
        let transaction = transactions[indexPath.row]
        cell.transactionIconImage.image = UIImage(named: transaction.type == "transfer" ? Constants.Assets.rowIconMoneyTransfer : Constants.Assets.rowIconMoneyDeposit)
        cell.transactionTitle.text = transaction.type == "transfer" ? NSLocalizedString(Constants.LocalizedStrings.transfer, comment: "money transfer string") : NSLocalizedString(Constants.LocalizedStrings.deposit, comment: "money deposit string")
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        cell.transactionSubtitle.text = formatter.string(from: Date(timeIntervalSinceReferenceDate: transaction.transactionDate))
        cell.transactionAmount.text = "\(transaction.type == "transfer" ? "-" : "+")R$ \(transaction.amount)"
        cell.transactionAmount.textColor = transaction.type == "transfer" ? .red : .green
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
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        textField.isSecureTextEntry = true
        textField.isEnabled = false
        textField.text = "R$ 00,00"
        textField.borderStyle = .none
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
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        signInPresenter.setViewDelegate(signInViewDelagate: self)
        addSubViews()
        setUpLayout()
        setButtonsResponders()
        styleVisualElements()
        setTexts()
        setupTableView()
    }
    
    private func setTexts(){
        userNameLabel.text = "Leonardo Panta Leão"
        showBalanceBtn.setTitle(NSLocalizedString(Constants.LocalizedStrings.show, comment: "show balance button"), for: .normal)
    }
    
    private func addSubViews(){
        view.addSubview(userImage)
        view.addSubview(userNameLabel)
        view.addSubview(balanceLabel)
        view.addSubview(balanceTxField)
        view.addSubview(showBalanceBtn)
        view.addSubview(transactionLabel)
        view.addSubview(transactionsTableView)
        //        view.addSubview(transactionActivityIndicator!)
    }
    
    private func setUpLayout(){
        //Logo image on top
        userImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        //Name label anchors
        userNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        userNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userNameLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 20).isActive = true
        //Balance label anchors
        balanceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        balanceLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor).isActive = true
        balanceLabel.heightAnchor.constraint(equalTo: userNameLabel.heightAnchor).isActive = true
        //Balance text field anchors
        balanceTxField.leftAnchor.constraint(equalTo: balanceLabel.rightAnchor, constant: 10).isActive = true
        balanceTxField.centerYAnchor.constraint(equalTo: balanceLabel.centerYAnchor).isActive = true
        balanceTxField.heightAnchor.constraint(equalTo: userNameLabel.heightAnchor).isActive = true
        balanceTxField.widthAnchor.constraint(equalToConstant: 100).isActive = true
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
    }
    
    private func setButtonsResponders(){
        showBalanceBtn.addTarget(self, action: #selector(showBalanceBtnTapped), for: .touchUpInside)
    }
    
    @objc func showBalanceBtnTapped(sender: UIButton!){
        //        signInPresenter.SignIn();
    }
    
    private func styleVisualElements()
    {
        view.backgroundColor = .white
        userNameLabel.font = .boldSystemFont(ofSize: 20)
        Utilities.styleFilledButton(showBalanceBtn)
    }
    
    var transactions : [MoneyTransactionMock] = []
    
    private func setupTableView(){
        let transfer = MoneyTransactionMock(senderId: "leonardopspl@gmail.com", receiverId: "leonardopspl@gmail.com", amount: 5.00, transactionDate: Date().timeIntervalSinceReferenceDate, type: "deposit")
        let deposit = MoneyTransactionMock(senderId: "test_sender@gmail.com", receiverId: "leonardopspl@gmail.com", amount: 5.00, transactionDate: Date().timeIntervalSinceReferenceDate, type: "transfer")
        transactions = [ transfer, deposit ]
        transactionsTableView.dataSource = self
        transactionsTableView.delegate = self
        transactionsTableView.register(MoneyTransactionTableViewCell.self, forCellReuseIdentifier: "transactionCell")
    }
}

public class MoneyTransactionMock{
    internal init(senderId: String, receiverId: String, amount: Double, transactionDate: TimeInterval, type: String) {
        self.senderId = senderId
        self.receiverId = receiverId
        self.amount = amount
        self.transactionDate = transactionDate
        self.type = type
    }
    
    public var senderId: String
    public var receiverId: String
    public var amount: Double
    public var transactionDate: TimeInterval
    public var type: String
}
