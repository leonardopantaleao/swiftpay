//
//  UserLogin.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 18/09/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation
import Firebase

struct UserLogin
{
    func signUp(_ emailTyped : String?, _ passwordTyped : String?, _ validation: ValidationService, completionHandler: @escaping (String) -> ()) throws {
        var uid: String = ""
        var code: Int = 0
        guard let email = try? validation.validateEmail(emailTyped) else { throw ValidationError.emailNotValid }
        guard let password = try? validation.validatePassword(passwordTyped) else { throw ValidationError.passwordNotValid }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (result, error) in
            if error != nil { code = (error! as NSError).code }
            if result != nil { uid = (result)!.user.uid }
            completionHandler(uid)
        })
        if code == 17011 { throw ValidationError.firebaseNoUserFound }
        if code == 17009 { throw ValidationError.firebaseWrongPassword }
        if code == 17020 { throw ValidationError.firebaseNoConnection }
    }
    
    func signUpFunc(_ email : String?, _ password : String?, _ validation: ValidationService) throws{
//            var uid: String = ""
            var code: Int = 0
            guard let email = try? validation.validateEmail(email) else { throw ValidationError.emailNotValid }
            guard let password = try? validation.validatePassword(password) else { throw ValidationError.passwordNotValid }
            
            Auth.auth().signIn(withEmail: email, password: password, completion: { (result, error) in
                //            firebaseLoginDidFinish(result, error)
    //            do{
    //                try? self.firebaseLoginDidFinish(error as NSError?, result as AuthDataResult?)
    //            }
    //            catch{
    //
    //            }
                if error != nil {
                    code = (error! as NSError).code
                }
//                uid = (result! as AuthDataResult).user.uid
            })
            if code == 17011 { throw ValidationError.firebaseNoUserFound }
            if code == 17009 { throw ValidationError.firebaseWrongPassword }
            if code == 17020 { throw ValidationError.firebaseNoConnection }
        }
    
    func firebaseLoginDidFinish(_ error: NSError?, _ result: AuthDataResult?) throws -> String?
    {
        if error != nil {
            if error!.code == 17011 { throw ValidationError.firebaseNoUserFound }
            if error!.code == 17009 { throw ValidationError.firebaseWrongPassword }
            if error!.code == 17020 { throw ValidationError.firebaseNoConnection }
        }
        return result?.user.uid
    }
}

