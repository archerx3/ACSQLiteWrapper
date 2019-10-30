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
