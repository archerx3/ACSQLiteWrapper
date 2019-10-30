//
//  ACSQLite.swift
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

typealias sqlite3 = OpaquePointer

class ACSQLite {
    /**
     int32_t volatile  mBeginTransactionCounter;
     NSMutableArray   *mCallMethodHistory;
     BOOL              mCallMethodHistoryEnabled;
     int32_t volatile  mMutextEnterCounter;
     */
    private var _sqlite3: sqlite3? = nil
    private (set) var sqlite3: sqlite3? {
        set {
            if _sqlite3 != newValue {
                _sqlite3 = newValue
            }
        }
        get {
            return _sqlite3
        }
    }
    
    private var _needsHandleDatabaseChanges: Int32 = 0
    
    init() {
        _sqlite3 = nil
    }
    
    convenience init(_ sqlite3: sqlite3?) {
        self.init()
        _sqlite3 = sqlite3
    }
    
    public convenience init(fileName: String?, fileOpenOptions: ACSQLiteFileOpenOptions, virtualFileSystem: String?) throws {
        var sqlite3: OpaquePointer?
        
        var operation = fileOpenOptions
        if fileOpenOptions.contains(.uri) {
            operation = .default
        }
        
        let resultCode = ACSQLiteResultCode(sqlite3_open_v2(fileName,
                                                            &sqlite3,
                                                            Int32(operation.rawValue),
                                                            virtualFileSystem))
        
        if resultCode != ACSQLiteResultCode.ok, let error = CreateACSQLiteError(resultCodeOrExtendedResultCode: resultCode)
        {
            throw error
        }
        
        self.init(sqlite3)
    }
    
    public convenience init(url: URL, fileOpenOperations fileOperations: ACSQLiteFileOpenOptions, virtualFileSystem: String) throws {
        let path = url.absoluteString
        
        var sqlite3: sqlite3? = nil
        
        var operation = fileOperations
        if !fileOperations.contains(.uri) {
            operation.formUnion(.uri)
        }
        
        let openResult = sqlite3_open_v2(path, &sqlite3, Int32(operation.rawValue), virtualFileSystem)
        
        let resultCode = ACSQLiteResultCode.init(openResult)
        
        if resultCode != ACSQLiteResultCode.ok, let error = CreateACSQLiteError(resultCodeOrExtendedResultCode: resultCode)
        {
            throw error
        }
        
        self.init(sqlite3)
    }
    
    deinit {
        if _sqlite3 != nil {
            let closeResult = sqlite3_close(_sqlite3!)
            
            let resultCode = ACSQLiteResultCode(closeResult)
            
            if resultCode != .ok {
                fatalError("Can not close SQLite database.")
            }
            
            _sqlite3 = nil
        }
    }
}

extension ACSQLite {
    func lastError() -> ACSQLiteError? {
        let error = CreateACSQLiteError(_sqlite3)
        return error
    }
    
    func lastInsertRowIdentifier() -> sqlite3_int64 {
        var result: sqlite3_int64 = 0
        guard let sql = _sqlite3 else {
            return result
        }
        
        result = sqlite3_last_insert_rowid(sql)
        
        return result
    }
    
    func numberOfChangedRows() -> Int {
        var numberOfChangedRow: Int = 0
        
        if let sql = _sqlite3 {
            let changedInt32 = sqlite3_changes(sql)
            numberOfChangedRow = Int(changedInt32)
        }
        
        return numberOfChangedRow
    }
    
    func totalOfChangedRows() -> Int32 {
        var total: Int32 = 0
        guard let sql = _sqlite3 else {
            return total
        }
        
        total = sqlite3_total_changes(sql)
        
        return total
    }
    
    func interrupt() {
        guard let sql = _sqlite3 else { return }
        
        sqlite3_interrupt(sql)
    }
}

extension ACSQLite {
    func setNeedsHandleDatabaseChanged() {
        OSAtomicCompareAndSwap32Barrier(0, 1, &_needsHandleDatabaseChanges)
    }
    
    func handleDatabaseChangesIfNeed() {
        let hasDatabaseChanged = OSAtomicCompareAndSwap32Barrier(1, 0, &_needsHandleDatabaseChanges)
        
        if hasDatabaseChanged {
            // TODO:
            //SADatabaseStateHandler *databaseStateHandler = [SADatabaseStateHandler sharedHandler];
            //[databaseStateHandler handle];
        }
    }
    
