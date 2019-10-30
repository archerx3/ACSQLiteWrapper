//
//  ACSQLiteMutex.swift
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

struct ACSQLiteMutexType: OptionSet {
    typealias RawValue = Int32
    
    let rawValue: RawValue
    
    init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    static let Fast          = ACSQLiteMutexType(rawValue: SQLITE_MUTEX_FAST)          // 0
    static let Recursive     = ACSQLiteMutexType(rawValue: SQLITE_MUTEX_RECURSIVE)     // 1
    static let StaticMaster  = ACSQLiteMutexType(rawValue: SQLITE_MUTEX_STATIC_MASTER) // 2
    static let StaticMemory  = ACSQLiteMutexType(rawValue: SQLITE_MUTEX_STATIC_MEM)    // 3  /* sqlite3_malloc() */
    static let StaticMemory2 = ACSQLiteMutexType(rawValue: SQLITE_MUTEX_STATIC_MEM2)   // 4  /* NOT USED */
    static let StaticOpen    = ACSQLiteMutexType(rawValue: SQLITE_MUTEX_STATIC_OPEN)   // 4  /* sqlite3BtreeOpen() */
    static let StaticPRNG    = ACSQLiteMutexType(rawValue: SQLITE_MUTEX_STATIC_PRNG)   // 5  /* sqlite3_random() */
    static let StaticLRU     = ACSQLiteMutexType(rawValue: SQLITE_MUTEX_STATIC_LRU)    // 6  /* lru page list */
    static let StaticLRU2    = ACSQLiteMutexType(rawValue: SQLITE_MUTEX_STATIC_LRU2)   // 7  /* NOT USED */
    static let StaticPMEM    = ACSQLiteMutexType(rawValue: SQLITE_MUTEX_STATIC_PMEM)   // 7  /* sqlite3PageMalloc() */
}

func ACSQLiteMutexTypeIsValid(mutexType: ACSQLiteMutexType) -> Bool {
    var isValid = false
    
    if mutexType == .Fast ||
        mutexType == .Recursive ||
        mutexType == .StaticMaster ||
        mutexType == .StaticMemory ||
        mutexType == .StaticMemory2 ||
        mutexType == .StaticOpen ||
        mutexType == .StaticPRNG ||
        mutexType == .StaticLRU ||
        mutexType == .StaticLRU2 ||
        mutexType == .StaticPMEM {
        isValid = true
    }
    
    return isValid
}

func ACSQLiteMutexTypeIsStatic(mutexType: ACSQLiteMutexType) -> Bool {
    var isValid = false
    
    if mutexType == .StaticMaster ||
        mutexType == .StaticMemory ||
        mutexType == .StaticMemory2 ||
        mutexType == .StaticOpen ||
        mutexType == .StaticPRNG ||
        mutexType == .StaticLRU ||
        mutexType == .StaticLRU2 ||
        mutexType == .StaticPMEM {
        isValid = true
    }
    
    return isValid
}

typealias sqlite3_mutex = OpaquePointer

// MARK: -
class ACSQLiteMutex: NSObject {
    private (set) var needsFree = false
    
    private var _sqlite3_mutex: sqlite3_mutex? = nil
    private (set) var sqlite3_mutex: sqlite3_mutex? {
        set {
            if _sqlite3_mutex != newValue {
                _sqlite3_mutex = newValue
            }
        }
        get {
            return _sqlite3_mutex
        }
    }
    
    override init() {
        
    }
    
    init(sqliteMutex: sqlite3_mutex, needsFree: Bool) {
        super.init()
        
        _sqlite3_mutex = sqliteMutex
        self.needsFree = needsFree
    }
    
    init?(mutexType: ACSQLiteMutexType) {
        if let sqliteMutex: OpaquePointer = sqlite3_mutex_alloc(mutexType.rawValue) {
            super.init()
            
            _sqlite3_mutex = sqliteMutex
            
            let needsFree = !ACSQLiteMutexTypeIsStatic(mutexType: mutexType)
            
            self.needsFree = needsFree
            
            sqlite3_mutex_free(sqliteMutex)
            
        } else {
            return nil
        }
    }
    
    deinit {
        if needsFree {
            sqlite3_mutex_free(_sqlite3_mutex)
        }
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        var isEquel = false
        
        if let sqlMutx = _sqlite3_mutex, let newSqlMutx = object as? ACSQLiteMutex {
            if sqlMutx == newSqlMutx.sqlite3_mutex {
                isEquel = true
            }
        }
        
        return isEquel
    }
    
    override var hash: Int {
        if let sqlMutx = _sqlite3_mutex {
            return sqlMutx.hashValue
        } else {
            return 0
        }
    }
}

extension ACSQLiteMutex {
    func setSqlite3_mutex(newValue: sqlite3_mutex?) {
        setSqlite3_mutex(newValue: newValue, needsFree: true)
    }
    
    func setSqlite3_mutex(newValue: sqlite3_mutex?, needsFree: Bool) {
        if _sqlite3_mutex != newValue {
            _sqlite3_mutex = newValue
            self.needsFree = needsFree
        }
    }
}

extension ACSQLiteMutex {
    func enter() {
        guard let sqlMutx = _sqlite3_mutex else {
            return
        }
        
        sqlite3_mutex_enter(sqlMutx)
    }
    
    func `try`() -> Bool {
        var didEnter = false
        
        guard let sqlMutx = _sqlite3_mutex else {
            return didEnter
        }
        
        let result = sqlite3_mutex_try(sqlMutx)
        
        let resultCode = ACSQLiteResultCode.init(result)
        
        didEnter = (resultCode == .ok)
        
        return didEnter
    }
    
    func leave() {
        guard let sqlMutx = _sqlite3_mutex else {
            return
        }
        
        sqlite3_mutex_leave(sqlMutx)
    }
}

