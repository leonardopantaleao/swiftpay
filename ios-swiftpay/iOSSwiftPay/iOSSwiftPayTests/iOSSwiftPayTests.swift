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
        sut = ViewController()
    }
    
    override func tearDown(){
        super.tearDown()
        sut = nil
    }
    
    func testBackgroundColor(){
        FBSnapshotVerifyView(sut.view)
    }

}
