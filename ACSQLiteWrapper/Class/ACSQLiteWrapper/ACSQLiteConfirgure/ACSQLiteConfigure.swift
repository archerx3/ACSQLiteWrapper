//
//  ACSQLiteConfigure.swift
//  ACSQLiteWrapper
//
//  Created by archer.chen on 10/11/19.
//  Copyright © 2019 AC. All rights reserved.
//

import Foundation

#if SQLITE_SWIFT_STANDALONE
import sqlite3
#elseif SQLITE_SWIFT_SQLCIPHER
import SQLCipher
#elseif os(Linux)
import CSQLite
#else
import SQLite3
#endif

public func ACSQLiteDataTypeIsValid(dataType: ACSQLiteDataType) -> Bool {
    var isValid = false
    if dataType == ACSQLiteDataType.integer ||
        dataType == ACSQLiteDataType.double ||
        dataType == ACSQLiteDataType.string ||
        dataType == ACSQLiteDataType.data ||
        dataType == ACSQLiteDataType.null {
        isValid = true
    }
    
    return isValid
}

struct ACSQLiteDataType: Equatable {
    public let rawValue: Int

    public init(_ rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public init(_ rawValue: Int32) {
        self.rawValue = Int(rawValue)
    }
    
    public static let integer = ACSQLiteDataType(SQLITE_INTEGER)   // SQLITE_INTEGER
    public static let double  = ACSQLiteDataType(SQLITE_FLOAT)     // SQLITE_FLOAT
    public static let string  = ACSQLiteDataType(SQLITE_TEXT)      // SQLITE_TEXT
    public static let data    = ACSQLiteDataType(SQLITE_BLOB)      // SQLITE_BLOB
    public static let null    = ACSQLiteDataType(SQLITE_NULL)      // SQLITE_NULL
    
    public static func == (lhs: ACSQLiteDataType, rhs: ACSQLiteDataType) -> Bool {
        let isEqual: Bool = (lhs.rawValue == rhs.rawValue)
        
        return isEqual
    }
}

struct ACSQLiteLibraryThreadsafeMode: Equatable
{
    public let rawValue: Int
    
    // MARK: Threadsafe Modes
    
    public static let singleThread = ACSQLiteLibraryThreadsafeMode(0)
    public static let multiThread  = ACSQLiteLibraryThreadsafeMode(1)
    public static let serialized   = ACSQLiteLibraryThreadsafeMode(2)
    
    // MARK: Initializers
    
    public init(_ rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public init(_ rawValue: Int32) {
        self.rawValue = Int(rawValue)
    }
    
    // MARK: Equatable
    
    public static func == (lhs: ACSQLiteLibraryThreadsafeMode, rhs: ACSQLiteLibraryThreadsafeMode) -> Bool {
        let isEqual: Bool = (lhs.rawValue == rhs.rawValue)
        
        return isEqual
    }
}
