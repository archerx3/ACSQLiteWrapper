//
//  ACSQLiteStatement.swift
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

typealias sqlite3_stmt = OpaquePointer

private let SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)
private let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

class ACSQLiteStatement: NSObject {
    private var _sqlite3_stmt: sqlite3_stmt? = nil
    private (set) var sqlite3_stmt: sqlite3_stmt? {
        set {
            if _sqlite3_stmt != newValue {
                sqlite3_finalize(_sqlite3_stmt)
                _sqlite3_stmt = newValue
            }
        }
        get {
            return _sqlite3_stmt
        }
    }
    
    override init() {
        super.init()
    }
    
    init(sqliteStatement: sqlite3_stmt) {
        super.init()
        
        self.sqlite3_stmt = sqliteStatement
    }
    
    deinit {
        sqlite3_finalize(_sqlite3_stmt)
        _sqlite3_stmt = nil
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        var isEqual = false
        
        if let sqlStmt = _sqlite3_stmt,
            let newObjc = object as? ACSQLiteStatement,
            let newSqlStmt = newObjc.sqlite3_stmt {
            if sqlStmt == newSqlStmt {
                isEqual = true
            }
        }
        
        return isEqual
    }
}

extension ACSQLiteStatement {
    func command() -> String? {
        var command: String? = nil
        
        if let point = sqlite3_sql(_sqlite3_stmt) {
            command = String.init(cString: point)
        }
        
        return command
    }
    
    func isReadonly() -> Bool {
        var isReadonly = true
        guard let sqlStmt = _sqlite3_stmt else {
            return isReadonly
        }
        
        let result = sqlite3_stmt_readonly(sqlStmt)
        
        isReadonly = (result != 0)
        
        return isReadonly
    }
    
    func bindCount() -> UInt {
        guard let sqlStmt = _sqlite3_stmt else {
            return 0
        }
       
        var count = sqlite3_bind_parameter_count(sqlStmt)
        
        if count < 0 {
            count = 0
        }
        
        return UInt(count)
    }
    
    func columnCount() -> Int {
        guard let sqlStmt = _sqlite3_stmt else {
            return 0
        }
        
        let count = sqlite3_column_count(sqlStmt)
        
        if count < 0 {
            return NSNotFound
        } else {
            return Int(count)
        }
    }
    
    func dataCount() -> Int {
        var count: Int = 0
        guard let sqlStmt = _sqlite3_stmt else {
            return count
        }
        
        let result = sqlite3_data_count(sqlStmt)
        
        if result < 0 {
            count = NSNotFound
        } else {
            count = Int(result)
        }
        
        return count
    }
    
    func bindName(at index: UInt) -> String? {
        guard let sqlStmt = _sqlite3_stmt else {
            return nil
        }
        
        var bindName: String? = nil
        
        let idx = Int32(index)
        
        if let bindNamePoint = sqlite3_bind_parameter_name(sqlStmt, idx + 1) {
            bindName = String.init(cString: bindNamePoint)
        }
        
        return bindName
    }
    
    func bindIndex(from name: String) -> Int {
        guard let sqlStmt = _sqlite3_stmt else {
            return 0
        }
        
        let bindIndex = sqlite3_bind_parameter_index(sqlStmt, name)
        
        if bindIndex <= 0 {
            return NSNotFound
        } else {
            return Int(bindIndex)
        }
    }
    
    func columnName(at index: Int) throws -> String? {
        guard let sqlStmt = _sqlite3_stmt else {
            let error = ACError.init(domain: ACError.sqliteCodeErrorDomain,
                                     code: nil,
                                     errorMessage: "Can not finalize SQLite statement, sqlite statement is null.")
            throw error
        }
        
        var columnName: String? = nil
        
        if let columnNamePointer = sqlite3_column_name(sqlStmt, Int32(index)) {
            columnName = String.init(cString: columnNamePointer)
        } else {
            if let sqlite = sqlite3_db_handle(sqlStmt), let error = CreateACSQLiteError(sqlite) {
                throw error
            } else {
                let error = ACError.init(domain: ACError.sqliteCodeErrorDomain,
                                         code: nil,
                                         errorMessage: "Can not finalize SQLite statement failed.")
                throw error
            }
        }
        
        return columnName
    }
    
