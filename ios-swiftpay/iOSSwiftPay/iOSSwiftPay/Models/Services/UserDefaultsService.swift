//
//  UserDefaultsService.swift
//  iOSSwiftPay
//
//  Created by Leonardo on 21/10/20.
//  Copyright © 2020 Leonardo. All rights reserved.
//

import Foundation

protocol UserDefaultsProtocol {
    func saveStringOnUserDefaults(_ value: String, _ key: String)
    func getStringOnUserDefaults(_ key: String) -> String
}

struct UserDefaultsService: UserDefaultsProtocol{
    func saveStringOnUserDefaults(_ value: String, _ key: String){
        UserDefaults.standard.set(value, forKey: key)
    }

    func getStringOnUserDefaults(_ key: String) -> String {
        return UserDefaults.standard.value(forKey: key) as! String
    }
}

protocol ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}

enum ObjectSavableError: LocalizedError {
    case unableToEncode
    case noValue
    case unableToDecode
    
    var errorDescription: String? {
        switch self{
        case .unableToEncode:
            return NSLocalizedString(Constants.LocalizedStrings.unableToEncode, comment: "error description string")
        case .noValue:
            return NSLocalizedString(Constants.LocalizedStrings.noValue, comment: "error description string")
        case .unableToDecode:
            return NSLocalizedString(Constants.LocalizedStrings.unableToDecode, comment: "error description string")
        }
    }
}

extension UserDefaults: ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}
