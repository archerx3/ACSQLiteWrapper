//
//  ACSQLiteURL.swift
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

private func TestFunc() {
    
}

func ACSQLiteCStringCreate(with url: URL?) -> UnsafePointer<CChar>? {
    var cString: UnsafePointer<CChar>? = nil
    
    let ccharStride = MemoryLayout<CChar>.stride
    
    let cStringPoint = UnsafeMutablePointer<CChar>.allocate(capacity: ccharStride)
    
    defer {
        cStringPoint.deallocate()
    }
    
    return cString
}

/**
 char *ACSQLiteCStringCreateWithCFURL(CFURLRef cfUrlRef)
 {
     char *cString = NULL;
     
     if (cfUrlRef)
     {
         CFURLRef cfAbsoluteURL = CFURLCopyAbsoluteURL(cfUrlRef);
         
         if (cfAbsoluteURL)
         {
             CFStringRef cfString = CFURLGetString(cfAbsoluteURL);
             
             if (cfString)
             {
                 CFIndex cfStringLenght = CFStringGetLength(cfString);
                 CFIndex cStringStringSize = CFStringGetMaximumSizeForEncoding(cfStringLenght, kCFStringEncodingUTF8) + 1;
                 
                 cString = (char *)malloc(cStringStringSize);
                 
                 if (cString)
                 {
                     Boolean success = CFStringGetCString(cfString, cString, cStringStringSize, kCFStringEncodingUTF8);
                     
                     if (!success)
                     {
                         free(cString);
                         cString = NULL;
                     }
                 }
                 
                 // We do not release cfString, because we get pointer.
             }
             
             CFRelease(cfAbsoluteURL);
             cfAbsoluteURL = NULL;
         }
     }
     
     return cString;
 }
*/

/**
 char *ACSQLiteCStringCreateWithNSURL(NSURL *nsUrl)
 {
     char *cString = ACSQLiteCStringCreateWithCFURL((__bridge CFURLRef)nsUrl);
     return cString;
 }
*/


/**
 NSURL *ACSQLiteNSURLCreateWithCString(const char *cString)
 {
     NSURL *nsURL = (__bridge NSURL *)ACSQLiteCFURLCreateWithCString(cString);
     return nsURL;
 }
 */
func ACSQLiteURLCreate(with cString: UnsafePointer<UInt8>?) -> URL? {
    var url: URL? = nil
    
    url = ACSQLiteCFURLCreate(with: cString) as URL?
    
    return url
}

/**
 CFURLRef ACSQLiteCFURLCreateWithCString(const char *cString)
 {
     CFURLRef cfUrlRef = nil;
     
     if (cString)
     {
         CFIndex cStringLength = strlen(cString);
         cfUrlRef = CFURLCreateWithBytes(kCFAllocatorDefault, (const UInt8 *)cString, cStringLength, kCFStringEncodingUTF8, nil);
     }
     
     return cfUrlRef;
 }
 */
private func ACSQLiteCFURLCreate(with cString: UnsafePointer<UInt8>?) -> CFURL? {
    var cfUrl: CFURL? = nil
    
    cfUrl = CFURLCreateWithBytes(kCFAllocatorDefault, cString, MemoryLayout<UInt8>.stride, CFStringBuiltInEncodings.UTF8.rawValue, nil)
    
    return cfUrl
}