    func columnDecltypeName(at index: Int) -> String? {
        guard let sqlStmt = _sqlite3_stmt else {
            return nil
        }
        
        var columnName: String? = nil
        
        if let columnNamePointer = sqlite3_column_decltype(sqlStmt, Int32(index)) {
            columnName = String.init(cString: columnNamePointer)
        }
        
        return columnName
    }
    
    func step() throws -> ACSQLiteResultCode {
        var resultCode: ACSQLiteResultCode = .error
        
        guard let sqlStmt = _sqlite3_stmt else {
            let error = ACError.init(domain: ACError.sqliteCodeErrorDomain,
                                     code: nil,
                                     errorMessage: "SQLite step error, sqlite statement is null.")
            throw error
        }
        
        let result = sqlite3_step(sqlStmt)
        resultCode = ACSQLiteResultCode.init(result)
        
        if resultCode != .ok && resultCode != .row && resultCode != .done {
            if let sqlite = sqlite3_db_handle(sqlStmt), let error = CreateACSQLiteError(sqlite, resultCodeOrExtendedResultCode: resultCode) {
                throw error
            } else {
                let error = ACError.init(domain: ACError.sqliteCodeErrorDomain,
                                         code: nil,
                                         errorMessage: "SQLite step error.")
                throw error
            }
        }
        
        return resultCode
    }
    
    func clearBinding() throws -> Void {
        guard let sqlStmt = _sqlite3_stmt else {
            let error = ACError.init(domain: ACError.sqliteCodeErrorDomain,
                                     code: nil,
                                     errorMessage: "Clear Binding failed.")
            throw error
        }
        
        let result = sqlite3_clear_bindings(sqlStmt)
        let resultCode = ACSQLiteResultCode.init(result)
        
        if resultCode != .ok {
            if let sqlite = sqlite3_db_handle(sqlStmt), let error = CreateACSQLiteError(sqlite, resultCodeOrExtendedResultCode: resultCode) {
                throw error
            } else {
                let error = ACError.init(domain: ACError.sqliteCodeErrorDomain,
                                         code: nil,
                                         errorMessage: "Clear Binding failed.")
                throw error
            }
        }
    }
    
    func finalizeStatement() throws {
        guard let sqlStmt = _sqlite3_stmt else {
            let error = ACError.init(domain: ACError.sqliteCodeErrorDomain,
                                     code: nil,
                                     errorMessage: "Can not finalize SQLite statement, sqlite statement is null.")
            throw error
        }
        
        let result = sqlite3_finalize(sqlStmt)
        let resultCode = ACSQLiteResultCode.init(result)
        
        if resultCode != .ok && resultCode != .row && resultCode != .done {
            let sqlite = sqlite3_db_handle(sqlStmt)
            if let error = CreateACSQLiteError(sqlite, resultCodeOrExtendedResultCode: resultCode) {
                throw error
            } else {
                let error = ACError.init(domain: ACError.sqliteCodeErrorDomain,
                                         code: nil,
                                         errorMessage: "Finalize SQLite statement failed.")
                throw error
            }
        }
    }
    
    func reset() throws -> Bool {
        var resultFlag = false
        
        guard let sqlStmt = _sqlite3_stmt else {
            return resultFlag
        }
        
        let result = sqlite3_reset(sqlStmt)
        let resultCode = ACSQLiteResultCode.init(result)
        
        resultFlag = true
        
        if resultCode != .ok && resultCode != .row && resultCode != .done {
            let sqlite = sqlite3_db_handle(sqlStmt)
            if let error = CreateACSQLiteError(sqlite, resultCodeOrExtendedResultCode: resultCode) {
                throw error
            } else {
                let error = ACError.init(domain: ACError.sqliteCodeErrorDomain,
                                         code: nil,
                                         errorMessage: "Reset SQLite failed.")
                throw error
            }
        }
        
        return resultFlag
    }
}

