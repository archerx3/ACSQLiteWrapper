//
//  ACSQLiteConfigure.swift
//  ACSQLiteWrapper
//
//  Created by archer.chen on 10/11/19.
//  Copyright © 2019 AC. All rights reserved.
//

import Foundation

struct ACSQLiteLibraryThreadsafeMode: Equatable
{
    public let rawValue: Int
    
    // MARK: Threadsafe Modes
    
    public static let singleThread = ACSQLiteLibraryThreadsafeMode(0)
    public static let multiThread  = ACSQLiteLibraryThreadsafeMode(1)
    public static let serialized   = ACSQLiteLibraryThreadsafeMode(2)
    
    // MARK: Initializers
    
    public init(_ rawValue: Int)
    {
        self.rawValue = rawValue
    }
    
    public init(_ rawValue: Int32)
    {
        self.rawValue = Int(rawValue)
    }
    
    // MARK: Equatable
    
    public static func == (lhs: ACSQLiteLibraryThreadsafeMode, rhs: ACSQLiteLibraryThreadsafeMode) -> Bool
    {
        let isEqual: Bool = (lhs.rawValue == rhs.rawValue)
        
        return isEqual
    }
}
