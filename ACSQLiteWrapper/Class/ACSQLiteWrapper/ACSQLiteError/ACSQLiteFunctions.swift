//
//  ACSQLiteFunctions.swift
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

extension ACSQLite {
    func addFunction(functionName: String, argCount: Int, eTextRep: Int) {
//        guard let sqlite = sqlite3 else { return }
//
//        sqlite3_create_function_v2(sqlite, functionName, Int32(argCount), Int32(eTextRep), <#T##pApp: UnsafeMutableRawPointer!##UnsafeMutableRawPointer!#>, <#T##xFunc: ((OpaquePointer?, Int32, UnsafeMutablePointer<OpaquePointer?>?) -> Void)!##((OpaquePointer?, Int32, UnsafeMutablePointer<OpaquePointer?>?) -> Void)!##(OpaquePointer?, Int32, UnsafeMutablePointer<OpaquePointer?>?) -> Void#>, <#T##xStep: ((OpaquePointer?, Int32, UnsafeMutablePointer<OpaquePointer?>?) -> Void)!##((OpaquePointer?, Int32, UnsafeMutablePointer<OpaquePointer?>?) -> Void)!##(OpaquePointer?, Int32, UnsafeMutablePointer<OpaquePointer?>?) -> Void#>, <#T##xFinal: ((OpaquePointer?) -> Void)!##((OpaquePointer?) -> Void)!##(OpaquePointer?) -> Void#>, <#T##xDestroy: ((UnsafeMutableRawPointer?) -> Void)!##((UnsafeMutableRawPointer?) -> Void)!##(UnsafeMutableRawPointer?) -> Void#>)
    }
}

/**
void ac_sqlite3_string_has_suffix(sqlite3_context *context, int numberOfValues, sqlite3_value **values)
{
    // Validating the arguments.
    acCAssert(context, @"The context argument is nil.");
    acCAssert((numberOfValues == 2), @"The numberOfValues argument does not equal 2.");
    acCAssert(values, @"The values argument is nil.");
    
    // Getting the value of argumets.
    sqlite3_value *value0 = values[0];
    sqlite3_value *value1 = values[1];
    
    // Getting the C string for argument at 0 position.
    const char *string0 = (const char *)sqlite3_value_text(value0);
    acCAssert(string0, @"The function has a logical error.");
    
    // Getting the C string for argument at 1 position.
    const char *string1 = (const char *)sqlite3_value_text(value1);
    acCAssert(string1, @"The function has a logical error.");
    
    // Getting the length of strings.
    size_t string0Length = strlen(string0);
    size_t string1Length = strlen(string1);
    
    // Setting the default values.
    sqlite3_int64 result = 0;
    
    // We have the string 0 is equal or great than the string 1.
    if (string0Length >= string1Length)
    {
        // Comparing the substring 0 with the string 1.
        int result2 = memcmp((string0 + string0Length - string1Length), string1, string1Length);
        
        // Calculating the result of the comparison.
        result = (result2 == 0 ? 1ll : 0ll);
    }
    
    // Returning the result.
    sqlite3_result_int64(context, result);
}
*/

private func testAPI() {
//    sqlite3_create_function_v2(<#T##db: OpaquePointer!##OpaquePointer!#>, <#T##zFunctionName: UnsafePointer<Int8>!##UnsafePointer<Int8>!#>, <#T##nArg: Int32##Int32#>, <#T##eTextRep: Int32##Int32#>, <#T##pApp: UnsafeMutableRawPointer!##UnsafeMutableRawPointer!#>, <#T##xFunc: ((OpaquePointer?, Int32, UnsafeMutablePointer<OpaquePointer?>?) -> Void)!##((OpaquePointer?, Int32, UnsafeMutablePointer<OpaquePointer?>?) -> Void)!##(OpaquePointer?, Int32, UnsafeMutablePointer<OpaquePointer?>?) -> Void#>, <#T##xStep: ((OpaquePointer?, Int32, UnsafeMutablePointer<OpaquePointer?>?) -> Void)!##((OpaquePointer?, Int32, UnsafeMutablePointer<OpaquePointer?>?) -> Void)!##(OpaquePointer?, Int32, UnsafeMutablePointer<OpaquePointer?>?) -> Void#>, <#T##xFinal: ((OpaquePointer?) -> Void)!##((OpaquePointer?) -> Void)!##(OpaquePointer?) -> Void#>, <#T##xDestroy: ((UnsafeMutableRawPointer?) -> Void)!##((UnsafeMutableRawPointer?) -> Void)!##(UnsafeMutableRawPointer?) -> Void#>)
    
    /**
     OpaquePointer  -> Sqlite3
     zFunctionName  -> String
     nArg           -> Int32    < -1 for variadic functions >
     eTextRep       -> Int32    < (SQLITE_UTF8 | (pure ? SQLITE_DETERMINISTIC : 0)) >
     pApp           -> UnsafeMutableRawPointer!
     xFunc          -> ((OpaquePointer?, Int32, UnsafeMutablePoint<OpaquePointer?>?) -> Void)!
     xStep          -> ((OpaquePointer?, Int32, UnsafeMutablePoint<OpaquePointer?>?) -> Void)!
     xFinal         -> ((OpaquePointer?) -> Void)!
     xDestroy       -> ((UnsafeMutableRawPoint?) -> Void)!
     */
}

