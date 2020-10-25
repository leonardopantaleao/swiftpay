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
    func saveResultOnUserDefaults(_ result: String, _ key: String) {
        let userDefaults = UserDefaultsService()
        userDefaults.saveStringOnUserDefaults(result, key)
    }
    
    func createUserOnDB(_ name: String?, _ lastName: String?, _ email: String?, completionHandler: @escaping (Result<String, ValidationError>) -> ()) {
        let db = Firestore.firestore()
        db.collection(Constants.DataBaseConstants.usersDocument).addDocument(data: [ "email": email!, "name": name!, "lastName": lastName!], completion: { error in
            if error != nil {
                let code = (error! as NSError).code
                completionHandler(.failure(self.responseHandler.handleError(code)))
            }
            else{
                completionHandler(.success(email!))
            }
        })
    }
    
    func getUserInfo(_ email: String?, completionHandler: @escaping (Result<String, ValidationError>) -> ()) {
        let db = Firestore.firestore()
        db.collection(Constants.DataBaseConstants.usersDocument).whereField(Constants.DataBaseConstants.emailField, isEqualTo: email!)
            .getDocuments() { (querySnapshot, error) in
                if let error = error {
                    let code = (error as NSError).code
                    completionHandler(.failure(self.responseHandler.handleError(code)))
                } else {
                    let document = querySnapshot!.documents[0]
                    let userName = document["name"] as! String
                    let userLastName = document["lastName"] as! String
                    let userEmail = document["email"] as! String
                    self.saveResultOnUserDefaults(userName, Constants.UserDefaultsKeys.userName)
                    self.saveResultOnUserDefaults(userLastName, Constants.UserDefaultsKeys.userLastName)
                    completionHandler(.success(userEmail))
                }
        }
    }
    
    func signUp(_ name: String?, _ lastName: String?, _ email: String?, _ password: String?, completionHandler: @escaping (Result<String, ValidationError>) -> ()) {
        Auth.auth().createUser(withEmail: email!, password: password!, completion: { (result, error) in
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
