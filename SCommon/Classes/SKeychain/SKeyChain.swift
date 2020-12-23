//
//  SKeyChain.swift
//  SBase
//
//  Created by Thanh Sang on 6/2/20.
//  Copyright © 2020 FLYG. All rights reserved.
//

import Foundation
import Security

/// This class wrapper save data to keychain stored.
struct SKeyChain {
    
    /// This struct contain all keys for Keychain.
    /// Need add new key in this struct to use.
    struct Keys {
        /// prevent init for this Keys
        private init() { }
    }

    /// Function save data to keychain with 'key'
    /// - Parameters:
    ///   - key: key of data to save in keychain.
    ///   - data: data for save.
    @discardableResult
    static func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]
        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil)
    }

    /// Function load data saved from keychain.
    /// - Parameter key: key to load data.
    static func load(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == noErr {
            return dataTypeRef as? Data
        } else {
            return nil
        }
    }

    /// Function create UUID ifneed.
    static func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)
        let swiftString: String = cfStr as String
        return swiftString
    }
    
    /// prevent init for this class
    private init() { }
}