/**
void ac_sqlite3_string_contains_v2(sqlite3_context *context, int numberOfValues, sqlite3_value **values)
{
    // Validating the arguments.
    acCAssert(context, @"The context argument is nil.");
    acCAssert((numberOfValues == 2), @"The numberOfValues argument does not equal 2.");
    acCAssert(values, @"The values argument is nil.");
    
    // Getting the value of argumets.
    sqlite3_value *value0 = values[0];
    sqlite3_value *value1 = values[1];
    
    // Getting the C string for argument at 0 position.
    const char *string0 = (const char *)sqlite3_value_text(value0);
    acCAssert(string0, @"The function has a logical error.");
    
    // Getting the C string for argument at 1 position.
    const char *string1 = (const char *)sqlite3_value_text(value1);
    acCAssert(string1, @"The function has a logical error.");
    
    // Creating the CFString with the C string 0.
    CFStringRef stringRef0 = CFStringCreateWithCString(kCFAllocatorDefault, string0, kCFStringEncodingUTF8);
    acCAssert(stringRef0, @"Low memory.");
    
    // Creating the CFString with C string 1.
    CFStringRef stringRef1 = CFStringCreateWithCString(kCFAllocatorDefault, string1, kCFStringEncodingUTF8);
    acCAssert(stringRef1, @"Low memory.");
    
    if (!ACSQLite_ACSQLiteacACSQLite_CurrentLocaleRef)
    {
        // Getting the Singleton Synchronizer instance.
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        // Locking the critical section.
        @synchronized(singletonSynchronizer)
        {
            if (!ACSQLite_ACSQLiteacACSQLite_CurrentLocaleRef)
            {
                ACSQLite_ACSQLiteacACSQLite_CurrentLocaleRef = CFLocaleCopyCurrent();
                acCAssert(ACSQLite_ACSQLiteacACSQLite_CurrentLocaleRef, @"The function has a logical error.");
            }
        }
    }
    
    // Calculating the range to search.
    CFRange rangeToSearch;
    rangeToSearch.location = 0;
    rangeToSearch.length = CFStringGetLength(stringRef0);
    
    CFRange resultRange;
    
    // Searching the substring.
    Boolean result = CFStringFindWithOptionacndLocale(stringRef0, stringRef1, rangeToSearch, (kCFCompareCaseInsensitive | kCFCompareDiacriticInsensitive | kCFCompareWidthInsensitive), ACSQLite_ACSQLiteacACSQLite_CurrentLocaleRef, &resultRange);
    
    // Calculating the resul of the search.
    sqlite3_int64 result2 = (result ? 1ll : 0ll);
    
    // Releasing the string 0.
    CFRelease(stringRef0);
    stringRef0 = NULL;
    
    // Releasing the string 1.
    CFRelease(stringRef1);
    stringRef1 = NULL;
    
    // Returning the result.
    sqlite3_result_int64(context, result2);
}
*/

/**
void ac_sqlite3_generate_identifier(sqlite3_context *context, int numberOfValues, sqlite3_value **values)
{
    // Validating the arguments.
    acCAssert(context, @"The context argument is nil.");
    acCAssert((numberOfValues == 1), @"The numberOfValues argument does not equal 1.");
    acCAssert(values, @"The values argument is nil.");
    
    // Getting the accountUserIdentifier.
    sqlite3_int64 userIdentifierInt64 = 0ll;
    
    if (numberOfValues > 0)
    {
        // Getting the value of first arguments.
        sqlite3_value *value = values[0];
        
        // Getting the first position.
        userIdentifierInt64 = sqlite3_value_int64(value);
    }
    
    acCAssert((userIdentifierInt64 > 1), @"The accountUserIdentifier argument should be bigger than 0.");
    
    NSNumber * accountUserIdentifier = [NSNumber numbeACithLongLong:userIdentifierInt64];
    
    // Getting the acSQLite.
    acSQLite *sqlite = (__bridge acSQLite *)sqlite3_user_data(context);
    acCAssert(sqlite, @"The method has a logical error.");
    
    // Generating the new number.
    NSNumber *identifier = [sqlite copyacGenerateUniqueIdentifierInAccountUserIdentifier:accountUserIdentifier];
    sqlite3_int64 identifierInt64 = identifier.longLongValue;
    
    // Returning the number.
    sqlite3_result_int64(context, identifierInt64);
}
*/

/**
void ac_sqlite3_generate_number(sqlite3_context *context, int numberOfValues, sqlite3_value **values)
{
    // Validating the arguments.
    acCAssert(context, @"The context argument is nil.");
    acCAssert((numberOfValues == 0), @"The numberOfValues argument does not equal 0.");
    acCAssert(values, @"The values argument is nil.");
    
    // Getting the acSQLite.
    acSQLite *sqlite = (__bridge acSQLite *)sqlite3_user_data(context);
    acCAssert(sqlite, @"The method has a logical error.");
    
    // Generating the new number.
    NSNumber *number = [sqlite copyacGenerateNumber];
    sqlite3_int64 numberInt64 = number.longLongValue;
    
    // Returning the number.
    sqlite3_result_int64(context, numberInt64);
}
*/

/**
void ac_sqlite3_generate_start_position(sqlite3_context *context, int numberOfValues, sqlite3_value **values)
{
    // Validating the arguments.
    acCAssert(context, @"The context argument is nil.");
    acCAssert((numberOfValues == 0), @"The numberOfValues argument does not equal 0.");
    acCAssert(values, @"The values argument is nil.");
    
    // Getting the acSQLite.
    acSQLite *sqlite = (__bridge acSQLite *)sqlite3_user_data(context);
    acCAssert(sqlite, @"The method has a logical error.");
    
    // Generating the new position.
    NSNumber *position = [sqlite copyacGenerateStartPosition];
    sqlite3_int64 positionInt64 = position.longLongValue;
    
    // Returning the position.
    sqlite3_result_int64(context, positionInt64);
}
*/
 
