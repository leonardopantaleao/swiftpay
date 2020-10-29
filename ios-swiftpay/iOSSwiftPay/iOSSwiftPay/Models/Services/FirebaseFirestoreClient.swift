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
    
    func performTransaction(_ senderEmail: String?, _ receiverEmail: String?, _ amount: Double?, _ transactionType: String?, _ transactionDate: TimeInterval?, completionHandler: @escaping (Result<String, ValidationError>) -> ()) {
        let db = Firestore.firestore()
        db.collection(Constants.DataBaseConstants.transactionsDocument).addDocument(data: ["senderId": senderEmail!, "receiverId": receiverEmail!, "amount": amount!, "transactionType": transactionType!, "transactionDate": transactionDate!], completion: { error in
            if error != nil {
                let code = (error! as NSError).code
                completionHandler(.failure(self.responseHandler.handleError(code)))
            }
            else{
                completionHandler(.success(senderEmail!))
            }
        })
    }
    
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
    
    func getTransactionsBalance(_ email: String?, completionHandler: @escaping (Result<Double, ValidationError>) -> ()) {
        let db = Firestore.firestore()
        var totalTransfersReceived: Double = 0
        var totalTransafersMade: Double = 0
        var transactions = [MoneyTransaction]()
        db.collection(Constants.DataBaseConstants.transactionsDocument).whereField(Constants.DataBaseConstants.senderIdField, isEqualTo: email!)
            .getDocuments() { (querySnapshot, error) in
                if let error = error {
                    let code = (error as NSError).code
                    completionHandler(.failure(self.responseHandler.handleError(code)))
                } else {
                    let documents = querySnapshot!.documents
                    documents.forEach { document in
                        let transaction = MoneyTransaction(senderId: document["senderId"] as! String, receiverId: document["receiverId"] as! String, amount: document["amount"] as! Double, transactionDate: document["transactionDate"] as! TimeInterval, type: document["transactionType"] as! String)
                        transactions.append(transaction)
                        let amount = document["amount"] as! Double
                        if(document["transactionType"] as! String == "deposit"){
                            totalTransfersReceived += amount
                        }else{
                            totalTransafersMade += amount
                        }
                    }
                    let encoder = JSONEncoder()
                    transactions.sort {
                        $0.transactionDate > $1.transactionDate
                    }
                    let data = try? encoder.encode(transactions)
                    let json = String(data: data!, encoding: .utf8)
                    self.saveResultOnUserDefaults(json!, Constants.UserDefaultsKeys.transactions)
                    let totalAmount = totalTransfersReceived - totalTransafersMade
                    
                    completionHandler(.success(totalAmount))
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
