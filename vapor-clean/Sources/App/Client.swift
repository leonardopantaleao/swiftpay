//
//  File.swift
//  
//
//  Created by Leonardo on 16/08/20.
//
import FluentSQLite
import Foundation
import Vapor

struct Client: Content, SQLiteModel, Migration {
    var id: Int?
    var name: String
    var lastName: String
    var dateOfBirth: Date
    var email: String
    var uid: String
}
