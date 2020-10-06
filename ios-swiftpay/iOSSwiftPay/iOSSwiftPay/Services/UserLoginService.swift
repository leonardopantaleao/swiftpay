//
//  UserLogin.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 18/09/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation
import Firebase

struct UserLoginService
{
    func signUp(_ email: String?, _ password: String?, completionHandler: @escaping (Result<String, ValidationError>) -> ()) {
        let validationService = ValidationService()
        
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
    
    func createUserOnFirebase(_ email: String?, _ password: String?, completionHandler: @escaping (Result<User, Error>) -> ()){
        Auth.auth().createUser(withEmail: email!, password: password!) { authResult, error in
            if error != nil{
                completionHandler(.failure(error!))
            }
            if authResult != nil{
                completionHandler(.success(authResult!.user))
            }
        }
    }
    
    func createUserOnDB(_ name: String?, _ lastName: String?, _ dateOfBirth: TimeInterval?, _ email: String?, _ uid: String?, completionHandler: @escaping (Result<String, Error>) -> ()){
        let client = Client(name: name!, lastName: lastName!, dateOfBirth: dateOfBirth!, email: email!, uid: uid!)
        let url = URL(string: "http://localhost:8080/add")!
        
        let encoder = JSONEncoder()
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? encoder.encode(client)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                
                if let client = try? decoder.decode(Client.self, from: data) {
                    completionHandler(.success(client.uid))
                } else {
                    completionHandler(.failure(error!))
                }
            }
        }.resume()
    }
    
    
//    func createUserOnDB(_ name: String?, _ lastName: String?, _ dateOfBirth: TimeInterval?, _ email: String?, _ uid: String?, completionHandler: @escaping (Result<String, Error>) -> ()){
//        let url = URL(string: "http://localhost:8080/client/" + uid!)!
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                let decoder = JSONDecoder()
//
//                if let client = try? decoder.decode(Client.self, from: data) {
//                    completionHandler(.success(client.uid))
//                } else {
//                    completionHandler(.failure(error!))
//                }
//            }
//        }.resume()
//    }
}

