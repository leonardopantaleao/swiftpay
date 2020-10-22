//
//  MoneyTransaction.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 07/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

struct MoneyTransaction: Codable{
    var senderId: String
    var receiverId: String
    var amount: Double
    var transactionDate: TimeInterval
    var type: String
}
