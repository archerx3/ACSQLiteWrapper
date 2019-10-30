//
//  ACSQLiteData.swift
//  ACSQLiteWrapper
//
//  Created by archer.chen on 10/11/19.
//  Copyright © 2019 AC. All rights reserved.
//

import Foundation

func CreateSQLiteData(bytes: UnsafeRawPointer?, count: Int) -> Data? {
    var data: Data? = nil
    
    if let dataBytes = bytes {
        data = Data.init(bytes: dataBytes, count: count)
    }
    
    return data
}