/**
void ac_sqlite3_generate_end_position(sqlite3_context *context, int numberOfValues, sqlite3_value **values)
{
    // Validating the arguments.
    acCAssert(context, @"The context argument is nil.");
    acCAssert((numberOfValues == 0), @"The numberOfValues argument does not equal 0.");
    acCAssert(values, @"The values argument is nil.");
    
    // Getting the acSQLite.
    acSQLite *sqlite = (__bridge acSQLite *)sqlite3_user_data(context);
    acCAssert(sqlite, @"The method has a logical error.");
    
    // Generating the new position.
    NSNumber *position = [sqlite copyacGenerateEndPosition];
    sqlite3_int64 positionInt64 = position.longLongValue;
    
    // Returning the position.
    sqlite3_result_int64(context, positionInt64);
}
*/
 
/**
void ac_sqlite3_generate_auto_position(sqlite3_context *context, int numberOfValues, sqlite3_value **values)
{
    // Validating the arguments.
    acCAssert(context, @"The context argument is nil.");
    acCAssert(values, @"The values argument is nil.");
    
    // Getting the position.
    sqlite3_int64 positionInt64 = 0ll;
    
    if (numberOfValues > 0)
    {
        // Getting the value of first arguments.
        sqlite3_value *value = values[0];
        
        // Getting the first position.
        positionInt64 = sqlite3_value_int64(value);
    }
    
    for (int indexOfValue = 1; indexOfValue < numberOfValues; indexOfValue++)
    {
        // Getting the value of arguments.
        sqlite3_value *value = values[indexOfValue];
        
        // Getting the position.
        sqlite3_int64 position1Int64 = sqlite3_value_int64(value);
        
        // Getting the maximum position.
        positionInt64 = MAX(positionInt64, position1Int64);
    }
    
    // Getting the acSQLite.
    acSQLite *sqlite = (__bridge acSQLite *)sqlite3_user_data(context);
    acCAssert(sqlite, @"The method has a logical error.");
    
    // Generating the new position.
    
    if (positionInt64 < 0ll)
    {
        NSNumber *position = [sqlite copyacGenerateEndPosition];
        positionInt64 = position.longLongValue;
    }
    
    else if (positionInt64 >= 0ll)
    {
        NSNumber *position = [sqlite copyacGenerateStartPosition];
        positionInt64 = position.longLongValue;
    }
    
    // Returning the position.
    sqlite3_result_int64(context, positionInt64);
}
*/
 
/**
void ac_sqlite3_row_counter(sqlite3_context *context, int numberOfValues, sqlite3_value **values)
{
    // Validating the arguments.
    acCAssert(context, @"The context argument is nil.");
    acCAssert(((numberOfValues == 1) || (numberOfValues == 2)), @"The numberOfValues argument does not equal 1 or 2.");
    acCAssert(values, @"The values argument is nil.");
    
    // Getting the auxiliary values.
    sqlite3_int64 *auxiliaryValues = (sqlite3_int64 *)sqlite3_get_auxdata(context, 0);
    
    // We have the auxiliary values.
    if (auxiliaryValues)
    {
        // Incrementing the counter by the specified step.
        auxiliaryValues[0] += auxiliaryValues[1];
    }
    
    // We do not have the auxiliary values.
    else
    {
        // Allocating memoty for the auxiliary values.
        auxiliaryValues = (int64_t *)sqlite3_malloc(2 * sizeof(sqlite3_int64));
        
        // We have low memory.
        if (!auxiliaryValues)
        {
            // Returning the no memory error.
            sqlite3_result_error_nomem(context);
            return;
        }
        
        else
        {
            // Associating the auxiliary values with 0 argument.
            sqlite3_set_auxdata(context, 0, auxiliaryValues, sqlite3_free);
            
            // Getting the first value of the counter.
            sqlite3_value *value0 = values[0];
            auxiliaryValues[0] = sqlite3_value_int64(value0);
            
            // We have the specified step.
            if (numberOfValues == 2)
            {
                // Getting the specified step.
                sqlite3_value *value1 = values[1];
                auxiliaryValues[1] = sqlite3_value_int64(value1);
            }
            
            // We do not have the specified step.
            else
            {
                // Setting the default step.
                auxiliaryValues[1] = 1ll;
            }
        }
    }
    
    // Returning the result.
    sqlite3_result_int64(context, auxiliaryValues[0]);
}
*/
 
