//
//  SignInViewController.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 29/09/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, SignInViewDelegate {
    
    func navigateToSignUp() {
        let firebaseClient = FirebaseFirestoreClient()
        let validationService = ValidationService()
        let userDefaults = UserDefaultsService()
        let presenter = SignUpPresenter(validationService: validationService, client: firebaseClient, userDefaults: userDefaults)
        let signUpViewController = SignUpViewController(signUpPresenter: presenter)
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    func showProgress() {
        view.isUserInteractionEnabled = false
        signInActivityIndicator?.startAnimating()
    }
    
    func hideProgress() {
        view.isUserInteractionEnabled = true
        signInActivityIndicator?.stopAnimating()
    }
    
    func loginDidSucceed() {
        let options: UIView.AnimationOptions = .transitionFlipFromRight
        let duration: TimeInterval = 0.3
        UIApplication.shared.windows.first?.rootViewController = HomeViewController()
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        UIView.transition(with: UIApplication.shared.windows.first!, duration: duration, options: options, animations: {}, completion:
        nil)
    }
    
    func loginDidFailed(message: String) {
        errorLabel.text = message
    }
    
    
    private let signInPresenter: SignInPresenter
    
    init(signInPresenter: SignInPresenter) {
        self.signInPresenter = signInPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTxField : UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: (Constants.ScreenInfo.screenWidth - 40), height: 50))
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let signUpBtn : UIButton = {
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
    
    let errorLabel : UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
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
        formStackView.addArrangedSubview(signUpBtn)
        formStackView.addArrangedSubview(copyrightLabel)
        formStackView.addArrangedSubview(errorLabel)
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
        signUpBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signUpBtn.leftAnchor.constraint(equalTo: formStackView.leftAnchor).isActive = true
        signUpBtn.rightAnchor.constraint(equalTo: formStackView.rightAnchor).isActive = true
        signInBtn.heightAnchor.constraint(equalTo: signUpBtn.heightAnchor).isActive = true
        signInBtn.leftAnchor.constraint(equalTo: formStackView.leftAnchor).isActive = true
        signInBtn.rightAnchor.constraint(equalTo: formStackView.rightAnchor).isActive = true
        emailTxField.heightAnchor.constraint(equalTo: signUpBtn.heightAnchor).isActive = true
        emailTxField.leftAnchor.constraint(equalTo: formStackView.leftAnchor).isActive = true
        emailTxField.rightAnchor.constraint(equalTo: formStackView.rightAnchor).isActive = true
        passwordTxField.heightAnchor.constraint(equalTo: signUpBtn.heightAnchor).isActive = true
        passwordTxField.leftAnchor.constraint(equalTo: formStackView.leftAnchor).isActive = true
        passwordTxField.rightAnchor.constraint(equalTo: formStackView.rightAnchor).isActive = true
    }
    
    private func setButtonsResponders(){
        signInBtn.addTarget(self, action: #selector(signInBtnTapped), for: .touchUpInside)
        signUpBtn.addTarget(self, action: #selector(signUpBtnTapped), for: .touchUpInside)
    }
    
    @objc func signInBtnTapped(sender: UIButton!){
        signInPresenter.signIn(emailTxField.text, passwordTxField.text);
    }
    
    @objc func signUpBtnTapped(sender: UIButton!){
        signInPresenter.navigateToSignUp();
    }
    
    private func styleVisualElements()
    {
        view.backgroundColor = .white
        Utilities.styleTextField(emailTxField)
        Utilities.styleTextField(passwordTxField)
        Utilities.styleHollowButton(signUpBtn)
        Utilities.styleFilledButton(signInBtn)
        signUpBtn.setTitleColor(.black, for: .normal)
    }
    
    private func setPlaceholders()
    {
        emailTxField.placeholder = NSLocalizedString(Constants.LocalizedStrings.emailPlaceholder, comment: "insert email placeholder")
        passwordTxField.placeholder = NSLocalizedString(Constants.LocalizedStrings.passwordPlaceholder, comment: "insert password placeholder")
        signInBtn.setTitle(NSLocalizedString(Constants.LocalizedStrings.signInBtnText, comment: "sign in button text"), for: .normal)
        signUpBtn.setTitle(NSLocalizedString(Constants.LocalizedStrings.createAccountBtnText, comment: "create account button text"), for: UIControl.State.normal)
        copyrightLabel.text = NSLocalizedString(Constants.LocalizedStrings.copyright, comment: "copyright text")
    }
}