    func handleCommand(command: String) {
        if command.hasPrefix("UPDATE\n") ||
            command.hasPrefix("INSERT\n") ||
            command.hasPrefix("DELETE\n") ||
            command.hasPrefix("UPDATE ") ||
            command.hasPrefix("INSERT ") ||
            command.hasPrefix("DELETE ") {
            let numberOfChangedRows = self.numberOfChangedRows()
            if numberOfChangedRows != 0 {
                OSAtomicCompareAndSwap32Barrier(0, 1, &_needsHandleDatabaseChanges)
            }
        } else if !(command.hasPrefix("SELECT\n") ||
            command.hasPrefix("CREATE\n") ||
            command.hasPrefix("PRAGMA\n") ||
            command.hasPrefix("ALTER\n") ||
            command.hasPrefix("DROP\n") ||
            command.hasPrefix("EXPLAIN\n") ||
            command.hasPrefix("SELECT ") ||
            command.hasPrefix("CREATE ") ||
            command.hasPrefix("PRAGMA") ||
            command.hasPrefix("ALTER ") ||
            command.hasPrefix("DROP ") ||
            command.hasPrefix("EXPLAIN ")) {
            print("Have unknow SQL command: \(command)")
        }
    }
}

extension ACSQLite {
    func threadsafeMode() -> ACSQLiteLibraryThreadsafeMode
    {
        let threadsafeMode = ACSQLiteLibraryThreadsafeMode(sqlite3_threadsafe())
        
        return threadsafeMode
    }
    
    func setBusyTimeout(milliseconds: Int) throws {
        try setBusyTimeout(millseconds: Int32(milliseconds))
    }
    
    @discardableResult
    private func setBusyTimeout(millseconds: Int32) throws -> Bool {
        var resultFlag = false
        guard let sql = _sqlite3 else {
            return resultFlag
        }
        
        let result = sqlite3_busy_timeout(sql, millseconds)
        
        let resultCode = ACSQLiteResultCode.init(result)
        
        if (resultCode != .ok && resultCode != .row && resultCode != .done) {
            if let err = CreateACSQLiteError(sql, resultCodeOrExtendedResultCode: resultCode) {
                throw err
            } else {
                let error = ACError.init(domain: nil, code: resultCode.stringValue, errorMessage: "Set Busy time error")
                throw error
            }
        } else {
            resultFlag = true
        }
        
        return resultFlag
    }
    
    func recursiveTrigger() -> Bool {
        var error: ACSQLiteError? = nil
        
        let result = recursiveTrigger(error: &error)
        
        if !result && (error != nil) {
            fatalError("Get recursive trigger error: \(error!)")
        }
        
        return result
    }
    
    func setRecursiveTrigger(_ newValue: Bool) -> Bool {
        var error: ACSQLiteError? = nil
        
        let result = setRecursiveTrigger(newValue, error: &error)
        
        if !result && (error != nil) {
            fatalError("Set recursive trigger error: \(error!)")
        }
        
        return result
    }
    
    @discardableResult
    private func recursiveTrigger(error : inout ACSQLiteError?) -> Bool {
        var resultFlag = false
        guard let _ = _sqlite3 else {
            return resultFlag
        }
        
        resultFlag = false
        
        
        
        return resultFlag
    }
    
    @discardableResult
    private func setRecursiveTrigger(_ newValue: Bool, error: inout ACSQLiteError?) -> Bool {
        return false
    }
    
    func releaseMemory() {
        guard let sql = _sqlite3 else {
            return
        }
        
        sqlite3_db_release_memory(sql)
    }
    
    func closeDB() throws {
        try closeDataBase()
    }
    
    private func closeDataBase(automatic: Bool = true) throws {
        
        guard let sql = _sqlite3 else {
            if let error = CreateACSQLiteError(resultCodeOrExtendedResultCode: ACSQLiteResultCode.error) {
                throw error
            } else {
                let error = ACError.init(domain: ACError.sqliteCodeErrorDomain, code: nil, errorMessage: "SQLite is null")
                throw error
            }
        }
        
        let resultCode : ACSQLiteResultCode
        
        if automatic {
            if #available(iOS 8.2, *) {
                resultCode = ACSQLiteResultCode(sqlite3_close_v2(sql))
            } else {
                resultCode = ACSQLiteResultCode(sqlite3_close(sql))
            }
        } else {
            resultCode = ACSQLiteResultCode(sqlite3_close(sql))
        }
        
        if resultCode != .ok {
            if let error = CreateACSQLiteError(sql, resultCodeOrExtendedResultCode: resultCode) {
                throw error
            } else {
                let error = ACError.init(domain: ACError.sqliteCodeErrorDomain, code: resultCode.stringValue, errorMessage: nil)
                throw error
            }
        }
    }
}

extension ACSQLite {
    func limitLength(error: inout ACSQLiteError?) -> Int32 {
        limit(.Length, error: &error)
    }
    
    func setLimitLength(_ newValue: Int32, error: inout ACSQLiteError?) -> Int32 {
        setLimit(newValue, .Length, error: &error)
    }
    
    func limitSQLLength(error: inout ACSQLiteError?) -> Int32 {
        limit(.SQLLength, error: &error)
    }
    
    func setLimitSQLLength(_ newValue: Int32, error: inout ACSQLiteError?) -> Int32 {
        setLimit(newValue, .SQLLength, error: &error)
    }
    
    func limitColumn(error: inout ACSQLiteError?) -> Int32 {
        limit(.Column, error: &error)
    }
    
