//
//  ACSQLiteLimit.swift
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

struct ACSQLiteLimit: OptionSet {
    typealias RawValue = Int32
    
    let rawValue: RawValue
    
    init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    static let Length            = ACSQLiteLimit(rawValue: SQLITE_LIMIT_LENGTH)             //  0 /* The maximum size of any string or BLOB or table row) in bytes */
    static let SQLLength         = ACSQLiteLimit(rawValue: SQLITE_LIMIT_SQL_LENGTH)          //  1 /* The maximum length of an SQL statement) in bytes */
    static let Column            = ACSQLiteLimit(rawValue: SQLITE_LIMIT_COLUMN)              //  2 /* The maximum number of columns in a table definition or in the result set of a [SELECT] or the maximum number of columns in an index or in an ORDER BY or GROUP BY claus */
    static let ExpressionDepth   = ACSQLiteLimit(rawValue: SQLITE_LIMIT_EXPR_DEPTH)          //  3 /* The maximum depth of the parse tree on any  expression */
    static let CompoundSelect    = ACSQLiteLimit(rawValue: SQLITE_LIMIT_COMPOUND_SELECT)     //  4 /* The maximum number of terms in a compound SELECT statement */
    static let VDBEOP            = ACSQLiteLimit(rawValue: SQLITE_LIMIT_VDBE_OP)             //  5 /* The maximum number of instructions in a virtual machine program used to implement an SQL statement.  This limit is not currently enforced) though that might be added in some future release of SQLite */
    static let FunctionArguments = ACSQLiteLimit(rawValue: SQLITE_LIMIT_FUNCTION_ARG)        //  6 /* The maximum number of arguments on a function */
    static let Attached          = ACSQLiteLimit(rawValue: SQLITE_LIMIT_ATTACHED)            //  7 /* The maximum number of [ATTACH | attached databases] */
    static let LikePatternLength = ACSQLiteLimit(rawValue: SQLITE_LIMIT_LIKE_PATTERN_LENGTH) //  8 /* The maximum length of the pattern argument to the [LIKE] or [GLOB] operators */
    static let VariableNumber    = ACSQLiteLimit(rawValue: SQLITE_LIMIT_VARIABLE_NUMBER)     //  9 /* The maximum index number of any [parameter] in an SQL statement */
    static let TriggerDapth      = ACSQLiteLimit(rawValue: SQLITE_LIMIT_TRIGGER_DEPTH)        // 10 /* The maximum depth of recursion for triggers */
}

