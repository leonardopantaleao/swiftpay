//
//  SettingsPageTests.swift
//  iOSSwiftPayTests
//
//  Created by Leonardo on 30/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

@testable import SwiftPay
import XCTest
import Mockingbird
import Firebase

class SettingsPageTests: XCTestCase {
    var presenter: SettingsPresenter!
    var viewDelegate: SettingsViewDelegateMock!
    var userDefaults: UserDefaultsProtocolMock!
    
    override func setUp() {
        userDefaults = mock(UserDefaultsProtocol.self)
        viewDelegate = mock(SettingsViewDelegate.self)
        presenter = SettingsPresenter(viewDelegate: viewDelegate, userDefaults: userDefaults)
        super.setUp()
    }
    
    func testLogOff() {
        given(viewDelegate.logOffApp()).willReturn()
        given(userDefaults.disposeUserDefaults()).willReturn()
        presenter.logOff()
        verify(viewDelegate.logOffApp()).wasCalled()
        verify(userDefaults.disposeUserDefaults()).wasCalled()
    }

}