    func setLimitColumn(_ newValue: Int32, error: inout ACSQLiteError?) -> Int32 {
        setLimit(newValue, .Column, error: &error)
    }
    
    func limitExpressDepth(error: inout ACSQLiteError?) -> Int32 {
        limit(.ExpressionDepth, error: &error)
    }
    
    func setLimitExpressDepth(_ newValue: Int32, error: inout ACSQLiteError?) -> Int32 {
        setLimit(newValue, .ExpressionDepth, error: &error)
    }
    
    func limitCompoundSelect(error: inout ACSQLiteError?) -> Int32 {
        limit(.CompoundSelect, error: &error)
    }
    
    func setLimitCompundSelect(_ newValue: Int32, error: inout ACSQLiteError?) -> Int32 {
        setLimit(newValue, .CompoundSelect, error: &error)
    }
    
    func limitVDBEOP(error: inout ACSQLiteError?) -> Int32 {
        limit(.VDBEOP, error: &error)
    }
    
    func setLimitVDBEOP(_ newValue: Int32, error: inout ACSQLiteError?) -> Int32 {
        setLimit(newValue, .VDBEOP, error: &error)
    }
    
    func limitFunctionArguments(error: inout ACSQLiteError?) -> Int32 {
        limit(.FunctionArguments, error: &error)
    }
    
    func setLimitFunctionArguments(_ newValue: Int32, error: inout ACSQLiteError?) -> Int32 {
        setLimit(newValue, .FunctionArguments, error: &error)
    }
    
    func limitAttached(error: inout ACSQLiteError?) -> Int32 {
        limit(.Attached, error: &error)
    }
    
    func setLimitAttached(_ newValue: Int32, error: inout ACSQLiteError?) -> Int32 {
        setLimit(newValue, .Attached, error: &error)
    }
    
    func limitLikePatternLength(error: inout ACSQLiteError?) -> Int32 {
        limit(.LikePatternLength, error: &error)
    }
    
    func setLimitLikePatternLength(_ newValue: Int32, error: inout ACSQLiteError?) -> Int32 {
        setLimit(newValue, .LikePatternLength, error: &error)
    }
    
    func limitVariableNumber(error: inout ACSQLiteError?) -> Int32 {
        limit(.VariableNumber, error: &error)
    }
    
    func setLimitVariableNumber(_ newValue: Int32, error: inout ACSQLiteError?) -> Int32 {
        setLimit(newValue, .VariableNumber, error: &error)
    }
    
    func limitTriggerDapth(error: inout ACSQLiteError?) -> Int32 {
        limit(.TriggerDapth, error: &error)
    }
    
    func setLimitTriggerDapth(_ newValue: Int32, error: inout ACSQLiteError?) -> Int32 {
        setLimit(newValue, .TriggerDapth, error: &error)
    }
    
    func limit(_ limit: ACSQLiteLimit, error: inout ACSQLiteError?) -> Int32 {
        var result: Int32 = 0
        guard let sql = _sqlite3 else {
            return 0
        }
        
        result = sqlite3_limit(sql, limit.rawValue, -1)
        
        return result
    }
    
    func setLimit(_ newValue: Int32, _ limit: ACSQLiteLimit, error: inout ACSQLiteError?) -> Int32 {
        var result: Int32 = 0
        guard let sql = _sqlite3 else {
            return 0
        }
        
        result = sqlite3_limit(sql, limit.rawValue, newValue)
        
        return result
    }
}

// Congifuring The SQLite Library
extension ACSQLite {
    private func testAPI() {
//        if let cstring = "sdfdf".cString(using: .utf8) {
//                let cStrPoint = withUnsafePointer(to: cstring, { $0 })
//        //        CFString()
//
//                let string = "path"
//                let stringPoint = withUnsafePointer(to: string, { $0 })
//                var dbOpoint: OpaquePointer? = nil
//                var vfileSystem: String? = nil
//                sqlite3_open_v2(string, &dbOpoint, 1, vfileSystem)
//        }
//        sqlite3_free(<#T##UnsafeMutableRawPointer!#>)
        
//        memcpy(<#T##__dst: UnsafeMutableRawPointer!##UnsafeMutableRawPointer!#>, <#T##__src: UnsafeRawPointer!##UnsafeRawPointer!#>, <#T##__n: Int##Int#>)
//        strcmp(<#T##__s1: UnsafePointer<Int8>!##UnsafePointer<Int8>!#>, <#T##__s2: UnsafePointer<Int8>!##UnsafePointer<Int8>!#>)
        
//        malloc(<#T##__size: Int##Int#>) // UnsafeMutableRawPointer!
//        free(<#T##UnsafeMutableRawPointer!#>)
        var string = "123"
        let point = withUnsafePointer(to: &string, {$0})
        
        print("String point : \(point)")
        

    }
    
    func setThreadsafeMode() -> Bool{
        var result = false
        result = false
        return result
    }
    
}
