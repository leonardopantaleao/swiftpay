//
//  SettingsViewController.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 06/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let swiftPayLogoImage : UIImageView = {
        let image = UIImage(named: Constants.Assets.swiftPayLogo)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let logOffBtn : UIButton = {
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
        setUpLayout()
        setButtonsResponders()
        styleVisualElements()
        setTexts()
    }
    
    private func setTexts(){
        logOffBtn.setTitle(NSLocalizedString(Constants.LocalizedStrings.logOff, comment: "log off system"), for: .normal)
        copyrightLabel.text = NSLocalizedString(Constants.LocalizedStrings.copyright, comment: "copyright text")
    }
    
    private func addSubViews(){
        view.addSubview(formStackView)
        formStackView.addArrangedSubview(swiftPayLogoImage)
        formStackView.addArrangedSubview(copyrightLabel)
        formStackView.addArrangedSubview(emptyView)
        formStackView.addArrangedSubview(logOffBtn)
    }
    
    private func setUpLayout(){
        //Logo image on top
        swiftPayLogoImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        swiftPayLogoImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        //Stack anchors
        formStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        formStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        formStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        formStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        //Other elements have same height
        logOffBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logOffBtn.leftAnchor.constraint(equalTo: formStackView.leftAnchor).isActive = true
        logOffBtn.rightAnchor.constraint(equalTo: formStackView.rightAnchor).isActive = true
        emptyView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setButtonsResponders(){
        logOffBtn.addTarget(self, action: #selector(logOffBtnTapped), for: .touchUpInside)
    }
    
    @objc func logOffBtnTapped(sender: UIButton!){
//        signInPresenter.SignIn();
    }
    
    private func styleVisualElements()
    {
        view.backgroundColor = .white
        Utilities.styleFilledButton(logOffBtn)
    }
}