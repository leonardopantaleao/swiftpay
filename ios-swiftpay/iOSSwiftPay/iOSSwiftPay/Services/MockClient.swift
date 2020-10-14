//
//  MockClient.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 09/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

final class MockClient: ClientProtocol{
    public var delay : Int = 2
    
    func signIn(_ email: String?, _ password: String?, completionHandler: @escaping (Result<String, ValidationError>) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(self.delay)) {
            let expectedUserEmail = "leo@email.com"
            let expectedPassword = "password01#"
            
            if email != expectedUserEmail { completionHandler(.failure(ValidationError.noUserFound))  }
            if password != expectedPassword { completionHandler(.failure(ValidationError.wrongPassword)) }
            if self.delay > 2 { completionHandler(.failure(ValidationError.noConnection)) }
            completionHandler(.success(expectedUserEmail))
        }
    }
    
//        func fetchMovies(completion: @escaping (Bool, FilmsData?) -> Void) {
//            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(MockClient.delay)) {
//                let filePath = "user"
//                MockClient.loadJsonDataFromFile(filePath, completion: { data in
//                    if let json = data {
//                        do {
//                            let estimate = try JSONDecoder().decode(FilmsData.self, from: json)
//                            completion(true, estimate)
//                        }
//                        catch _ as NSError {
//                            fatalError("Couldn't load data from \(filePath)")
//                        }
//                    }
//                })
//            }
//        }
    //
    //    private static func loadJsonDataFromFile(_ path: String, completion: (Data?) -> Void) {
    //        if let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") {
    //            do {
    //                let data = try Data(contentsOf: fileUrl, options: [])
    //                completion(data as Data)
    //            } catch (let error) {
    //                print(error.localizedDescription)
    //                completion(nil)
    //            }
    //        }
    //    }
}
