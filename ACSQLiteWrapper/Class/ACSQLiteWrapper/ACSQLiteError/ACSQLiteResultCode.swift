//
//  ACSQLiteResultCode.swift
//  ACSQLiteWrapper
//
//  Created by archer.chen on 10/30/19.
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

// MARK: - ACSQLiteResultCode
struct ACSQLiteResultCode {
    
    public let rawValue: Int
    
    public var stringValue: String { return NSNumber(value: rawValue).stringValue }
    
    public init(_ rawValue: Int)
    {
        self.rawValue = rawValue
    }
    
    public init(_ rawValue: Int32)
    {
        self.rawValue = Int(rawValue)
    }
    
    public static let ok            = ACSQLiteResultCode(  0) // SQLITE_OK           0 /* Successful result */
    /* beginning-of-error-codes */
    public static let error         = ACSQLiteResultCode(  1) // SQLITE_ERROR        1 /* Generic error */
    public static let `internal`    = ACSQLiteResultCode(  2) // SQLITE_INTERNAL     2 /* Internal logic error in SQLite */
    public static let permission    = ACSQLiteResultCode(  3) // SQLITE_PERM         3 /* Access permission denied */
    public static let abort         = ACSQLiteResultCode(  4) // SQLITE_ABORT        4 /* Callback routine requested an abort */
    public static let busy          = ACSQLiteResultCode(  5) // SQLITE_BUSY         5 /* The database file is locked */
    public static let locked        = ACSQLiteResultCode(  6) // SQLITE_LOCKED       6 /* A table in the database is locked */
    public static let memory        = ACSQLiteResultCode(  7) // SQLITE_NOMEM        7 /* A malloc() failed */
    public static let readonly      = ACSQLiteResultCode(  8) // SQLITE_READONLY     8 /* Attempt to write a readonly database */
    public static let interrup      = ACSQLiteResultCode(  9) // SQLITE_INTERRUPT    9 /* Operation terminated by sqlite3_interrupt()*/
    public static let ioError       = ACSQLiteResultCode( 10) // SQLITE_IOERR       10 /* Some kind of disk I/O error occurred */
    public static let corrup        = ACSQLiteResultCode( 11) // SQLITE_CORRUPT     11 /* The database disk image is malformed */
    public static let notFoun       = ACSQLiteResultCode( 12) // SQLITE_NOTFOUND    12 /* Unknown opcode in sqlite3_file_control() */
    public static let full          = ACSQLiteResultCode( 13) // SQLITE_FULL        13 /* Insertion failed because database is full */
    public static let canNotOpen    = ACSQLiteResultCode( 14) // SQLITE_CANTOPEN    14 /* Unable to open the database file */
    public static let `protocol`    = ACSQLiteResultCode( 15) // SQLITE_PROTOCOL    15 /* Database lock protocol error */
    public static let empty         = ACSQLiteResultCode( 16) // SQLITE_EMPTY       16 /* Internal use only */
    public static let schema        = ACSQLiteResultCode( 17) // SQLITE_SCHEMA      17 /* The database schema changed */
    public static let tooBig        = ACSQLiteResultCode( 18) // SQLITE_TOOBIG      18 /* String or BLOB exceeds size limit */
    public static let constraint    = ACSQLiteResultCode( 19) // SQLITE_CONSTRAINT  19 /* Abort due to constraint violation */
    public static let mismatch      = ACSQLiteResultCode( 20) // SQLITE_MISMATCH    20 /* Data type mismatch */
    public static let misuse        = ACSQLiteResultCode( 21) // SQLITE_MISUSE      21 /* Library used incorrectly */
    public static let noLfs         = ACSQLiteResultCode( 22) // SQLITE_NOLFS       22 /* Uses OS features not supported on host */
    public static let authorization = ACSQLiteResultCode( 23) // SQLITE_AUTH        23 /* Authorization denied */
    public static let format        = ACSQLiteResultCode( 24) // SQLITE_FORMAT      24 /* Not used */
    public static let range         = ACSQLiteResultCode( 25) // SQLITE_RANGE       25 /* 2nd parameter to sqlite3_bind out of range */
    public static let notDatabase   = ACSQLiteResultCode( 26) // SQLITE_NOTADB      26 /* File opened that is not a database file */
    public static let notice        = ACSQLiteResultCode( 27) // SQLITE_NOTICE      27 /* Notifications from sqlite3_log() */
    public static let warning       = ACSQLiteResultCode( 28) // SQLITE_WARNING     28 /* Warnings from sqlite3_log() */
    public static let row           = ACSQLiteResultCode(100) // SQLITE_ROW        100 /* sqlite3_step() has another row ready */
    public static let done          = ACSQLiteResultCode(101) // SQLITE_DONE       101 /* sqlite3_step() has finished executing */
    /* end-of-error-codes */
    
