//
//  ACSQLiteString.swift
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

/**

 FOUNDATION_EXTERN void *ACSQLiteCStringCreateWithNSString(NSString *nsString);

 FOUNDATION_EXTERN NSString *ACSQLiteNSStringCreateWithCString(const void *cString);

 FOUNDATION_EXTERN NSMutableString *ACSQLiteNSMutableStringCreateWithCString(const void *cString);
 */
func testFunc() {
    // sqlite3_bind_text
//    sqlite3_bind_text(<#T##OpaquePointer!#>, <#T##Int32#>, <#T##UnsafePointer<Int8>!#>, <#T##Int32#>, <#T##((UnsafeMutableRawPointer?) -> Void)!##((UnsafeMutableRawPointer?) -> Void)!##(UnsafeMutableRawPointer?) -> Void#>)
    // sqlite3_bind_parameter_index
//    sqlite3_bind_parameter_index(<#T##OpaquePointer!#>, <#T##zName: UnsafePointer<Int8>!##UnsafePointer<Int8>!#>)
    // sqlite3_open_v2
//    sqlite3_open_v2(<#T##filename: UnsafePointer<Int8>!##UnsafePointer<Int8>!#>, <#T##ppDb: UnsafeMutablePointer<OpaquePointer?>!##UnsafeMutablePointer<OpaquePointer?>!#>, <#T##flags: Int32##Int32#>, <#T##zVfs: UnsafePointer<Int8>!##UnsafePointer<Int8>!#>)
    //sqlite3_prepare_v2
    
    //let code = sqlite3_prepare_v3(database.sqliteConnection, statementStart, -1, UInt32(bitPattern: prepFlags), &sqliteStatement, statementEnd)

    // TODO: use sqlite3_prepare_v3 if #available(iOS 12.0, OSX 10.14, watchOS 5.0, *)
    //let code = sqlite3_prepare_v2(database.sqliteConnection, statementStart, -1, &sqliteStatement, statementEnd)
    
    let dbPath = ""
    var sqliteStatement: OpaquePointer? = nil
    let code = sqlite3_open(dbPath, &sqliteStatement)
    
    if code == SQLITE_OK {
        
    }
    
//    let sqliteStatement = OpaquePointer
    //sqlite3_prepare_v2(<#T##db: OpaquePointer!##OpaquePointer!#>, <#T##zSql: UnsafePointer<Int8>!##UnsafePointer<Int8>!#>, <#T##nByte: Int32##Int32#>, <#T##ppStmt: UnsafeMutablePointer<OpaquePointer?>!##UnsafeMutablePointer<OpaquePointer?>!#>, <#T##pzTail: UnsafeMutablePointer<UnsafePointer<Int8>?>!##UnsafeMutablePointer<UnsafePointer<Int8>?>!#>)
}
