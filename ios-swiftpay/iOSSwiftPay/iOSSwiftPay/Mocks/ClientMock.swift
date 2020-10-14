//
//  FirebaseClientMock.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 02/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

final class ClientMock : ClientProtocol{
    init() {}
    func signIn(_ email: String?, _ password: String?, completionHandler: @escaping (Result<String, ValidationError>) -> ()) {
        let existingEmail = "panta@test.com"
        let correctPassword = "funciona01#"
        let expectedUid = "xbgUvnvbb1P4CGdTaRS240S8IjU2"
        
        if email != existingEmail { completionHandler(.failure(ValidationError.noUserFound)) }
        if password != correctPassword { completionHandler(.failure(ValidationError.wrongPassword)) }
        
        completionHandler(.success(expectedUid))
    }
}