// MARK: - Bind Values
extension ACSQLiteStatement {
    func bind(data: Data?, at index: Int, copied: Bool) throws -> Bool {
        guard let sqlStmt = _sqlite3_stmt, let newData = data else {
            return false
        }
        
        var resultFlag = false

        let nsData = NSData.init(data: newData)

        let bytes = nsData.bytes
        let numberOfBytes = nsData.length
        
        resultFlag = true

        let result = sqlite3_bind_blob(sqlStmt, Int32(index) + 1, bytes, Int32(numberOfBytes), (copied ? SQLITE_TRANSIENT : SQLITE_STATIC))
        
        let resultCode = ACSQLiteResultCode.init(result)
        
        if resultCode != .ok {
            resultFlag = false
            
            let sqlite = sqlite3_db_handle(sqlStmt)
            if let error = CreateACSQLiteError(sqlite, resultCodeOrExtendedResultCode: resultCode) {
                throw error
            }
        }
        
        return resultFlag
    }
    
    func bind(data: Data?, for name: String, copied: Bool) throws -> Bool {
        var resultFlag = false

        let bindIndex = self.bindIndex(from: name)
           
        if bindIndex != NSNotFound {
            resultFlag = try self.bind(data: data, at: bindIndex, copied: copied)
        }
        
        return resultFlag
    }
    
    func bindZeroData(at index: Int, length: UInt) throws -> Bool {
        guard let sqlStmt = _sqlite3_stmt else {
            return false
        }
        
        var resultFlag = false
        
        let result = sqlite3_bind_zeroblob(sqlStmt, Int32(index) + 1, Int32(length))
        
        let resultCode = ACSQLiteResultCode.init(result)
        
        if resultCode != .ok {
            let sqlite = sqlite3_db_handle(sqlStmt)
            if let error = CreateACSQLiteError(sqlite, resultCodeOrExtendedResultCode: resultCode) {
                throw error
            }
        } else {
            resultFlag = true
        }
        
        return resultFlag
    }
    
    func bindZeroData(for name: String, length: UInt) throws -> Bool {
        var resultFlag = false
        
        let bindIndex = self.bindIndex(from: name)
        
        if bindIndex != NSNotFound {
            resultFlag = try self.bindZeroData(at: bindIndex, length: length)
        }
        
        return resultFlag
    }
    
    func bind(doubleValue: Double, at index: Int) throws -> Bool {
        guard let sqlStmt = _sqlite3_stmt else {
            return false
        }
        
        var resultFlag = false
        
        let result = sqlite3_bind_double(sqlStmt, Int32(index) + 1, doubleValue)
        
        let resultCode = ACSQLiteResultCode.init(result)
        
        if resultCode != .ok {
            let sqlite = sqlite3_db_handle(sqlStmt)
            if let error = CreateACSQLiteError(sqlite, resultCodeOrExtendedResultCode: resultCode) {
                throw error
            }
        } else {
            resultFlag = true
        }
        
        return resultFlag
    }
    
    func bind(doubleValue: Double, for name: String) throws -> Bool {
        var resultFlag = false
        
        let bindIndex = self.bindIndex(from: name)
        
        if bindIndex != NSNotFound  {
            resultFlag = try self.bind(doubleValue: doubleValue, at: bindIndex)
        }
        
        return resultFlag
    }
    
    func bind(intValue: Int, at index: Int) throws -> Bool {
        guard let sqlStmt = _sqlite3_stmt else {
            return false
        }

        var resultFlag = false
        let result = sqlite3_bind_int(sqlStmt, Int32(index) + 1, Int32(intValue))
        
        let resultCode = ACSQLiteResultCode.init(result)
        
        if resultCode != .ok {
            let sqlite = sqlite3_db_handle(sqlStmt)
            if let error = CreateACSQLiteError(sqlite, resultCodeOrExtendedResultCode: resultCode) {
                throw error
            }
        } else {
            resultFlag = true
        }
        
        return resultFlag
    }
    
    func bind(intValue: Int, for name: String) throws -> Bool {
        var resultFlage = false
        
        let bindIndex = self.bindIndex(from: name)
        
        if bindIndex != NSNotFound {
            resultFlage = try self.bind(intValue: intValue, at: bindIndex)
        }
        
        return resultFlage
    }
    
