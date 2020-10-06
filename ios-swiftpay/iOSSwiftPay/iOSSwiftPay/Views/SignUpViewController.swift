//
//  SignUpViewController.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 06/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let firebaseClient: ClientProtocol
    
    init(firebaseClient: ClientProtocol) {
        self.firebaseClient = firebaseClient
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let swiftPayLogoImage : UIImageView = {
        let image = UIImage(named: Constants.Assets.swiftPayLogo)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let signUpActivityIndicator: UIActivityIndicatorView? = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    let nameTxField : UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: (Constants.ScreenInfo.screenWidth - 40), height: 50))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let lastNameTxField : UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: (Constants.ScreenInfo.screenWidth - 40), height: 50))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailTxField : UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: (Constants.ScreenInfo.screenWidth - 40), height: 50))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTxField : UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: (Constants.ScreenInfo.screenWidth - 40), height: 50))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTxFieldConfirm : UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: (Constants.ScreenInfo.screenWidth - 40), height: 50))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let signUpBtn : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let emptyView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        signInPresenter.setViewDelegate(signInViewDelagate: self)
        addSubViews()
        setPlaceholders()
        setUpLayout()
        setButtonsResponders()
        styleVisualElements()
    }
    
    private func addSubViews(){
        view.addSubview(swiftPayLogoImage)
        view.addSubview(formStackView)
        formStackView.addArrangedSubview(signUpActivityIndicator!)
        formStackView.addArrangedSubview(nameTxField)
        formStackView.addArrangedSubview(lastNameTxField)
        formStackView.addArrangedSubview(emailTxField)
        formStackView.addArrangedSubview(passwordTxField)
        formStackView.addArrangedSubview(passwordTxFieldConfirm)
        formStackView.addArrangedSubview(emptyView)
        formStackView.addArrangedSubview(signUpBtn)
    }
    
    private func setUpLayout(){
        //Logo image on top
        swiftPayLogoImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        swiftPayLogoImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        swiftPayLogoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        swiftPayLogoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //Stack anchors
        formStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        formStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        formStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        formStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        //Other elements have same height
        signUpBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signUpBtn.leftAnchor.constraint(equalTo: formStackView.leftAnchor).isActive = true
        signUpBtn.rightAnchor.constraint(equalTo: formStackView.rightAnchor).isActive = true
        nameTxField.heightAnchor.constraint(equalTo: signUpBtn.heightAnchor).isActive = true
        nameTxField.leftAnchor.constraint(equalTo: formStackView.leftAnchor).isActive = true
        nameTxField.rightAnchor.constraint(equalTo: formStackView.rightAnchor).isActive = true
        lastNameTxField.heightAnchor.constraint(equalTo: signUpBtn.heightAnchor).isActive = true
        lastNameTxField.leftAnchor.constraint(equalTo: formStackView.leftAnchor).isActive = true
        lastNameTxField.rightAnchor.constraint(equalTo: formStackView.rightAnchor).isActive = true
        emailTxField.heightAnchor.constraint(equalTo: signUpBtn.heightAnchor).isActive = true
        emailTxField.leftAnchor.constraint(equalTo: formStackView.leftAnchor).isActive = true
        emailTxField.rightAnchor.constraint(equalTo: formStackView.rightAnchor).isActive = true
        passwordTxField.heightAnchor.constraint(equalTo: signUpBtn.heightAnchor).isActive = true
        passwordTxField.leftAnchor.constraint(equalTo: formStackView.leftAnchor).isActive = true
        passwordTxField.rightAnchor.constraint(equalTo: formStackView.rightAnchor).isActive = true
        passwordTxFieldConfirm.heightAnchor.constraint(equalTo: signUpBtn.heightAnchor).isActive = true
        passwordTxFieldConfirm.leftAnchor.constraint(equalTo: formStackView.leftAnchor).isActive = true
        passwordTxFieldConfirm.rightAnchor.constraint(equalTo: formStackView.rightAnchor).isActive = true
        emptyView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setButtonsResponders(){
        signUpBtn.addTarget(self, action: #selector(signUpBtnTapped), for: .touchUpInside)
    }
    
    @objc func signUpBtnTapped(sender: UIButton!){
//        signInPresenter.SignIn();
    }
    
    private func styleVisualElements()
    {
        view.backgroundColor = .white
        Utilities.styleTextField(nameTxField)
        Utilities.styleTextField(lastNameTxField)
        Utilities.styleTextField(emailTxField)
        Utilities.styleTextField(passwordTxField)
        Utilities.styleTextField(passwordTxFieldConfirm)
        Utilities.styleFilledButton(signUpBtn)
    }
    
    private func setPlaceholders()
    {
        passwordTxField.clearButtonMode = .always
        passwordTxFieldConfirm.clearButtonMode = .always
        passwordTxField.isSecureTextEntry = true
        passwordTxFieldConfirm.isSecureTextEntry = true
        nameTxField.placeholder = NSLocalizedString(Constants.LocalizedStrings.namePlaceholder, comment: "insert name placeholder")
        lastNameTxField.placeholder = NSLocalizedString(Constants.LocalizedStrings.lastNamePlaceholder, comment: "insert last name placeholder")
        emailTxField.placeholder = NSLocalizedString(Constants.LocalizedStrings.emailPlaceholder, comment: "insert email placeholder")
        passwordTxField.placeholder = NSLocalizedString(Constants.LocalizedStrings.passwordPlaceholder, comment: "insert password placeholder")
        passwordTxFieldConfirm.placeholder = NSLocalizedString(Constants.LocalizedStrings.passwordPlaceholder, comment: "insert password placeholder")
        signUpBtn.setTitle(NSLocalizedString(Constants.LocalizedStrings.createAccountBtnText, comment: "create account button text"), for: UIControl.State.normal)
    }
    

}
