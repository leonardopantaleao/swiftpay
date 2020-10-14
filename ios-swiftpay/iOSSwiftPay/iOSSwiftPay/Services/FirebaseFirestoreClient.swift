//
//  FirebaseClient.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 01/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation
import Firebase

final class FirebaseFirestoreClient : ClientProtocol{
    func handleResponse(_ result: String?, _ error: NSError?) -> Result<String, ValidationError> {
        if error != nil {
            let code = (error! as NSError).code
            if code == 17011 { completionHandler(.failure(ValidationError.noUserFound))  }
            if code == 17009 { completionHandler(.failure(ValidationError.wrongPassword)) }
            if code == 17020 { completionHandler(.failure(ValidationError.noConnection)) }
            completionHandler(.failure(ValidationError.unknownError))
        }
        if result != nil {
            let email = (result)!.user.email
            completionHandler(.success(email!))
        }
    }
    
    func signIn(_ email: String?, _ password: String?, completionHandler: @escaping (Result<String?, ValidationError>) -> ()) {
        Auth.auth().signIn(withEmail: email!, password: password!, completion: { (result, error) in
            self.handleResponse(result?.user.email ?? "", ((error? ?? nil) as NSError ?? nil))
        })
    }
    
    init() {}
    func signIn(_ email: String?, _ password: String?, completionHandler: @escaping (Result<String, ValidationError>) -> ()) {
        
        Auth.auth().signIn(withEmail: email!, password: password!, completion: { (result, error) in
            if error != nil {
                let code = (error! as NSError).code
                if code == 17011 { completionHandler(.failure(ValidationError.noUserFound))  }
                if code == 17009 { completionHandler(.failure(ValidationError.wrongPassword)) }
                if code == 17020 { completionHandler(.failure(ValidationError.noConnection)) }
                completionHandler(.failure(ValidationError.unknownError))
            }
            if result != nil {
                //                let uid = (result)!.user.uid
                let email = (result)!.user.email
                completionHandler(.success(email!))
            }
        })
    }
    
    func handleResponse(_ result: String?, _ error: NSError?) -> Result<String?, ValidationError> {
        if error != nil {
            let code = (error! as NSError).code
            if code == 17011 { completionHandler(.failure(ValidationError.noUserFound))  }
            if code == 17009 { completionHandler(.failure(ValidationError.wrongPassword)) }
            if code == 17020 { completionHandler(.failure(ValidationError.noConnection)) }
            completionHandler(.failure(ValidationError.unknownError))
        }
        if result != nil {
            let email = (result)!.user.email
            completionHandler(.success(email!))
        }
    }
    
//    Auth.auth().signIn(withEmail: email!, password: password!, completion: { (result, error) in
//        if error != nil {
//            let code = (error! as NSError).code
//            if code == 17011 { completionHandler(.failure(ValidationError.noUserFound))  }
//            if code == 17009 { completionHandler(.failure(ValidationError.wrongPassword)) }
//            if code == 17020 { completionHandler(.failure(ValidationError.noConnection)) }
//            completionHandler(.failure(ValidationError.unknownError))
//        }
//        if result != nil {
//            //                let uid = (result)!.user.uid
//            let email = (result)!.user.email
//            completionHandler(.success(email!))
//        }
//    })
}