    func bind(int64Value: sqlite3_int64, at index: Int) throws -> Bool {
        guard let sqlStmt = _sqlite3_stmt else {
            return false
        }

        var resultFlag = false
        let result = sqlite3_bind_int64(sqlStmt, Int32(int64Value) + 1, int64Value)
        let resultCode = ACSQLiteResultCode.init(result)
        
        if resultCode != .ok {
            let sqlite = sqlite3_db_handle(sqlStmt)
            if let error = CreateACSQLiteError(sqlite, resultCodeOrExtendedResultCode: resultCode) {
                throw error
            }
        } else {
            resultFlag = true
        }
        
        return resultFlag
    }
    
    func bind(int64Value: sqlite3_int64, for name: String) throws -> Bool {
        var resultFlag = false
        
        let bindIndex = self.bindIndex(from: name)
        
        if bindIndex != NSNotFound {
            resultFlag = try self.bind(int64Value: int64Value, at: bindIndex)
        }
        
        return resultFlag
    }
    
    func bind(stringValue: String, at index: Int, copied: Bool) throws -> Bool {
        guard let sqlStmt = _sqlite3_stmt else {
            return false
        }
        
        var resultFlag = false
        let result = sqlite3_bind_text(sqlStmt, Int32(index) + 1, stringValue, -1, SQLITE_TRANSIENT)
        let resultCode = ACSQLiteResultCode.init(result)
        
        if resultCode != .ok {
            let sqlite = sqlite3_db_handle(sqlStmt)
            if let error = CreateACSQLiteError(sqlite, resultCodeOrExtendedResultCode: resultCode) {
                throw error
            }
        } else {
            resultFlag = true
        }
        
        return resultFlag
    }
    
    func bind(stringValue: String, for name: String, copied: Bool) throws -> Bool {
        var resultFlag = false
        
        let bindIndex = self.bindIndex(from: name)
        
        if bindIndex != NSNotFound {
            resultFlag = try self.bind(stringValue: stringValue, at: bindIndex, copied: copied)
        }
        
        return resultFlag
    }
    
    func bindNullValue(at index: Int) throws -> Bool {
        guard let sqlStmt = _sqlite3_stmt else {
            return false
        }

        var resultFlag = false
        let result = sqlite3_bind_null(sqlStmt, Int32(index) + 1)
        let resultCode = ACSQLiteResultCode.init(result)
        
        if resultCode != .ok {
            let sqlite = sqlite3_db_handle(sqlStmt)
            if let error = CreateACSQLiteError(sqlite, resultCodeOrExtendedResultCode: resultCode) {
                throw error
            }
        } else {
            resultFlag = true
        }
        
        return resultFlag
    }
    
    func bindNullValue(for name: String) throws -> Bool {
        var resultFlag = false
        
        let bindIndex = self.bindIndex(from: name)
        
        if bindIndex != NSNotFound {
            resultFlag = try self.bindNullValue(at: bindIndex)
        }
        
        return resultFlag
    }
    
    func bind(numberValue: NSNumber, at index: Int) throws -> Bool {
        var resultFlag = false
        
        let pointer = numberValue.objCType
        
        if strcmp(pointer, "d") == 0 || strcmp(pointer, "f") == 0 {
            let doubleValue = numberValue.doubleValue
            
            resultFlag = try self.bind(doubleValue: doubleValue, at: index)
        } else {
            let int64Value = numberValue.int64Value
            
            resultFlag = try self.bind(int64Value: int64Value, at: index)
        }
        
        return resultFlag
    }
    
    func bind(numberValue: NSNumber, for name: String) throws -> Bool {
        var resultFlag = false
        
        let bindIndex = self.bindIndex(from: name)
        
        if bindIndex != NSNotFound {
            resultFlag = try self.bind(numberValue: numberValue, at: bindIndex)
        }
        
        return resultFlag
    }
    
