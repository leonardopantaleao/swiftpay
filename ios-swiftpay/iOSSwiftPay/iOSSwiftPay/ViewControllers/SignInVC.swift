//
//  SignInVC.swift
//  
//
//  Created by Leonardo on 10/09/20.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var emailTxField: UITextField!
    @IBOutlet weak var passwordTxField: UITextField!
    @IBOutlet weak var errorStatusLabel: UILabel!
    @IBOutlet weak var SignInBtn: UIButton!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var createAccountBtn: UIButton!
    
    private let validation: ValidationService
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlaceholders()
        styleVisualElements()
        copyrightLabel.text = NSLocalizedString("copyright", comment: "development info")
        
        errorStatusLabel.alpha = 0
    }
    
    @IBAction func SignInBtnTapped(_ sender: Any) {
        errorStatusLabel.alpha = 0
        do{
            guard let email = try? validation.validateEmail(emailTxField.text) else { throw ValidationError.emailNotValid }
            guard let password = try? validation.validatePassword(passwordTxField.text) else { throw ValidationError.passwordNotValid }
        } catch
        {
            errorStatusLabel.alpha = 1
            errorStatusLabel.text = error.localizedDescription
        }
            
    }
    
    init(validation: ValidationService) {
        self.validation = validation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.validation = ValidationService()
        super.init(coder: coder)
    }
    
    func styleVisualElements()
    {
        Utilities.styleTextField(emailTxField)
        Utilities.styleTextField(passwordTxField)
        Utilities.styleFilledButton(createAccountBtn)
        Utilities.styleHollowButton(SignInBtn)
    }
    
    func setPlaceholders()
    {
        passwordTxField.placeholder = NSLocalizedString("passwordPlaceholder", comment: "insert password placeholder")
        SignInBtn.setTitle(NSLocalizedString("signInBtnText", comment: "sign in button text"), for: UIControl.State.normal)
        createAccountBtn.setTitle(NSLocalizedString("createAccountBtnText", comment: "create account button text"), for: UIControl.State.normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
