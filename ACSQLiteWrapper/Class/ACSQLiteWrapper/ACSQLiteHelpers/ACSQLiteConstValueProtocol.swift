//
//  ACSQLiteConstValueProtocol.swift
//  ACSQLiteWrapper
//
//  Created by archer.chen on 10/15/19.
//  Copyright © 2019 AC. All rights reserved.
//

import Foundation

protocol ACSQLitePointValueProtocol {
    associatedtype PointType
    var pointValue: UnsafePointer<PointType> { get }
}

// MARK: -
extension String: ACSQLitePointValueProtocol {
    typealias PointType = String
    
    var pointValue: UnsafePointer<String> {
        return withUnsafePointer(to: self, { $0 })
    }
}

extension Double: ACSQLitePointValueProtocol {
    typealias PointType = Double
    
    var pointValue: UnsafePointer<Double> {
        return withUnsafePointer(to: self, { $0 })
    }
}

extension Int: ACSQLitePointValueProtocol {
    typealias PointType = Int
    
    var pointValue: UnsafePointer<Int> {
        return withUnsafePointer(to: self, { $0 })
    }
}

extension Int64: ACSQLitePointValueProtocol {
    typealias PointType = Int64
    
    var pointValue: UnsafePointer<Int64> {
        return withUnsafePointer(to: self, { $0 })
    }
}

extension Date: ACSQLitePointValueProtocol {
    typealias PointType = Date
    
    var pointValue: UnsafePointer<Date> {
        return withUnsafePointer(to: self, { $0 })
    }
}