    func bind(value: Any, at index: Int, copied: Bool) throws -> Bool {
        var resultFlag = false
        
        if let stringValue = value as? String {
            resultFlag = try self.bind(stringValue: stringValue, at: index, copied: copied)
        } else if let numberValue = value as? NSNumber {
            resultFlag = try self.bind(numberValue: numberValue, at: index)
        } else if let dataValue = value as? Data {
            resultFlag = try self.bind(data: dataValue, at: index, copied: copied)
        } else if let dataValue = value as? NSData {
            let data = Data.init(referencing: dataValue)
            resultFlag = try self.bind(data: data, at: index, copied: copied)
        } else if let _ = value as? NSNull {
            resultFlag = try self.bindNullValue(at: index)
        } else {
            let error = ACError.init(errorMessage: "Value type not support", errorDetailDescription: "", userInfo: nil)
            
            throw error
        }
        
        return resultFlag
    }
    
    func bind(value: Any, for name: String, copied: Bool) throws -> Bool {
        var resultFlag = false
        
        let bindIndex = self.bindIndex(from: name)
        
        if bindIndex != NSNotFound {
            resultFlag = try self.bind(value: value, at: bindIndex, copied: copied)
        }
        
        return resultFlag
    }
    
    func bind(dictValue: [String : Any], copied: Bool) throws -> Bool {
        var resultFlag = true
        
        for key in dictValue.keys {
            if let value = dictValue[key] {
                resultFlag = try self.bind(value: value, for: key, copied: copied)
                
                if !resultFlag {
                    break
                }
            } else {
                resultFlag = false
                break
            }
        }
        
        return resultFlag
    }
}

// MARK: -
extension ACSQLiteStatement {
    func data(at index: Int) throws -> Data? {
        var data: Data? = nil
        
        guard let sqlite_stmt = sqlite3_stmt else {
            let error = ACError.init(domain: ACError.sqliteCodeErrorDomain,
                                     code: nil,
                                     errorMessage: "Get data value failed, SQLite Statement is null.")
            throw error
        }
        
        if let numberOfBytes = sqlite3_column_blob(sqlite_stmt, Int32(index)) {
            
            let bytes = sqlite3_column_bytes(sqlite_stmt, Int32(index))
            
            data = CreateSQLiteData(bytes: numberOfBytes, count: Int(bytes))
        } else {
            if let sqlite = sqlite3_db_handle(sqlite_stmt), let error = CreateACSQLiteError(sqlite) {
                throw error
            }
        }
        
        return data
    }
    
    func double(at index: Int) throws -> Double {
        var doubleValue: Double = 0
        
        guard let sqlite_stmt = sqlite3_stmt else {
            let error = ACError.init(domain: ACError.sqliteCodeErrorDomain,
                                     code: nil,
                                     errorMessage: "Get double value failed, SQLite Statement is null.")
            throw error
        }
        
        doubleValue = sqlite3_column_double(sqlite_stmt, Int32(index))
        
        if doubleValue == 0 {
            if let sqlite = sqlite3_db_handle(sqlite_stmt), let error = CreateACSQLiteError(sqlite) {
                throw error
            }
        }
        
        return doubleValue
    }
    
    func int(at index: Int) throws -> Int {
        var intValue: Int = 0
        
        intValue = 0
        
        guard let sqlite_stmt = sqlite3_stmt else {
            let error = ACError.init(domain: ACError.sqliteCodeErrorDomain,
                                     code: nil,
                                     errorMessage: "Get int value failed, SQLite Statement is null.")
            throw error
        }
        
        intValue = Int(sqlite3_column_int(sqlite_stmt, Int32(index)))
        
        if intValue == 0 {
            if let sqlite = sqlite3_db_handle(sqlite_stmt), let error = CreateACSQLiteError(sqlite) {
                throw error
            }
        }
        
        
        return intValue
    }
    
