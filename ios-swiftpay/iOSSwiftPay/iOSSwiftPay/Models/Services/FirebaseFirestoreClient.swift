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
    var responseHandler: ResponseHandler = ResponseHandler()
    
    init() {}
    
    func signIn(_ email: String?, _ password: String?, completionHandler: @escaping (Result<String, ValidationError>) -> ()) {
        
        Auth.auth().signIn(withEmail: email!, password: password!, completion: { (result, error) in
            if error != nil {
                let code = (error! as NSError).code
                completionHandler(.failure(self.responseHandler.handleError(code)))
            }
            if result != nil {
                let email = (result)!.user.email
                completionHandler(.success(email!))
            }
        })
    }
    
}
