//
//  DepositViewController.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 07/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import UIKit

class DepositViewController: UIViewController, DepositViewDelegate {
    func showProgress() {
        transactionActivityIndicator?.isHidden = false
        transactionActivityIndicator?.startAnimating()
    }
    
    func hideProgress() {
        transactionActivityIndicator?.isHidden = false
        transactionActivityIndicator?.stopAnimating()
    }
    
    func showMessage(_ message: String?, _ color: UIColor) {
        messageLabel.text = message
        messageLabel.textColor = color
    }
    
    private let presenter: DepositPresenter
    
    init(presenter: DepositPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let moneyDepositImage : UIImageView = {
        let image = UIImage(named: Constants.Assets.moneyDeposit)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let transactionActivityIndicator: UIActivityIndicatorView? = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    let moneyDepositBtn : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let emptyView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let amountTxField : UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: (Constants.ScreenInfo.screenWidth - 80), height: 50))
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let currencyLabel : UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let formStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let currencyView : UIView = {
        let stack = UIView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let messageLabel : UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(self)
        addSubViews()
        setUpLayout()
        setButtonsResponders()
        styleVisualElements()
        setPlaceholders()
        setTexts()
    }
    
    private func setTexts(){
        moneyDepositBtn.setTitle(NSLocalizedString(Constants.LocalizedStrings.moneyDeposit, comment: "money deposit btn text"), for: .normal)
        currencyLabel.text = "R$"
    }
    
    private func addSubViews(){
        view.addSubview(formStackView)
        formStackView.addArrangedSubview(moneyDepositImage)
        currencyView.addSubview(currencyLabel)
        currencyView.addSubview(amountTxField)
        formStackView.addArrangedSubview(currencyView)
        formStackView.addArrangedSubview(emptyView)
        formStackView.addArrangedSubview(moneyDepositBtn)
        formStackView.addArrangedSubview(messageLabel)
        view.addSubview(transactionActivityIndicator!)
    }
    
    private func setUpLayout(){
        //Logo image on top
        moneyDepositImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        moneyDepositImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        //Stack anchors
        formStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        formStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        formStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        formStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        //Currency stack anchors
        currencyView.leftAnchor.constraint(equalTo: formStackView.leftAnchor).isActive = true
        currencyView.rightAnchor.constraint(equalTo: formStackView.rightAnchor).isActive = true
        currencyView.centerXAnchor.constraint(equalTo: formStackView.centerXAnchor).isActive = true
        currencyView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //Other elements anchors
        moneyDepositBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        moneyDepositBtn.leftAnchor.constraint(equalTo: formStackView.leftAnchor).isActive = true
        moneyDepositBtn.rightAnchor.constraint(equalTo: formStackView.rightAnchor).isActive = true
        emptyView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        currencyLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        currencyLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        currencyLabel.leftAnchor.constraint(equalTo: currencyView.leftAnchor).isActive = true
        currencyLabel.topAnchor.constraint(equalTo: currencyView.topAnchor).isActive = true
        amountTxField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        amountTxField.rightAnchor.constraint(equalTo: currencyView.rightAnchor).isActive = true
        amountTxField.leftAnchor.constraint(equalTo: currencyLabel.rightAnchor).isActive = true
        amountTxField.centerYAnchor.constraint(equalTo: currencyLabel.centerYAnchor).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        messageLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        transactionActivityIndicator?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        transactionActivityIndicator?.widthAnchor.constraint(equalToConstant: 50).isActive = true
        transactionActivityIndicator?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        transactionActivityIndicator?.topAnchor.constraint(equalTo: formStackView.bottomAnchor, constant: 20).isActive = true
    }
    
    private func setButtonsResponders(){
        moneyDepositBtn.addTarget(self, action: #selector(moneyDepositBtnTapped), for: .touchUpInside)
    }
    
    @objc func moneyDepositBtnTapped(sender: UIButton!){
        presenter.performDepositTransaction(amountTxField.text)
    }
    
    private func styleVisualElements()
    {
        view.backgroundColor = .white
        currencyLabel.font = .boldSystemFont(ofSize: 20)
        Utilities.styleFilledButton(moneyDepositBtn)
        Utilities.styleTextField(amountTxField)
    }
    
    private func setPlaceholders()
    {
        amountTxField.placeholder = NSLocalizedString(Constants.LocalizedStrings.insertAmount, comment: "amount placeholder")
    }

}
