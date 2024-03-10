//
//  UserDefaultsManager.swift
//  Linkwarden
//
//  Created by Abilash S on 10/03/24.
//

import Foundation

class UserDefaultsManager {
    
    static var shared = UserDefaults.standard
    
    static func getBool(forKey key: String) -> Bool {
        return shared.bool(forKey: key)
    }
    
    static func getString(forKey key: String) -> String? {
        return shared.string(forKey: key)
    }
    
    static func getValue(forKey key: String) -> Any? {
        return shared.object(forKey: key)
    }
    
    static func setBool(value: Bool, forKey key: String) {
        shared.set(value, forKey: key)
    }
    
    static func setObject(value: Any?, forKey key: String) {
        shared.set(value, forKey: key)
    }
    
    static func removeObject(forKey key: String) {
        shared.removeObject(forKey: key)
    }
    
}

@propertyWrapper
struct UserDefault<T> {
    let key: String
    
    init(_ key: String) {
        self.key = key
    }
    
    var wrappedValue: T? {
        get {
            return UserDefaultsManager.shared.object(forKey: key) as? T
        }
        set {
            UserDefaultsManager.shared.setValue(newValue, forKey: key)
        }
    }
}