    // MARK: Extended Result Codes
    
    public static let errorCollatingSequence          = ACSQLiteResultCode(ACSQLiteResultCode.error.rawValue         | ( 1<<8)) // SQLITE_ERROR_MISSING_COLLSEQ   (SQLITE_ERROR | (1<<8))
    public static let errorRetry                      = ACSQLiteResultCode(ACSQLiteResultCode.error.rawValue         | ( 2<<8)) // SQLITE_ERROR_RETRY             (SQLITE_ERROR | (2<<8))
    public static let errorSnapshot                   = ACSQLiteResultCode(ACSQLiteResultCode.error.rawValue         | ( 3<<8)) // SQLITE_ERROR_SNAPSHOT          (SQLITE_ERROR | (3<<8))
    
    public static let ioErrorRead                     = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | ( 1<<8)) // SQLITE_IOERR_READ              (SQLITE_IOERR | (1<<8))
    public static let ioErrorShortRead                = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | ( 2<<8)) // SQLITE_IOERR_SHORT_READ        (SQLITE_IOERR | (2<<8))
    public static let ioErrorWrite                    = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | ( 3<<8)) // SQLITE_IOERR_WRITE             (SQLITE_IOERR | (3<<8))
    public static let ioErrorFileSynchronize          = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | ( 4<<8)) // SQLITE_IOERR_FSYNC             (SQLITE_IOERR | (4<<8))
    public static let ioErrorDirectoryFileSynchronize = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | ( 5<<8)) // SQLITE_IOERR_DIR_FSYNC         (SQLITE_IOERR | (5<<8))
    public static let ioErrorTruncate                 = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | ( 6<<8)) // SQLITE_IOERR_TRUNCATE          (SQLITE_IOERR | (6<<8))
    public static let ioErrorFileStat                 = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | ( 7<<8)) // SQLITE_IOERR_FSTAT             (SQLITE_IOERR | (7<<8))
    public static let ioErrorUnlock                   = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | ( 8<<8)) // SQLITE_IOERR_UNLOCK            (SQLITE_IOERR | (8<<8))
    public static let ioErrorReadLock                 = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | ( 9<<8)) // SQLITE_IOERR_RDLOCK            (SQLITE_IOERR | (9<<8))
    public static let ioErrorDelete                   = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (10<<8)) // SQLITE_IOERR_DELETE            (SQLITE_IOERR | (10<<8))
    public static let ioErrorBlocked                  = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (11<<8)) // SQLITE_IOERR_BLOCKED           (SQLITE_IOERR | (11<<8))
    public static let ioErrorNoMemory                 = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (12<<8)) // SQLITE_IOERR_NOMEM             (SQLITE_IOERR | (12<<8))
    public static let ioErrorAccess                   = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (13<<8)) // SQLITE_IOERR_ACCESS            (SQLITE_IOERR | (13<<8))
    public static let ioErrorCheckReservedLock        = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (14<<8)) // SQLITE_IOERR_CHECKRESERVEDLOCK (SQLITE_IOERR | (14<<8))
    public static let ioErrorLock                     = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (15<<8)) // SQLITE_IOERR_LOCK              (SQLITE_IOERR | (15<<8))
    public static let ioErrorClose                    = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (16<<8)) // SQLITE_IOERR_CLOSE             (SQLITE_IOERR | (16<<8))
    public static let ioErrorDirectoryClose           = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (17<<8)) // SQLITE_IOERR_DIR_CLOSE         (SQLITE_IOERR | (17<<8))
    public static let ioErrorSharedMemoryOpen         = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (18<<8)) // SQLITE_IOERR_SHMOPEN           (SQLITE_IOERR | (18<<8))
    public static let ioErrorSharedMemorySize         = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (19<<8)) // SQLITE_IOERR_SHMSIZE           (SQLITE_IOERR | (19<<8))
    public static let ioErrorSharedMemoryLock         = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (20<<8)) // SQLITE_IOERR_SHMLOCK           (SQLITE_IOERR | (20<<8))
    public static let ioErrorSharedMemoryMap          = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (21<<8)) // SQLITE_IOERR_SHMMAP            (SQLITE_IOERR | (21<<8))
    public static let ioErrorSeek                     = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (22<<8)) // SQLITE_IOERR_SEEK              (SQLITE_IOERR | (22<<8))
    public static let ioErrorDeleteNoEntity           = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (23<<8)) // SQLITE_IOERR_DELETE_NOENT      (SQLITE_IOERR | (23<<8))
    public static let ioErrorMmap                     = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (24<<8)) // SQLITE_IOERR_MMAP              (SQLITE_IOERR | (24<<8))
    public static let ioErrorGetTempPath              = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (25<<8)) // SQLITE_IOERR_GETTEMPPATH       (SQLITE_IOERR | (25<<8))
    public static let ioErrorConvertPath              = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (26<<8)) // SQLITE_IOERR_CONVPATH          (SQLITE_IOERR | (26<<8))
    public static let ioErrorVNode                    = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (27<<8)) // SQLITE_IOERR_VNODE             (SQLITE_IOERR | (27<<8))
    public static let ioErrorAuthorize                = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (28<<8)) // SQLITE_IOERR_AUTH              (SQLITE_IOERR | (28<<8))
    public static let ioErrorBeginAtomic              = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (29<<8)) // SQLITE_IOERR_BEGIN_ATOMIC      (SQLITE_IOERR | (29<<8))
    public static let ioErrorCommitAtomic             = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (30<<8)) // SQLITE_IOERR_COMMIT_ATOMIC     (SQLITE_IOERR | (30<<8))
    public static let ioErrorRollbackAtomic           = ACSQLiteResultCode(ACSQLiteResultCode.ioError.rawValue       | (31<<8)) // SQLITE_IOERR_ROLLBACK_ATOMIC   (SQLITE_IOERR | (31<<8))
    
    public static let lockedSharedCach                = ACSQLiteResultCode(ACSQLiteResultCode.locked.rawValue        | ( 1<<8)) // SQLITE_LOCKED_SHAREDCACHE      (SQLITE_LOCKED |  (1<<8))
    public static let lockedVTab                      = ACSQLiteResultCode(ACSQLiteResultCode.locked.rawValue        | ( 2<<8)) // SQLITE_LOCKED_VTAB             (SQLITE_LOCKED |  (2<<8))
    
    public static let busyRecovery                    = ACSQLiteResultCode(ACSQLiteResultCode.busy.rawValue          | ( 1<<8)) // SQLITE_BUSY_RECOVERY           (SQLITE_BUSY   |  (1<<8))
    public static let busySnapshot                    = ACSQLiteResultCode(ACSQLiteResultCode.busy.rawValue          | ( 2<<8)) // SQLITE_BUSY_SNAPSHOT           (SQLITE_BUSY   |  (2<<8))
    
    public static let canNotOpenNotTempDirectory      = ACSQLiteResultCode(ACSQLiteResultCode.canNotOpen.rawValue    | ( 1<<8)) // SQLITE_CANTOPEN_NOTEMPDIR      (SQLITE_CANTOPEN | (1<<8))
    public static let canNotOpenIsDirectory           = ACSQLiteResultCode(ACSQLiteResultCode.canNotOpen.rawValue    | ( 2<<8)) // SQLITE_CANTOPEN_ISDIR          (SQLITE_CANTOPEN | (2<<8))
    public static let canNotOpenFullPath              = ACSQLiteResultCode(ACSQLiteResultCode.canNotOpen.rawValue    | ( 3<<8)) // SQLITE_CANTOPEN_FULLPATH       (SQLITE_CANTOPEN | (3<<8))
    public static let canNotOpenConvertPath           = ACSQLiteResultCode(ACSQLiteResultCode.canNotOpen.rawValue    | ( 4<<8)) // SQLITE_CANTOPEN_CONVPATH       (SQLITE_CANTOPEN | (4<<8))
    public static let canNotOpenDirtyWal              = ACSQLiteResultCode(ACSQLiteResultCode.canNotOpen.rawValue    | ( 5<<8)) // SQLITE_CANTOPEN_DIRTYWAL       (SQLITE_CANTOPEN | (5<<8)) /* NOT USED */
    
    public static let corrupVTab                      = ACSQLiteResultCode(ACSQLiteResultCode.corrup.rawValue        | ( 1<<8)) // SQLITE_CORRUPT_VTAB            (SQLITE_CORRUPT | (1<<8))
    public static let corrupSequence                  = ACSQLiteResultCode(ACSQLiteResultCode.corrup.rawValue        | ( 2<<8)) // SQLITE_CORRUPT_SEQUENCE        (SQLITE_CORRUPT | (2<<8))
    
    public static let readonlyRecovery                = ACSQLiteResultCode(ACSQLiteResultCode.readonly.rawValue      | ( 1<<8)) // SQLITE_READONLY_RECOVERY       (SQLITE_READONLY | (1<<8))
    public static let readonlyCanNotLock              = ACSQLiteResultCode(ACSQLiteResultCode.readonly.rawValue      | ( 2<<8)) // SQLITE_READONLY_CANTLOCK       (SQLITE_READONLY | (2<<8))
    public static let readonlyRollback                = ACSQLiteResultCode(ACSQLiteResultCode.readonly.rawValue      | ( 3<<8)) // SQLITE_READONLY_ROLLBACK       (SQLITE_READONLY | (3<<8))
    public static let readonlyDataBaseMoved           = ACSQLiteResultCode(ACSQLiteResultCode.readonly.rawValue      | ( 4<<8)) // SQLITE_READONLY_DBMOVED        (SQLITE_READONLY | (4<<8))
    public static let readonlyCanNotInitialize        = ACSQLiteResultCode(ACSQLiteResultCode.readonly.rawValue      | ( 5<<8)) // SQLITE_READONLY_CANTINIT       (SQLITE_READONLY | (5<<8))
    public static let readonlyDirectory               = ACSQLiteResultCode(ACSQLiteResultCode.readonly.rawValue      | ( 6<<8)) // SQLITE_READONLY_DIRECTORY      (SQLITE_READONLY | (6<<8))
    
    public static let abortRollback                   = ACSQLiteResultCode(ACSQLiteResultCode.abort.rawValue         | ( 2<<8)) // SQLITE_ABORT_ROLLBACK          (SQLITE_ABORT | (2<<8))
    
    public static let constraintCheck                 = ACSQLiteResultCode(ACSQLiteResultCode.constraint.rawValue    | ( 1<<8)) // SQLITE_CONSTRAINT_CHECK        (SQLITE_CONSTRAINT | (1<<8))
    public static let constraintCommitHook            = ACSQLiteResultCode(ACSQLiteResultCode.constraint.rawValue    | ( 2<<8)) // SQLITE_CONSTRAINT_COMMITHOOK   (SQLITE_CONSTRAINT | (2<<8))
    public static let constraintForeingKey            = ACSQLiteResultCode(ACSQLiteResultCode.constraint.rawValue    | ( 3<<8)) // SQLITE_CONSTRAINT_FOREIGNKEY   (SQLITE_CONSTRAINT | (3<<8))
    public static let constraintFunction              = ACSQLiteResultCode(ACSQLiteResultCode.constraint.rawValue    | ( 4<<8)) // SQLITE_CONSTRAINT_FUNCTION     (SQLITE_CONSTRAINT | (4<<8))
    public static let constraintNotNull               = ACSQLiteResultCode(ACSQLiteResultCode.constraint.rawValue    | ( 5<<8)) // SQLITE_CONSTRAINT_NOTNULL      (SQLITE_CONSTRAINT | (5<<8))
    public static let constraintPrimaryKey            = ACSQLiteResultCode(ACSQLiteResultCode.constraint.rawValue    | ( 6<<8)) // SQLITE_CONSTRAINT_PRIMARYKEY   (SQLITE_CONSTRAINT | (6<<8))
    public static let constraintTrigger               = ACSQLiteResultCode(ACSQLiteResultCode.constraint.rawValue    | ( 7<<8)) // SQLITE_CONSTRAINT_TRIGGER      (SQLITE_CONSTRAINT | (7<<8))
    public static let constraintUnique                = ACSQLiteResultCode(ACSQLiteResultCode.constraint.rawValue    | ( 8<<8)) // SQLITE_CONSTRAINT_UNIQUE       (SQLITE_CONSTRAINT | (8<<8))
    public static let constraintVtab                  = ACSQLiteResultCode(ACSQLiteResultCode.constraint.rawValue    | ( 9<<8)) // SQLITE_CONSTRAINT_VTAB         (SQLITE_CONSTRAINT | (9<<8))
    public static let constraintRowId                 = ACSQLiteResultCode(ACSQLiteResultCode.constraint.rawValue    | (10<<8)) // SQLITE_CONSTRAINT_ROWID        (SQLITE_CONSTRAINT |(10<<8))
    
    public static let noticeWal                       = ACSQLiteResultCode(ACSQLiteResultCode.notice.rawValue        | ( 1<<8)) // SQLITE_NOTICE_RECOVER_WAL      (SQLITE_NOTICE | (1<<8))
    public static let noticeRecoverRollback           = ACSQLiteResultCode(ACSQLiteResultCode.notice.rawValue        | ( 2<<8)) // SQLITE_NOTICE_RECOVER_ROLLBACK (SQLITE_NOTICE | (2<<8))
    
    public static let warningAutoIndex                = ACSQLiteResultCode(ACSQLiteResultCode.warning.rawValue       | ( 1<<8)) // SQLITE_WARNING_AUTOINDEX       (SQLITE_WARNING | (1<<8))
    
    public static let authorizationUser               = ACSQLiteResultCode(ACSQLiteResultCode.authorization.rawValue | ( 1<<8)) // SQLITE_AUTH_USER               (SQLITE_AUTH | (1<<8))
    
    public static let okLoadPermanently               = ACSQLiteResultCode(ACSQLiteResultCode.ok.rawValue            | ( 1<<8)) // SQLITE_OK_LOAD_PERMANENTLY     (SQLITE_OK | (1<<8))
}

extension ACSQLiteResultCode: Equatable {
    public static func == (lhs: ACSQLiteResultCode, rhs: ACSQLiteResultCode) -> Bool {
        let isEqual: Bool = (lhs.rawValue == rhs.rawValue)
        
        return isEqual
    }
    
    public static func != (lhs: ACSQLiteResultCode, rhs: ACSQLiteResultCode) -> Bool {
        
        let isNotEqual: Bool = (lhs.rawValue != rhs.rawValue)
        
        return isNotEqual
    }
}