/**
void ac_sqlite3_enumerate_numbers_first_last(sqlite3_context *context, int numberOfValues, sqlite3_value **values)
{
    // Validating the arguments.
    acCAssert(context, @"The context argument is nil.");
    acCAssert(((numberOfValues == 2) || (numberOfValues == 3)), @"The numberOfValues argument does not equal 2.");
    acCAssert(values, @"The values argument is nil.");
    
    // Getting the auxiliary values.
    sqlite3_int64 *auxiliaryValues = (sqlite3_int64 *)sqlite3_get_auxdata(context, 0);
    
    // We have the auxiliary values
    if (auxiliaryValues)
    {
        // We have the increment.
        if (auxiliaryValues[2] >=  0ll)
        {
            // We have the next step.
            if ((auxiliaryValues[0] + auxiliaryValues[2]) <= auxiliaryValues[1])
            {
                auxiliaryValues[0] += auxiliaryValues[2];
            }
            
            // We do not have the next step.
            else
            {
                // Returning the error.
                sqlite3_result_error(context, "The ac_enumerate_numbers_first_last is finished", -1);
                return;
            }
        }
        
        // We have the decrement.
        // auxiliaryValues[2] <  0ll
        else
        {
            // We have the next step.
            if ((auxiliaryValues[0] + auxiliaryValues[2]) >= auxiliaryValues[1])
            {
                auxiliaryValues[0] += auxiliaryValues[2];
            }
            
            // We do not have the next step.
            else
            {
                // Returning the error.
                sqlite3_result_error(context, "The ac_enumerate_numbers_first_last is finished", -1);
                return;
            }
        }
    }
    
    // We do not have the auxiliary values.
    else
    {
        // Allocating memoty for the auxiliary values.
        auxiliaryValues = (int64_t *)sqlite3_malloc(3 * sizeof(sqlite3_int64));
        
        // We have low memory.
        if (!auxiliaryValues)
        {
            // Returning the no memory error.
            sqlite3_result_error_nomem(context);
            return;
        }
        
        else
        {
            // Associating the auxiliary values with 0 argument.
            sqlite3_set_auxdata(context, 0, auxiliaryValues, sqlite3_free);
            
            // Getting the first and second values of the enumerator.
            sqlite3_value *value0 = values[0];
            auxiliaryValues[0] = sqlite3_value_int64(value0);
            sqlite3_value *value1 = values[1];
            auxiliaryValues[1] = sqlite3_value_int64(value1);
            
            // We have the specified step.
            if (numberOfValues == 3)
            {
                // Getting the specified step.
                sqlite3_value *value2 = values[2];
                auxiliaryValues[2] = sqlite3_value_int64(value2);
            }
            
            // We do not have the specified step.
            else
            {
                // We have the increment.
                if (auxiliaryValues[0] <= auxiliaryValues[1])
                {
                    // Setting the default step.
                    auxiliaryValues[2] = 1ll;
                }
                
                // We have the decrement.
                // if (auxiliaryValues[0] > auxiliaryValues[1])
                else
                {
                    // Setting the default step.
                    auxiliaryValues[2] = -1ll;
                }
            }
            
            // We have the increment.
            if (auxiliaryValues[2] >=  0ll)
            {
                // We do not have the next step.
                if (!(auxiliaryValues[0] <= auxiliaryValues[1]))
                {
                    // Returning the error.
                    sqlite3_result_error(context, "The ac_enumerate_numbers_first_last is finished", -1);
                    return;
                }
            }
            
            // We have the decrement.
            // if (auxiliaryValues[2] <  0ll)
            else
            {
                // We do not have the next step.
                if (!(auxiliaryValues[0] >= auxiliaryValues[1]))
                {
                    // Returning the error.
                    sqlite3_result_error(context, "The ac_enumerate_numbers_first_last is finished", -1);
                    return;
                }
            }
        }
    }
    
    // Returning the result.
    sqlite3_result_int64(context, auxiliaryValues[0]);
}
*/

/**
void ac_sqlite3_enumerate_numbers_from_to(sqlite3_context *context, int numberOfValues, sqlite3_value **values)
{
    // Validating the arguments.
    acCAssert(context, @"The context argument is nil.");
    acCAssert(((numberOfValues == 2) || (numberOfValues == 3)), @"The numberOfValues argument does not equal 2.");
    acCAssert(values, @"The values argument is nil.");
    
    // Getting the auxiliary values.
    sqlite3_int64 *auxiliaryValues = (sqlite3_int64 *)sqlite3_get_auxdata(context, 0);
    
    // We have the auxiliary values
    if (auxiliaryValues)
    {
        // We have the increment.
        if (auxiliaryValues[2] >=  0ll)
        {
            // We have the next step.
            if ((auxiliaryValues[0] + auxiliaryValues[2]) < auxiliaryValues[1])
            {
                auxiliaryValues[0] += auxiliaryValues[2];
            }
            
            // We do not have the next step.
            else
            {
                // Returning the error.
                sqlite3_result_error(context, "The ac_enumerate_numbers_from_to is finished", -1);
                return;
            }
        }
        
        // We have the decrement.
        // auxiliaryValues[2] <  0ll
        else
        {
            // We have the next step.
            if ((auxiliaryValues[0] + auxiliaryValues[2]) > auxiliaryValues[1])
            {
                auxiliaryValues[0] += auxiliaryValues[2];
            }
            
            // We do not have the next step.
            else
            {
                // Returning the error.
                sqlite3_result_error(context, "The ac_enumerate_numbers_from_to is finished", -1);
                return;
            }
        }
    }
    
    // We do not have the auxiliary values.
    else
    {
        // Allocating memoty for the auxiliary values.
        auxiliaryValues = (int64_t *)sqlite3_malloc(3 * sizeof(sqlite3_int64));
        
        // We have low memory.
        if (!auxiliaryValues)
        {
            // Returning the no memory error.
            sqlite3_result_error_nomem(context);
            return;
        }
        
        else
        {
            // Associating the auxiliary values with 0 argument.
            sqlite3_set_auxdata(context, 0, auxiliaryValues, sqlite3_free);
            
            // Getting the first and second values of the enumerator.
            sqlite3_value *value0 = values[0];
            auxiliaryValues[0] = sqlite3_value_int64(value0);
            sqlite3_value *value1 = values[1];
            auxiliaryValues[1] = sqlite3_value_int64(value1);
            
            // We have the specified step.
            if (numberOfValues == 3)
            {
                // Getting the specified step.
                sqlite3_value *value2 = values[2];
                auxiliaryValues[2] = sqlite3_value_int64(value2);
            }
            
            // We do not have the specified step.
            else
            {
                // We have the increment.
                if (auxiliaryValues[0] <= auxiliaryValues[1])
                {
                    // Setting the default step.
                    auxiliaryValues[2] = 1ll;
                }
                
                // We have the decrement.
                // if (auxiliaryValues[0] > auxiliaryValues[1])
                else
                {
                    // Setting the default step.
                    auxiliaryValues[2] = -1ll;
                }
            }
            
            // We have the increment.
            if (auxiliaryValues[2] >=  0ll)
            {
                // We do not have the next step.
                if (!(auxiliaryValues[0] < auxiliaryValues[1]))
                {
                    // Returning the error.
                    sqlite3_result_error(context, "The ac_enumerate_numbers_from_to is finished", -1);
                    return;
                }
            }
            
            // We have the decrement.
            // if (auxiliaryValues[2] <  0ll)
            else
            {
                // We do not have the next step.
                if (!(auxiliaryValues[0] > auxiliaryValues[1]))
                {
                    // Returning the error.
                    sqlite3_result_error(context, "The ac_enumerate_numbers_from_to is finished", -1);
                    return;
                }
            }
        }
    }
    
    // Returning the result.
    sqlite3_result_int64(context, auxiliaryValues[0]);
}
*/
 
