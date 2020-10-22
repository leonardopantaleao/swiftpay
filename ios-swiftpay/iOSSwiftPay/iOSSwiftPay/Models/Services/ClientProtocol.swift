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
    func getUserInfo(_ email: String?, completionHandler: @escaping (Result<Client, Error>) -> ())
    var responseHandler: ResponseHandler { get set }
}
