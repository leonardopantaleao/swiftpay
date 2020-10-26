//
//  FirebaseClientProtocol.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 01/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

protocol ClientProtocol {
    func signIn(_ email: String?, _ password: String?, completionHandler: @escaping (Result<String, ValidationError>) -> ())
    func signUp(_ name: String?, _ lastName: String?, _ email: String?, _ password: String?, completionHandler: @escaping (Result<String, ValidationError>) -> ())
    func createUserOnDB(_ name: String?, _ lastName: String?, _ email: String?, completionHandler:  @escaping (Result<String, ValidationError>) -> ())
    func getUserInfo(_ email: String?, completionHandler: @escaping (Result<String, ValidationError>) -> ())
    func performTransaction(_ senderEmail: String?, _ receiverEmail: String?, _ amount: Double?, _ transactionType: String?, _ transactionDate: TimeInterval?, completionHandler: @escaping (Result<String, ValidationError>) -> ())
    func saveResultOnUserDefaults(_ result: String, _ key: String)
    var responseHandler: ResponseHandler { get set }
}
