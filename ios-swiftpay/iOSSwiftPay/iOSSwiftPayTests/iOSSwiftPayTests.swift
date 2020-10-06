//
//  iOSSwiftPayTests.swift
//  iOSSwiftPayTests
//
//  Created by Leonardo on 17/08/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
@testable import iOSSwiftPay

class iOSSwiftPayTests: FBSnapshotTestCase {
    
    var sut: UIViewController!
    
    override func setUp(){
        super.setUp()
        let firebaseClient = FirebaseFirestoreClient()
        sut = SignInViewController(firebaseClient: firebaseClient)
        recordMode = false
    }
    
    override func tearDown(){
        super.tearDown()
        sut = nil
    }
    
    func testViewController(){
        FBSnapshotVerifyViewController(sut)
    }

}
