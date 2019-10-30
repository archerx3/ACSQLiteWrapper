//
//  ACSQLiteConstValue.swift
//  ACSQLiteWrapper
//
//  Created by archer.chen on 10/15/19.
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

private func textAPI() {
    if let cstring = "sdfdf".cString(using: .utf8) {
        let cStrPoint = withUnsafePointer(to: cstring, { $0 })
//        CFString()
        
        let string = "path"
        let stringPoint = withUnsafePointer(to: string, { $0 })
        var dbOpoint: OpaquePointer? = nil
        var vfileSystem: String? = nil
        sqlite3_open_v2(string, &dbOpoint, 1, vfileSystem)
    }
}
