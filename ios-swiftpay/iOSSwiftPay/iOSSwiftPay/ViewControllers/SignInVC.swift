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
    @IBOutlet weak var createAccountBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTxField.placeholder = NSLocalizedString("passwordPlaceholder", comment: "insert password placeholder")
        SignInBtn.setTitle(NSLocalizedString("signInBtnText", comment: "sign in button text"), for: UIControl.State.normal)
        createAccountBtn.setTitle(NSLocalizedString("createAccountBtnText", comment: "create account button text"), for: UIControl.State.normal)
        
        errorStatusLabel.alpha = 0
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
