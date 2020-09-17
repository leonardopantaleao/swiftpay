//
//  SignInVC.swift
//  
//
//  Created by Leonardo on 10/09/20.
//

import UIKit
import Firebase

class SignInVC: UIViewController {

    @IBOutlet weak var emailTxField: UITextField!
    @IBOutlet weak var passwordTxField: UITextField!
    @IBOutlet weak var errorStatusLabel: UILabel!
    @IBOutlet weak var SignInBtn: UIButton!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var signInActivityIndicator: UIActivityIndicatorView!
    
    private let validation: ValidationService
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlaceholders()
        styleVisualElements()
        copyrightLabel.text = NSLocalizedString("copyright", comment: "development info")
        
        errorStatusLabel.alpha = 0
    }
    
    func toggleActivityIndicator(_ show: Bool) {
        signInActivityIndicator.alpha = show ?  1 : 0
        if(show){
            signInActivityIndicator.startAnimating()
        }
        else{
            signInActivityIndicator.stopAnimating()
        }

    }
    
    @IBAction func SignInBtnTapped(_ sender: Any) {
        toggleActivityIndicator(true)
        errorStatusLabel.alpha = 0
        self.errorStatusLabel.textColor = .red
        do{
            guard let email = try? validation.validateEmail(emailTxField.text) else { throw ValidationError.emailNotValid }
            guard let password = try? validation.validatePassword(passwordTxField.text) else { throw ValidationError.passwordNotValid }
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                        
                        if error != nil {
//                            self.errorStatusLabel.text = error!.localizedDescription
                            self.errorStatusLabel.alpha = 1
                            do
                            {
                                if((error! as NSError).code == 17011) { throw ValidationError.firebaseNoUserFound }
                                if((error! as NSError).code == 17009) { throw ValidationError.firebaseWrongPassword }
                                if((error! as NSError).code == 17020) { throw ValidationError.firebaseNoConnection }
                            } catch
                            {
                                self.toggleActivityIndicator(false)
                                self.errorStatusLabel.alpha = 1
                                self.errorStatusLabel.text = error.localizedDescription
                            }
                            
                        }
                        else {
                            
            //                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
            //
            //                self.view.window?.rootViewController = homeViewController
            //                self.view.window?.makeKeyAndVisible()
                            //navegar para tela inicial
                            self.errorStatusLabel.textColor = .green
                            self.errorStatusLabel.alpha = 1
                            self.errorStatusLabel.text = "Logou!"
                        }
                        self.toggleActivityIndicator(false)
                    }
        } catch
        {
            toggleActivityIndicator(false)
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