/**
void ac_sqlite3_math_mod(sqlite3_context *context, int numberOfValues, sqlite3_value **values)
{
    // Validating the arguments.
    acCAssert(context, @"The context argument is nil.");
    acCAssert(((numberOfValues == 1) || (numberOfValues == 2)), @"The numberOfValues argument does not equal 1 or 2.");
    acCAssert(values, @"The values argument is nil.");
    
    // Getting the auxiliary values.
    sqlite3_int64 *auxiliaryValues = (sqlite3_int64 *)sqlite3_get_auxdata(context, 0);
    
    // We have the auxiliary values.
    if (auxiliaryValues)
    {
        // Mod the counter by the specified number.
        auxiliaryValues[0] = auxiliaryValues[0] % auxiliaryValues[1];
    }
    
    // We do not have the auxiliary values.
    else
    {
        // Allocating memoty for the auxiliary values.
        auxiliaryValues = (int64_t *)sqlite3_malloc(2 * sizeof(sqlite3_int64));
        
        // We have low memory.
        if (!auxiliaryValues)
        {
            // Returning the no memory error.
            sqlite3_result_error_nomem(context);
            return;
        }
        
        else
        {
            // Associating the auxiliary values with 0 argument.
            sqlite3_set_auxdata(context, 0, auxiliaryValues, sqlite3_free);
            
            // Getting the first value of the counter.
            sqlite3_value *value0 = values[0];
            auxiliaryValues[0] = sqlite3_value_int64(value0);
            
            // We have the specified step.
            if (numberOfValues == 2)
            {
                // Getting the specified step.
                sqlite3_value *value1 = values[1];
                auxiliaryValues[1] = sqlite3_value_int64(value1);
            }
            
            // We do not have the specified step.
            else
            {
                // Setting the default step.
                auxiliaryValues[1] = 10ll;
            }
        }
    }
    
    // Returning the result.
    sqlite3_result_int64(context, auxiliaryValues[0]);
}
*/
 
/**
void ac_sqlite3_fileType_from_fileName(sqlite3_context *context, int numberOfValues, sqlite3_value **values)
{
    // Validating the arguments.
    acCAssert(context, @"The context argument is nil.");
    acCAssert((numberOfValues == 1), @"The numberOfValues argument does not equal 1.");
    acCAssert(values, @"The values argument is nil.");
    
    // Getting the value of argumets.
    sqlite3_value *value0 = values[0];
    
    // Getting the C string for argument at 0 position.
    const char *string0 = (const char *)sqlite3_value_text(value0);
    acCAssert(string0, @"The function has a logical error.");
    
    // Creating the CFString with the C string 0.
    NSString * extention = [NSString stringWithUTF8String:string0];
    acCAssert(extention, @"Low memory.");
    
    if ([extention rangeOfString:@"."].length != 0)
    {
        extention = [extention pathExtension];
    }
    
    if (!ACSQLite_ACSQLiteacACSQLite_CurrentLocaleRef)
    {
        // Getting the Singleton Synchronizer instance.
        NSObject *singletonSynchronizer = [NSObject singletonSynchronizer];
        
        // Locking the critical section.
        @synchronized(singletonSynchronizer)
        {
            if (!ACSQLite_ACSQLiteacACSQLite_CurrentLocaleRef)
            {
                ACSQLite_ACSQLiteacACSQLite_CurrentLocaleRef = CFLocaleCopyCurrent();
                acCAssert(ACSQLite_ACSQLiteacACSQLite_CurrentLocaleRef, @"The function has a logical error.");
            }
        }
    }
    
    acFileType fileType = acFileTypeFromFileExtension(extention);

    // Calculating the resul of the search.
    sqlite3_int64 result2 = (fileType ? fileType : 0ll);
    
    // Returning the result.
    sqlite3_result_int64(context, result2);
}
*/
 