    func int64(at index: Int) throws -> Int64 {
        var int64Value: Int64 = 0
        
        guard let sqlite_stmt = sqlite3_stmt else {
            let error = ACError.init(domain: ACError.sqliteCodeErrorDomain,
                                     code: nil,
                                     errorMessage: "Get int64 value failed, SQLite Statement is null.")
            throw error
        }
        
        int64Value = sqlite3_column_int64(sqlite_stmt, Int32(index))
        
        if int64Value == 0 {
            if let sqlite = sqlite3_db_handle(sqlite_stmt), let error = CreateACSQLiteError(sqlite) {
                throw error
            }
        }
        
        
        return int64Value
    }
    
    func string(at index: Int) throws -> String? {
        var stringValue: String? = nil
        
        guard let sqlite_stmt = sqlite3_stmt else {
            let error = ACError.init(domain: ACError.sqliteCodeErrorDomain,
                                     code: nil,
                                     errorMessage: "Get string value failed, SQLite Statement is null.")
            throw error
        }
        
        if let stringPointer = sqlite3_column_text(sqlite_stmt, Int32(index)) {
            stringValue = String(cString: stringPointer)
        } else {
            if let sqlite = sqlite3_db_handle(sqlite_stmt), let error = CreateACSQLiteError(sqlite) {
                throw error
            }
        }
        
        return stringValue
    }
    
    func dataType(at index: Int) throws -> ACSQLiteDataType {
        var dataType = ACSQLiteDataType.integer
        
        guard let sqlite_stmt = sqlite3_stmt else {
            let error = ACError.init(domain: ACError.sqliteCodeErrorDomain,
                                     code: nil,
                                     errorMessage: "Get data type failed, SQLite Statement is null.")
            throw error
        }
        
        let typeValue = sqlite3_column_type(sqlite_stmt, Int32(index))
        
        dataType = ACSQLiteDataType(typeValue)
        
        if !ACSQLiteDataTypeIsValid(dataType: dataType) {
            if let sqlite = sqlite3_db_handle(sqlite_stmt), let error = CreateACSQLiteError(sqlite) {
                throw error
            } else {
                let error = ACError.init(domain: ACError.sqliteCodeErrorDomain,
                                         code: nil,
                                         errorMessage: "Unvalid data type.")
                throw error
            }
        }
        
        return dataType
    }
    
    func object(at index: Int) throws -> Any? {
        var obj: Any? = nil
        
        obj = nil
        let dataType = try self.dataType(at: index)
        
        var error: ACError? = nil
        
        if ACSQLiteDataTypeIsValid(dataType: dataType) {
            switch dataType {
            case .integer:
                obj = try self.int(at: index)
            case .double:
                obj = try self.double(at: index)
            case .string:
                obj = try self.string(at: index)
            case .data:
                obj = try self.data(at: index)
            case .null:
                obj = NSNull()
            default:
                error = ACError.init(domain: ACError.sqliteCodeErrorDomain, code: nil, errorMessage: "Unvalid data type.")
            }
        } else {
            error = ACError.init(domain: ACError.sqliteCodeErrorDomain, code: nil, errorMessage: "Unvalid data type.")
        }
        
        if let err = error {
            throw err
        }
        
        return obj
    }
    
    func values() throws -> [String : Any] {
        var values = [String : Any]()
        
        let numberOfColumns = self.columnCount()
        
        if numberOfColumns > 0 {
            var index = 0
            while index < numberOfColumns {
                if let columnName = try self.columnName(at: index), let value = try self.object(at: index) {
                    values.updateValue(value, forKey: columnName)
                }
                
                index += 1
            }
        } else {
            throw ACError.init(domain: nil, code: nil, errorMessage: nil)
        }
        
        return values
    }
}

// MARK: - Executing SQL Statement
extension ACSQLiteStatement {
    func executeNonQuery(bindValues: [String : Any]) throws -> Bool {
        let bindResult = try self.bind(dictValue: bindValues, copied: false)
        
        if !bindResult {
            return false
        }
        
        let resultCodeOrExtendedResultCode = try self.step()
        
        let resultCode = ACSQLiteResultCode(resultCodeOrExtendedResultCode.rawValue & 0xFF)
        
        var success = true
        
        if resultCode != .ok && resultCode != .row && resultCode != .done {
            success = false
        }
        
        return success
    }
    
    func executeScalar(bindValues: [String : Any]) throws {
        
    }
}
