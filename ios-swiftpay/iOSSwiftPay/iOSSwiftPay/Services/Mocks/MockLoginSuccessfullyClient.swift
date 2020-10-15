//
//  MockLoginSuccessfullyClient.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 15/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

final class MockLoginSuccessfullyClient: ClientProtocol{
    var responseHandler: ResponseHandler = ResponseHandler()
    func signIn(_ email: String?, _ password: String?, completionHandler: @escaping (Result<String, ValidationError>) -> ()) {
        completionHandler(.success("test@email.com"))
    }
}