/**
void ac_sqlite3_object_permission_has(sqlite3_context *context, int numberOfValues, sqlite3_value **values)
{
    // Validating the arguments.
    acCAssert(context, @"The context argument is nil.");
    acCAssert((numberOfValues == 2), @"The numberOfValues argument does not equal 2.");
    acCAssert(values, @"The values argument is nil.");
    
    // Getting the value of argumets.
    sqlite3_value *value0 = values[0];
    sqlite3_value *value1 = values[1];
    
    // Getting the C string for argument at 0 position.
    int64_t objectPermission = (int64_t)sqlite3_value_int64(value0);
    acCAssert(objectPermission, @"The function has a logical error.");
    
    // Getting the C string for argument at 1 position.
    int64_t permission = (int64_t)sqlite3_value_int64(value1);
    acCAssert(permission, @"The function has a logical error.");
   
    // Setting the default values.
    sqlite3_int64 result2 = (objectPermission & permission);
    
    // Calculating the result of the comparison.
    sqlite3_int64 result = (result2 > 0) ? 1ll : 0ll;
    
    // Returning the result.
    sqlite3_result_int64(context, result);
}
*/

// MARK: - GRDB Function
/**
/// An SQL function or aggregate.
public final class DatabaseFunction: Hashable {
    // SQLite identifies functions by (name + argument count)
    private struct Identity: Hashable {
        let name: String
        let nArg: Int32 // -1 for variadic functions
    }
    
    public var name: String { return identity.name }
    private let identity: Identity
    let pure: Bool
    private let kind: Kind
    private var eTextRep: Int32 { return (SQLITE_UTF8 | (pure ? SQLITE_DETERMINISTIC : 0)) }
    
    /// Returns an SQL function.
    ///
    ///     let fn = DatabaseFunction("succ", argumentCount: 1) { dbValues in
    ///         guard let int = Int.fromDatabaseValue(dbValues[0]) else {
    ///             return nil
    ///         }
    ///         return int + 1
    ///     }
    ///     db.add(function: fn)
    ///     try Int.fetchOne(db, sql: "SELECT succ(1)")! // 2
    ///
    /// - parameters:
    ///     - name: The function name.
    ///     - argumentCount: The number of arguments of the function. If
    ///       omitted, or nil, the function accepts any number of arguments.
    ///     - pure: Whether the function is "pure", which means that its results
    ///       only depends on its inputs. When a function is pure, SQLite has
    ///       the opportunity to perform additional optimizations. Default value
    ///       is false.
    ///     - function: A function that takes an array of DatabaseValue
    ///       arguments, and returns an optional DatabaseValueConvertible such
    ///       as Int, String, NSDate, etc. The array is guaranteed to have
    ///       exactly *argumentCount* elements, provided *argumentCount* is
    ///       not nil.
    public init(
        _ name: String,
        argumentCount: Int32? = nil,
        pure: Bool = false,
        function: @escaping ([DatabaseValue]) throws -> DatabaseValueConvertible?)
    {
        self.identity = Identity(name: name, nArg: argumentCount ?? -1)
        self.pure = pure
        self.kind = .function{ (argc, argv) in
            let arguments = (0..<Int(argc)).map { index in
                DatabaseValue(sqliteValue: argv.unsafelyUnwrapped[index]!)
            }
            return try function(arguments)
        }
    }
    
    /// Returns an SQL aggregate function.
    ///
    ///     struct MySum : DatabaseAggregate {
    ///         var sum: Int = 0
    ///
    ///         mutating func step(_ dbValues: [DatabaseValue]) {
    ///             if let int = Int.fromDatabaseValue(dbValues[0]) {
    ///                 sum += int
    ///             }
    ///         }
    ///
    ///         func finalize() -> DatabaseValueConvertible? {
    ///             return sum
    ///         }
    ///     }
    ///
    ///     let dbQueue = DatabaseQueue()
    ///     let fn = DatabaseFunction("mysum", argumentCount: 1, aggregate: MySum.self)
    ///     dbQueue.add(function: fn)
    ///     try dbQueue.write { db in
    ///         try db.execute(sql: "CREATE TABLE test(i)")
    ///         try db.execute(sql: "INSERT INTO test(i) VALUES (1)")
    ///         try db.execute(sql: "INSERT INTO test(i) VALUES (2)")
    ///         try Int.fetchOne(db, sql: "SELECT mysum(i) FROM test")! // 3
    ///     }
    ///
    /// - parameters:
    ///     - name: The function name.
    ///     - argumentCount: The number of arguments of the aggregate. If
    ///       omitted, or nil, the aggregate accepts any number of arguments.
    ///     - pure: Whether the aggregate is "pure", which means that its
    ///       results only depends on its inputs. When an aggregate is pure,
    ///       SQLite has the opportunity to perform additional optimizations.
    ///       Default value is false.
    ///     - aggregate: A type that implements the DatabaseAggregate protocol.
    ///       For each step of the aggregation, its `step` method is called with
    ///       an array of DatabaseValue arguments. The array is guaranteed to
    ///       have exactly *argumentCount* elements, provided *argumentCount* is
    ///       not nil.
    public init<Aggregate: DatabaseAggregate>(
        _ name: String,
        argumentCount: Int32? = nil,
        pure: Bool = false,
        aggregate: Aggregate.Type)
    {
        self.identity = Identity(name: name, nArg: argumentCount ?? -1)
        self.pure = pure
        self.kind = .aggregate { Aggregate() }
    }
    
    /// Calls sqlite3_create_function_v2
    /// See https://sqlite.org/c3ref/create_function.html
    func install(in db: Database) {
        // Retain the function definition
        let definition = kind.definition
        let definitionP = Unmanaged.passRetained(definition).toOpaque()
        
        let code = sqlite3_create_function_v2(
            db.sqliteConnection,
            identity.name,
            identity.nArg,
            eTextRep,
            definitionP,
            kind.xFunc,
            kind.xStep,
            kind.xFinal,
            { definitionP in
                // Release the function definition
                Unmanaged<AnyObject>.fromOpaque(definitionP!).release()
        })
        
        guard code == SQLITE_OK else {
            // Assume a GRDB bug: there is no point throwing any error.
            fatalError(DatabaseError(resultCode: code, message: db.lastErrorMessage).description)
        }
    }
    
    /// Calls sqlite3_create_function_v2
    /// See https://sqlite.org/c3ref/create_function.html
    func uninstall(in db: Database) {
        let code = sqlite3_create_function_v2(
            db.sqliteConnection,
            identity.name,
            identity.nArg,
            eTextRep,
            nil, nil, nil, nil, nil)
        
        guard code == SQLITE_OK else {
            // Assume a GRDB bug: there is no point throwing any error.
            fatalError(DatabaseError(resultCode: code, message: db.lastErrorMessage).description)
        }
    }
    
    /// The way to compute the result of a function.
    /// Feeds the `pApp` parameter of sqlite3_create_function_v2
    /// http://sqlite.org/capi3ref.html#sqlite3_create_function
    private class FunctionDefinition {
        let compute: (Int32, UnsafeMutablePointer<OpaquePointer?>?) throws -> DatabaseValueConvertible?
        init(compute: @escaping (Int32, UnsafeMutablePointer<OpaquePointer?>?) throws -> DatabaseValueConvertible?) {
            self.compute = compute
        }
    }
    
    /// The way to start an aggregate.
    /// Feeds the `pApp` parameter of sqlite3_create_function_v2
    /// http://sqlite.org/capi3ref.html#sqlite3_create_function
    private class AggregateDefinition {
        let makeAggregate: () -> DatabaseAggregate
        init(makeAggregate: @escaping () -> DatabaseAggregate) {
            self.makeAggregate = makeAggregate
        }
    }
    
    /// The current state of an aggregate, storable in SQLite
    private class AggregateContext {
        var aggregate: DatabaseAggregate
        var hasErrored = false
        init(aggregate: DatabaseAggregate) {
            self.aggregate = aggregate
        }
    }
    
    /// A function kind: an "SQL function" or an "aggregate".
    /// See http://sqlite.org/capi3ref.html#sqlite3_create_function
    private enum Kind {
        /// A regular function: SELECT f(1)
        case function((Int32, UnsafeMutablePointer<OpaquePointer?>?) throws -> DatabaseValueConvertible?)
        
        /// An aggregate: SELECT f(foo) FROM bar GROUP BY baz
        case aggregate(() -> DatabaseAggregate)
        
        /// Feeds the `pApp` parameter of sqlite3_create_function_v2
        /// http://sqlite.org/capi3ref.html#sqlite3_create_function
        var definition: AnyObject {
            switch self {
            case .function(let compute):
                return FunctionDefinition(compute: compute)
            case .aggregate(let makeAggregate):
                return AggregateDefinition(makeAggregate: makeAggregate)
            }
        }
        
        /// Feeds the `xFunc` parameter of sqlite3_create_function_v2
        /// http://sqlite.org/capi3ref.html#sqlite3_create_function
        var xFunc: (@convention(c) (OpaquePointer?, Int32, UnsafeMutablePointer<OpaquePointer?>?) -> Void)? {
            guard case .function = self else { return nil }
            return { (sqliteContext, argc, argv) in
                let definition = Unmanaged<FunctionDefinition>
                    .fromOpaque(sqlite3_user_data(sqliteContext))
                    .takeUnretainedValue()
                do {
                    try DatabaseFunction.report(
                        result: definition.compute(argc, argv),
                        in: sqliteContext)
                } catch {
                    DatabaseFunction.report(error: error, in: sqliteContext)
                }
            }
        }
        
        /// Feeds the `xStep` parameter of sqlite3_create_function_v2
        /// http://sqlite.org/capi3ref.html#sqlite3_create_function
        var xStep: (@convention(c) (OpaquePointer?, Int32, UnsafeMutablePointer<OpaquePointer?>?) -> Void)? {
            guard case .aggregate = self else { return nil }
            return { (sqliteContext, argc, argv) in
                let aggregateContextU = DatabaseFunction.unmanagedAggregateContext(sqliteContext)
                let aggregateContext = aggregateContextU.takeUnretainedValue()
                assert(!aggregateContext.hasErrored)
                do {
                    let arguments = (0..<Int(argc)).map { index in
                        DatabaseValue(sqliteValue: argv.unsafelyUnwrapped[index]!)
                    }
                    try aggregateContext.aggregate.step(arguments)
                } catch {
                    aggregateContext.hasErrored = true
                    DatabaseFunction.report(error: error, in: sqliteContext)
                }
            }
        }
        
        /// Feeds the `xFinal` parameter of sqlite3_create_function_v2
        /// http://sqlite.org/capi3ref.html#sqlite3_create_function
        var xFinal: (@convention(c) (OpaquePointer?) -> Void)? {
            guard case .aggregate = self else { return nil }
            return { (sqliteContext) in
                let aggregateContextU = DatabaseFunction.unmanagedAggregateContext(sqliteContext)
                let aggregateContext = aggregateContextU.takeUnretainedValue()
                aggregateContextU.release()
                
                guard !aggregateContext.hasErrored else {
                    return
                }
                
                do {
                    try DatabaseFunction.report(
                        result: aggregateContext.aggregate.finalize(),
                        in: sqliteContext)
                } catch {
                    DatabaseFunction.report(error: error, in: sqliteContext)
                }
            }
        }
    }
    
    /// Helper function that extracts the current state of an aggregate from an
    /// sqlite function execution context.
    ///
    /// The result must be released when the aggregate concludes.
    ///
    /// See https://sqlite.org/c3ref/context.html
    /// See https://sqlite.org/c3ref/aggregate_context.html
    private static func unmanagedAggregateContext(_ sqliteContext: OpaquePointer?) -> Unmanaged<AggregateContext> {
        // The current aggregate buffer
        let stride = MemoryLayout<Unmanaged<AggregateContext>>.stride
        let aggregateContextBufferP = UnsafeMutableRawBufferPointer(
            start: sqlite3_aggregate_context(sqliteContext, Int32(stride))!,
            count: stride)
        
        if aggregateContextBufferP.contains(where: { $0 != 0 }) { // TODO: This testt looks weird. Review.
            // Buffer contains non-null pointer: load aggregate context
            let aggregateContextP = aggregateContextBufferP
                .baseAddress!
                .assumingMemoryBound(to: Unmanaged<AggregateContext>.self)
            return aggregateContextP.pointee
        } else {
            // Buffer contains null pointer: create aggregate context...
            let aggregate = Unmanaged<AggregateDefinition>.fromOpaque(sqlite3_user_data(sqliteContext))
                .takeUnretainedValue()
                .makeAggregate()
            let aggregateContext = AggregateContext(aggregate: aggregate)
            
            // retain and store in SQLite's buffer
            let aggregateContextU = Unmanaged.passRetained(aggregateContext)
            let aggregateContextP = aggregateContextU.toOpaque()
            withUnsafeBytes(of: aggregateContextP) {
                aggregateContextBufferP.copyMemory(from: $0)
            }
            return aggregateContextU
        }
    }
    
    private static func report(result: DatabaseValueConvertible?, in sqliteContext: OpaquePointer?) {
        switch result?.databaseValue.storage ?? .null {
        case .null:
            sqlite3_result_null(sqliteContext)
        case .int64(let int64):
            sqlite3_result_int64(sqliteContext, int64)
        case .double(let double):
            sqlite3_result_double(sqliteContext, double)
        case .string(let string):
            sqlite3_result_text(sqliteContext, string, -1, SQLITE_TRANSIENT)
        case .blob(let data):
            #if swift(>=5.0)
            data.withUnsafeBytes {
                sqlite3_result_blob(sqliteContext, $0.baseAddress, Int32($0.count), SQLITE_TRANSIENT)
            }
            #else
            data.withUnsafeBytes {
                sqlite3_result_blob(sqliteContext, $0, Int32(data.count), SQLITE_TRANSIENT)
            }
            #endif
        }
    }
    
    private static func report(error: Error, in sqliteContext: OpaquePointer?) {
        if let error = error as? DatabaseError {
            if let message = error.message {
                sqlite3_result_error(sqliteContext, message, -1)
            }
            sqlite3_result_error_code(sqliteContext, error.extendedResultCode.rawValue)
        } else {
            sqlite3_result_error(sqliteContext, "\(error)", -1)
        }
    }
}

extension DatabaseFunction {
    /// :nodoc:
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identity)
    }
    
    /// Two functions are equal if they share the same name and arity.
    /// :nodoc:
    public static func == (lhs: DatabaseFunction, rhs: DatabaseFunction) -> Bool {
        return lhs.identity == rhs.identity
    }
}

/// The protocol for custom SQLite aggregates.
///
/// For example:
///
///     struct MySum : DatabaseAggregate {
///         var sum: Int = 0
///
///         mutating func step(_ dbValues: [DatabaseValue]) {
///             if let int = Int.fromDatabaseValue(dbValues[0]) {
///                 sum += int
///             }
///         }
///
///         func finalize() -> DatabaseValueConvertible? {
///             return sum
///         }
///     }
///
///     let dbQueue = DatabaseQueue()
///     let fn = DatabaseFunction("mysum", argumentCount: 1, aggregate: MySum.self)
///     dbQueue.add(function: fn)
///     try dbQueue.write { db in
///         try db.execute(sql: "CREATE TABLE test(i)")
///         try db.execute(sql: "INSERT INTO test(i) VALUES (1)")
///         try db.execute(sql: "INSERT INTO test(i) VALUES (2)")
///         try Int.fetchOne(db, sql: "SELECT mysum(i) FROM test")! // 3
///     }
public protocol DatabaseAggregate {
    /// Creates an aggregate.
    init()
    
    /// This method is called at each step of the aggregation.
    ///
    /// The dbValues argument contains as many values as given to the SQL
    /// aggregate function.
    ///
    ///    -- One value
    ///    SELECT maxLength(name) FROM player
    ///
    ///    -- Two values
    ///    SELECT maxFullNameLength(firstName, lastName) FROM player
    ///
    /// This method is never called after the finalize() method has been called.
    mutating func step(_ dbValues: [DatabaseValue]) throws
    
    /// Returns the final result
    func finalize() throws -> DatabaseValueConvertible?
}
 */
