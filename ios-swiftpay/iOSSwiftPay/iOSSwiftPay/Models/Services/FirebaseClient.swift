//
//  FirebaseClient.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 01/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation
import Firebase

final class DatabaseClient : DatabaseClientProtocol{
    init() {}
    func signIn(_ email: String?, _ password: String?, completionHandler: @escaping (Result<String, ValidationError>) -> ()) {
        
        Auth.auth().signIn(withEmail: email!, password: password!, completion: { (result, error) in
            if error != nil {
                let code = (error! as NSError).code
                if code == 17011 { completionHandler(.failure(ValidationError.firebaseNoUserFound))  }
                if code == 17009 { completionHandler(.failure(ValidationError.firebaseWrongPassword)) }
                if code == 17020 { completionHandler(.failure(ValidationError.firebaseNoConnection)) }
            }
            if result != nil {
                let uid = (result)!.user.uid
                completionHandler(.success(uid))
            }
        })
    }
}
