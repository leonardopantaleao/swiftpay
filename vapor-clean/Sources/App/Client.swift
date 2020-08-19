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
    var cpf: String
}
