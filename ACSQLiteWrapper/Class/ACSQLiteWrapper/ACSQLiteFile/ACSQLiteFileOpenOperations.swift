//
//  ACSQLiteFileOpenOperations.swift
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

struct ACSQLiteFileOpenOptions: OptionSet {
    public let rawValue: Int
    
    // MARK: Flags for File Open Operations
    
    public static let readonly                                           = ACSQLiteFileOpenOptions(rawValue: 0x00000001) // SQLITE_OPEN_READONLY         0x00000001  /* Ok for sqlite3_open_v2() */
    public static let readWrite                                          = ACSQLiteFileOpenOptions(rawValue: 0x00000002) // SQLITE_OPEN_READWRITE        0x00000002  /* Ok for sqlite3_open_v2() */
    public static let create                                             = ACSQLiteFileOpenOptions(rawValue: 0x00000004) // SQLITE_OPEN_CREATE           0x00000004  /* Ok for sqlite3_open_v2() */
    
    public static let deleteOnClose                                      = ACSQLiteFileOpenOptions(rawValue: 0x00000008) // SQLITE_OPEN_DELETEONCLOSE    0x00000008  /* VFS only */
    public static let exclusive                                          = ACSQLiteFileOpenOptions(rawValue: 0x00000010) // SQLITE_OPEN_EXCLUSIVE        0x00000010  /* VFS only */
    public static let autoProxy                                          = ACSQLiteFileOpenOptions(rawValue: 0x00000020) // SQLITE_OPEN_AUTOPROXY        0x00000020  /* VFS only */
    
    public static let uri                                                = ACSQLiteFileOpenOptions(rawValue: 0x00000040) // SQLITE_OPEN_URI              0x00000040  /* Ok for sqlite3_open_v2() */
    public static let memory                                             = ACSQLiteFileOpenOptions(rawValue: 0x00000080) // SQLITE_OPEN_MEMORY           0x00000080  /* Ok for sqlite3_open_v2() */
    
    public static let mainDatabase                                       = ACSQLiteFileOpenOptions(rawValue: 0x00000100) // SQLITE_OPEN_MAIN_DB          0x00000100  /* VFS only */
    public static let temporaryDatabase                                  = ACSQLiteFileOpenOptions(rawValue: 0x00000200) // SQLITE_OPEN_TEMP_DB          0x00000200  /* VFS only */
    public static let transientDatabase                                  = ACSQLiteFileOpenOptions(rawValue: 0x00000400) // SQLITE_OPEN_TRANSIENT_DB     0x00000400  /* VFS only */
    public static let mainJournal                                        = ACSQLiteFileOpenOptions(rawValue: 0x00000800) // SQLITE_OPEN_MAIN_JOURNAL     0x00000800  /* VFS only */
    public static let journal                                            = ACSQLiteFileOpenOptions(rawValue: 0x00001000) // SQLITE_OPEN_TEMP_JOURNAL     0x00001000  /* VFS only */
    public static let subJournal                                         = ACSQLiteFileOpenOptions(rawValue: 0x00002000) // SQLITE_OPEN_SUBJOURNAL       0x00002000  /* VFS only */
    public static let masterJournal                                      = ACSQLiteFileOpenOptions(rawValue: 0x00004000) // SQLITE_OPEN_MASTER_JOURNAL   0x00004000  /* VFS only */
    
    public static let noMutex                                            = ACSQLiteFileOpenOptions(rawValue: 0x00008000) // SQLITE_OPEN_NOMUTEX          0x00008000  /* Ok for sqlite3_open_v2() */
    public static let fullMutex                                          = ACSQLiteFileOpenOptions(rawValue: 0x00010000) // SQLITE_OPEN_FULLMUTEX        0x00010000  /* Ok for sqlite3_open_v2() */
    public static let sharedCache                                        = ACSQLiteFileOpenOptions(rawValue: 0x00020000) // SQLITE_OPEN_SHAREDCACHE      0x00020000  /* Ok for sqlite3_open_v2() */
    public static let privateCache                                       = ACSQLiteFileOpenOptions(rawValue: 0x00040000) // SQLITE_OPEN_PRIVATECACHE     0x00040000  /* Ok for sqlite3_open_v2() */
    
    public static let wal                                                = ACSQLiteFileOpenOptions(rawValue: 0x00080000) // SQLITE_OPEN_WAL              0x00080000  /* VFS only */
    
    public static let fileProtectionComplete                             = ACSQLiteFileOpenOptions(rawValue: 0x00100000) // SQLITE_OPEN_FILEPROTECTION_COMPLETE                             0x00100000
    public static let fileProtectionCompleteUnlessOpen                   = ACSQLiteFileOpenOptions(rawValue: 0x00200000) // SQLITE_OPEN_FILEPROTECTION_COMPLETEUNLESSOPEN                   0x00200000
    public static let fileProtectionCompleteUntilFirstUserAuthentication = ACSQLiteFileOpenOptions(rawValue: 0x00300000) // SQLITE_OPEN_FILEPROTECTION_COMPLETEUNTILFIRSTUSERAUTHENTICATION 0x00300000
    public static let fileProtectionNone                                 = ACSQLiteFileOpenOptions(rawValue: 0x00400000) // SQLITE_OPEN_FILEPROTECTION_NONE                                 0x00400000
    public static let fileProtectionMask                                 = ACSQLiteFileOpenOptions(rawValue: 0x00700000) // SQLITE_OPEN_FILEPROTECTION_MASK                                 0x00700000
    
    // Custom File Open Operations
    public static let `default` = ACSQLiteFileOpenOptions(rawValue: ACSQLiteFileOpenOptions.readWrite.rawValue | ACSQLiteFileOpenOptions.create.rawValue | ACSQLiteFileOpenOptions.privateCache.rawValue | ACSQLiteFileOpenOptions.fullMutex.rawValue)
}
