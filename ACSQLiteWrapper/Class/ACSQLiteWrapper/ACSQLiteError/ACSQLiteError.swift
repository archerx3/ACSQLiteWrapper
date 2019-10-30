//
//  ACSQLiteError.swift
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

// MARK: Craete ACSQLiteError from sqlite3 or ACSQLiteResultCode

func CreateACSQLiteError(_ sqlite: sqlite3?, errorMessage: String? = nil) -> ACSQLiteError? {
    var error: ACSQLiteError? = nil
    
    var errMsg: String? = errorMessage
    
    let resultCodeOrExtendedResultCode: ACSQLiteResultCode
    
    if let sql = sqlite {
        resultCodeOrExtendedResultCode = ACSQLiteResultCode(sqlite3_extended_errcode(sql))
        
        if let errMsgPointer = sqlite3_errmsg(sql) {
            errMsg = String.init(cString: errMsgPointer)
        } else if let errMsgPointer = sqlite3_errstr(Int32(resultCodeOrExtendedResultCode.rawValue)) {
            errMsg = String(cString: errMsgPointer)
        }
        
        let extendedResultCode: ACSQLiteResultCode = resultCodeOrExtendedResultCode
        
        let resultCode = ACSQLiteResultCode(extendedResultCode.rawValue & 0xFF)

        error = ACSQLiteError.init(resultCode: resultCode,
                                   extendedResultCode: extendedResultCode,
                                   errorMessage: errMsg)
    }
    
    return error
}

func CreateACSQLiteError(_ sqlite: sqlite3?, resultCodeOrExtendedResultCode: ACSQLiteResultCode) -> ACSQLiteError? {
    var error: ACSQLiteError? = nil
    
    var extendedResultCode: ACSQLiteResultCode = resultCodeOrExtendedResultCode
    
    let resultCode: ACSQLiteResultCode = ACSQLiteResultCode(extendedResultCode.rawValue & 0xFF)
    
    if resultCode != .ok && resultCode != .row && resultCode != .done {

        if (extendedResultCode == resultCode) && (sqlite != nil)
        {
            let extendedResultCode2 = ACSQLiteResultCode(sqlite3_extended_errcode(sqlite))
            
            if (extendedResultCode2.rawValue & 0xFF) == resultCode.rawValue
            {
                extendedResultCode = extendedResultCode2
            }
        }
        
        var errMsg: String? = nil
        
        if let sql = sqlite, let errMsgPointer = sqlite3_errmsg(sql) {
            errMsg = String.init(cString: errMsgPointer)
        } else if let cErrorMessage = sqlite3_errstr(Int32(extendedResultCode.rawValue)) {
            errMsg = String(cString: cErrorMessage)
        }
        
        error = ACSQLiteError.init(resultCode: resultCode,
                                   extendedResultCode: extendedResultCode,
                                   errorMessage: errMsg)
    }
    
    return error
}

func CreateACSQLiteError(resultCodeOrExtendedResultCode: ACSQLiteResultCode, errorMsg: String? = nil) -> ACSQLiteError? {
    var error: ACSQLiteError? = nil
    
    if resultCodeOrExtendedResultCode != .ok && resultCodeOrExtendedResultCode != .row && resultCodeOrExtendedResultCode != .done {
        let extendedResultCode = resultCodeOrExtendedResultCode
        let resultCode = ACSQLiteResultCode(extendedResultCode.rawValue & 0xFF)
        
        var errorMessage: String? = nil
        
        if let errMsg = errorMsg {
            errorMessage = errMsg
        } else if let cErrorMessage = sqlite3_errstr(Int32(extendedResultCode.rawValue)) {
            errorMessage = String(cString: cErrorMessage)
        }
        
        error = ACSQLiteError.init(resultCode: resultCode,
                                   extendedResultCode:
            extendedResultCode, errorMessage: errorMessage)
    }
    
    return error
}

// MARK: - ACSQLiteError
struct ACSQLiteError: Error {
    public let resultCode: ACSQLiteResultCode
    public let extendedResultCode: ACSQLiteResultCode
    
    public var errorMessage: String?
    
    // MARK: Initializers
    public init(resultCode: ACSQLiteResultCode, extendedResultCode: ACSQLiteResultCode, errorMessage: String? = nil) {
        
        self.resultCode = resultCode
        self.extendedResultCode = extendedResultCode
        
        self.errorMessage = errorMessage
    }
}

// MARK: ACError
struct ACError: Error {
    private (set) var domain: String? = nil
    
    private (set) var codeString: String = "-1"
    var code: Int {
        var codeValue: Int = -1
        
        if let code = Int(codeString) {
            codeValue = code
        }
        
        return codeValue
    }
    
    public var errorMessage: String? = nil
    public var errorDetailDescription: String? = nil
    
    public var userInfo: [String : Any]? = nil
    
    public init(domain: String? = nil, code: String? = nil, errorMessage: String? = nil) {
        self.domain = domain ?? ACError.errorDomain
        self.codeString = code ?? ACError.defaultErrorCode
        
        self.errorMessage = errorMessage
    }
    
    public init(domain: String? = nil, code: String? = nil, errorDetailDescription: String? = nil) {
        self.domain = domain ?? ACError.errorDomain
        self.codeString = code ?? ACError.defaultErrorCode
        
        self.errorDetailDescription = errorDetailDescription
    }
    
    public init(domain: String? = nil, code: String? = nil, userInfo: [String : Any]? = nil) {
        self.domain = domain ?? ACError.errorDomain
        self.codeString = code ?? ACError.defaultErrorCode
        
        self.userInfo = userInfo
    }
    
    public init(domain: String? = nil, code: String? = nil, errorMessage: String? = nil, errorDetailDescription: String? = nil, userInfo: [String : Any]? = nil) {
        self.domain = domain ?? ACError.errorDomain
        self.codeString = code ?? ACError.defaultErrorCode
        
        self.errorMessage = errorMessage
        self.errorDetailDescription = errorDetailDescription
        self.userInfo = userInfo
    }
}

extension ACError {
    public static var errorDomain: String { return "ACErrorDomain" }
    public static var sqliteCodeErrorDomain: String { return "ACSQLiteErrorDomain" }
    
    public static var defaultErrorMessage: String { return "Unknow Error" }
    public static var defaultErrorCode: String { return "-1" }
    
    public static let description = "ACErrorDescriptionKey"
    public static let detail = "ACDetailDescriptionKey"
}
