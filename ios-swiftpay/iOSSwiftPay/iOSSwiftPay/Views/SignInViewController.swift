//
//  SignInViewController.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 29/09/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, SignInViewDelagate {
    private let signInPresenter = SignInPresenter();
    
    func toggleLoading(show: (Bool)) {
        if show{
            signInActivityIndicator?.startAnimating()
        }
        else{
            signInActivityIndicator?.stopAnimating()
        }
    }
    
    let signInActivityIndicator: UIActivityIndicatorView? = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    let swiftPayLogoImage : UIImageView = {
        let image = UIImage(named: Constants.Assets.swiftPayLogo)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    let createAccountBtn : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signInBtn : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let copyrightLabel : UILabel = {
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInPresenter.setViewDelegate(signInViewDelagate: self)
        addSubViews()
        setPlaceholders()
        setUpLayout()
        setButtonsResponders()
        styleVisualElements()
    }
    
    private func addSubViews(){
        view.addSubview(swiftPayLogoImage)
        view.addSubview(formStackView)
        formStackView.addArrangedSubview(signInActivityIndicator!)
        formStackView.addArrangedSubview(emailTxField)
        formStackView.addArrangedSubview(passwordTxField)
        formStackView.addArrangedSubview(signInBtn)
        formStackView.addArrangedSubview(createAccountBtn)
        formStackView.addArrangedSubview(copyrightLabel)
    }
    
    private func setUpLayout(){
        //Logo image on top
        swiftPayLogoImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        swiftPayLogoImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        swiftPayLogoImage.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        swiftPayLogoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //Stack anchors
        formStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        formStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        formStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        formStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        //Other elements have same height
        createAccountBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        createAccountBtn.leftAnchor.constraint(equalTo: formStackView.leftAnchor).isActive = true
        createAccountBtn.rightAnchor.constraint(equalTo: formStackView.rightAnchor).isActive = true
        signInBtn.heightAnchor.constraint(equalTo: createAccountBtn.heightAnchor).isActive = true
        signInBtn.leftAnchor.constraint(equalTo: formStackView.leftAnchor).isActive = true
        signInBtn.rightAnchor.constraint(equalTo: formStackView.rightAnchor).isActive = true
        emailTxField.heightAnchor.constraint(equalTo: createAccountBtn.heightAnchor).isActive = true
        emailTxField.leftAnchor.constraint(equalTo: formStackView.leftAnchor).isActive = true
        emailTxField.rightAnchor.constraint(equalTo: formStackView.rightAnchor).isActive = true
        passwordTxField.heightAnchor.constraint(equalTo: createAccountBtn.heightAnchor).isActive = true
        passwordTxField.leftAnchor.constraint(equalTo: formStackView.leftAnchor).isActive = true
        passwordTxField.rightAnchor.constraint(equalTo: formStackView.rightAnchor).isActive = true
    }
    
    private func setButtonsResponders(){
        signInBtn.addTarget(self, action: #selector(signInBtnTapped), for: .touchUpInside)
    }
    
    @objc func signInBtnTapped(sender: UIButton!){
        signInPresenter.SignIn();
    }
    
    private func styleVisualElements()
    {
        view.backgroundColor = .white
        Utilities.styleTextField(emailTxField)
        Utilities.styleTextField(passwordTxField)
        Utilities.styleHollowButton(createAccountBtn)
        Utilities.styleFilledButton(signInBtn)
        createAccountBtn.setTitleColor(.black, for: .normal)
    }
    
    private func setPlaceholders()
    {
        emailTxField.placeholder = NSLocalizedString(Constants.LocalizedStrings.emailPlaceholder, comment: "insert email placeholder")
        passwordTxField.placeholder = NSLocalizedString(Constants.LocalizedStrings.passwordPlaceholder, comment: "insert password placeholder")
        signInBtn.setTitle(NSLocalizedString(Constants.LocalizedStrings.signInBtnText, comment: "sign in button text"), for: .normal)
        createAccountBtn.setTitle(NSLocalizedString(Constants.LocalizedStrings.createAccountBtnText, comment: "create account button text"), for: UIControl.State.normal)
        copyrightLabel.text = NSLocalizedString(Constants.LocalizedStrings.copyright, comment: "copyright text")
    }
}
