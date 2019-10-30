//
//  ACSQLiteConstValue.swift
//  ACSQLiteWrapper
//
//  Created by archer.chen on 10/15/19.
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
 typedef NS_ENUM(int, ac_sqlite3_const_value_type)
 {
     ac_sqlite3_const_value_type_null = 0,
     ac_sqlite3_const_value_type_blob,
     ac_sqlite3_const_value_type_double,
     ac_sqlite3_const_value_type_int,
     ac_sqlite3_const_value_type_int64,
     ac_sqlite3_const_value_type_text,
     ac_sqlite3_const_value_type_zeroblob
 };

 typedef struct ac_sqlite3_const {
     const char *name;
     void (*nameFree)(void *);
     int valueType;
     union {
         const void    *pointerValue;
         double         doubleValue;
         int            intValue;
         sqlite3_int64  int64Value;
     } value;
     int valueLength;
     void (*valueFree)(void *);
 } ac_sqlite3_const_value;

 ac_sqlite3_const_value *ac_sqlite3_const_value__values = NULL;
 int                     ac_sqlite3_const_value__numberOfValues = 0;
 */

 /**
 void ac_sqlite3_print_all_const_values()
 {
     printf("ac_sqlite3_const_value__numberOfValues = %d\n", ac_sqlite3_const_value__numberOfValues);
     for (int indexOfConstValue = 0; indexOfConstValue < ac_sqlite3_const_value__numberOfValues; indexOfConstValue++)
     {
         ac_sqlite3_const_value constValue = ac_sqlite3_const_value__values[indexOfConstValue];
         
         if (constValue.valueType == ac_sqlite3_const_value_type_null)
         {
             printf("ac_sqlite3_const_value[%d]\n", indexOfConstValue);
             printf("ac_sqlite3_const_value[%d].name = %p %s\n", indexOfConstValue, constValue.name, constValue.name);
             printf("ac_sqlite3_const_value[%d].nameFree = %p\n", indexOfConstValue, constValue.nameFree);
             printf("ac_sqlite3_const_value[%d].valueType = null\n", indexOfConstValue);
         }
         
         else if (constValue.valueType == ac_sqlite3_const_value_type_blob)
         {
             printf("ac_sqlite3_const_value[%d]\n", indexOfConstValue);
             printf("ac_sqlite3_const_value[%d].name = %p %s\n", indexOfConstValue, constValue.name, constValue.name);
             printf("ac_sqlite3_const_value[%d].nameFree = %p\n", indexOfConstValue, constValue.nameFree);
             printf("ac_sqlite3_const_value[%d].valueType = blob\n", indexOfConstValue);
             printf("ac_sqlite3_const_value[%d].value.pointerValue = %p\n", indexOfConstValue, constValue.value.pointerValue);
             printf("ac_sqlite3_const_value[%d].valueLength = %d\n", indexOfConstValue, constValue.valueLength);
             printf("ac_sqlite3_const_value[%d].valueFree = %p\n", indexOfConstValue, constValue.valueFree);
         }
         
         else if (constValue.valueType == ac_sqlite3_const_value_type_double)
         {
             printf("ac_sqlite3_const_value[%d]\n", indexOfConstValue);
             printf("ac_sqlite3_const_value[%d].name = %p %s\n", indexOfConstValue, constValue.name, constValue.name);
             printf("ac_sqlite3_const_value[%d].nameFree = %p\n", indexOfConstValue, constValue.nameFree);
             printf("ac_sqlite3_const_value[%d].valueType = double\n", indexOfConstValue);
             printf("ac_sqlite3_const_value[%d].doubleValue = %f\n", indexOfConstValue, constValue.value.doubleValue);
         }
         
         else if (constValue.valueType == ac_sqlite3_const_value_type_int)
         {
             printf("ac_sqlite3_const_value[%d]\n", indexOfConstValue);
             printf("ac_sqlite3_const_value[%d].name = %p %s\n", indexOfConstValue, constValue.name, constValue.name);
             printf("ac_sqlite3_const_value[%d].nameFree = %p\n", indexOfConstValue, constValue.nameFree);
             printf("ac_sqlite3_const_value[%d].valueType = int\n", indexOfConstValue);
             printf("ac_sqlite3_const_value[%d].value.doubleValue = %d\n", indexOfConstValue, constValue.value.intValue);
         }
         
         else if (constValue.valueType == ac_sqlite3_const_value_type_int64)
         {
             printf("ac_sqlite3_const_value[%d]\n", indexOfConstValue);
             printf("ac_sqlite3_const_value[%d].name = %p %s\n", indexOfConstValue, constValue.name, constValue.name);
             printf("ac_sqlite3_const_value[%d].nameFree = %p\n", indexOfConstValue, constValue.nameFree);
             printf("ac_sqlite3_const_value[%d].valueType = int\n", indexOfConstValue);
             printf("ac_sqlite3_const_value[%d].value.int64Value = %lld\n", indexOfConstValue, constValue.value.int64Value);
         }
         
         else if (constValue.valueType == ac_sqlite3_const_value_type_text)
         {
             printf("ac_sqlite3_const_value[%d]\n", indexOfConstValue);
             printf("ac_sqlite3_const_value[%d].name = %p %s\n", indexOfConstValue, constValue.name, constValue.name);
             printf("ac_sqlite3_const_value[%d].nameFree = %p\n", indexOfConstValue, constValue.nameFree);
             printf("ac_sqlite3_const_value[%d].valueType = text\n", indexOfConstValue);
             printf("ac_sqlite3_const_value[%d].value.pointerValue = %p %s\n", indexOfConstValue, constValue.value.pointerValue, constValue.value.pointerValue);
             printf("ac_sqlite3_const_value[%d].valueFree = %p\n", indexOfConstValue, constValue.valueFree);
         }
         
         else if (constValue.valueType == ac_sqlite3_const_value_type_zeroblob)
         {
             printf("ac_sqlite3_const_value[%d]\n", indexOfConstValue);
             printf("ac_sqlite3_const_value[%d].name = %p %s\n", indexOfConstValue, constValue.name, constValue.name);
             printf("ac_sqlite3_const_value[%d].nameFree = %p\n", indexOfConstValue, constValue.nameFree);
             printf("ac_sqlite3_const_value[%d].valueType = zeroblob\n", indexOfConstValue);
             printf("ac_sqlite3_const_value[%d].valueLength = %d\n", indexOfConstValue, constValue.valueLength);
         }
         
         else
         {
             printf("ac_sqlite3_const_value[%d]\n", indexOfConstValue);
             printf("ac_sqlite3_const_value[%d].name = %p %s\n", indexOfConstValue, constValue.name, constValue.name);
             printf("ac_sqlite3_const_value[%d].nameFree = %p\n", indexOfConstValue, constValue.nameFree);
             printf("ac_sqlite3_const_value[%d].valueType = %d\n", indexOfConstValue, constValue.valueType);
         }
     }
 }
 */

 /**
 void ac_sqlite3_set_const_const_value(ac_sqlite3_const_value newConstValue)
 {
     acCAssert(newConstValue.name, @"The constValue argument is NULL.");
     acCAssert((strlen(newConstValue.name) > 0), @"The constValue argument is NULL.");
     
     int firstIndex = 0;
     int lastIndex = ac_sqlite3_const_value__numberOfValues - 1;
     int middleIndex = (firstIndex + lastIndex) / 2;
     int comparisonResult = 1;
     
     int indexOfConstValue = -1;
     
     //ac_sqlite3_print_all_const_values();
     //printf("\n");
     
     while (firstIndex <= lastIndex)
     {
         middleIndex = (firstIndex + lastIndex) / 2;
         
         comparisonResult = strcmp(ac_sqlite3_const_value__values[middleIndex].name, newConstValue.name);
         
         if (comparisonResult < 0)
         {
             firstIndex = middleIndex + 1;
         }
         
         else if (comparisonResult == 0)
         {
             indexOfConstValue = middleIndex;
             break;
         }
         
         else if (comparisonResult > 0)
         {
             lastIndex = middleIndex - 1;
         }
     }
     
     if (indexOfConstValue >= 0)
     {
         ac_sqlite3_const_value oldConstValue = ac_sqlite3_const_value__values[indexOfConstValue];
         
         if (oldConstValue.nameFree)
         {
             oldConstValue.nameFree((void *)oldConstValue.name);
         }
         
         if ((oldConstValue.valueType == ac_sqlite3_const_value_type_blob) ||
             (oldConstValue.valueType == ac_sqlite3_const_value_type_text))
         {
             if (oldConstValue.valueFree)
             {
                 oldConstValue.valueFree((void *)oldConstValue.value.pointerValue);
             }
         }
         
         ac_sqlite3_const_value__values[indexOfConstValue] = newConstValue;
     }
     
     else
     {
         if (comparisonResult < 0)
         {
             indexOfConstValue = middleIndex + 1;
         }
         
         else if (comparisonResult == 0)
         {
             indexOfConstValue = middleIndex;
         }
         
         else if (comparisonResult > 0)
         {
             indexOfConstValue = middleIndex;
         }
         
         int numberOfNewConstValues = ac_sqlite3_const_value__numberOfValues + 1;
         
         ac_sqlite3_const_value *newConstValues = (ac_sqlite3_const_value *)malloc(sizeof(ac_sqlite3_const_value) * numberOfNewConstValues);
         acCAssert(newConstValues, @"Low memory.");
         
         memcpy(newConstValues, ac_sqlite3_const_value__values, (sizeof(ac_sqlite3_const_value) * indexOfConstValue));
         newConstValues[indexOfConstValue] = newConstValue;
         memcpy((newConstValues + indexOfConstValue + 1), (ac_sqlite3_const_value__values + indexOfConstValue), (sizeof(ac_sqlite3_const_value) * (ac_sqlite3_const_value__numberOfValues - indexOfConstValue)));
         
         free(ac_sqlite3_const_value__values);
         ac_sqlite3_const_value__values = newConstValues;
         ac_sqlite3_const_value__numberOfValues = numberOfNewConstValues;
     }
 }
 */

 /**
 void ac_sqlite3_set_const_blob(const char *name, void (*nameFree)(void *), const void *value, int length, void (*valueFree)(void *))
 {
     acCAssert(name, @"The name argument is NULL.");
     acCAssert((strlen(name) > 0), @"The name argument is invalid.");
     acCAssert(value, @"The value argument is NULL.");
     acCAssert((length >= 0), @"The length argument is invalid.");
     
     ac_sqlite3_const_value constValue;
     memset(&constValue, 0, sizeof(ac_sqlite3_const_value));
     
     constValue.name = name;
     constValue.nameFree = nameFree;
     constValue.valueType = ac_sqlite3_const_value_type_blob;
     constValue.value.pointerValue = value;
     constValue.valueLength = length;
     constValue.valueFree = valueFree;
     
     ac_sqlite3_set_const_const_value(constValue);
 }
 */

 /**
 void ac_sqlite3_set_const_double(const char *name, void (*nameFree)(void *), double value)
 {
     acCAssert(name, @"The name argument is NULL.");
     acCAssert((strlen(name) > 0), @"The name argument is invalid.");
     
     ac_sqlite3_const_value constValue;
     memset(&constValue, 0, sizeof(ac_sqlite3_const_value));
     
     constValue.name = name;
     constValue.nameFree = nameFree;
     constValue.valueType = ac_sqlite3_const_value_type_double;
     constValue.value.doubleValue = value;
     
     ac_sqlite3_set_const_const_value(constValue);
 }
 */

 /**
 void ac_sqlite3_set_const_int(const char *name, void (*nameFree)(void *), int value)
 {
     acCAssert(name, @"The name argument is NULL.");
     acCAssert((strlen(name) > 0), @"The name argument is invalid.");
     
     ac_sqlite3_const_value constValue;
     memset(&constValue, 0, sizeof(ac_sqlite3_const_value));
     
     constValue.name = name;
     constValue.nameFree = nameFree;
     constValue.valueType = ac_sqlite3_const_value_type_int;
     constValue.value.intValue = value;
     
     ac_sqlite3_set_const_const_value(constValue);
 }
 */

 /**
 void ac_sqlite3_set_const_int64(const char *name, void (*nameFree)(void *), sqlite3_int64 value)
 {
     acCAssert(name, @"The name argument is NULL.");
     acCAssert((strlen(name) > 0), @"The name argument is invalid.");
     
     ac_sqlite3_const_value constValue;
     memset(&constValue, 0, sizeof(ac_sqlite3_const_value));
     
     constValue.name = name;
     constValue.nameFree = nameFree;
     constValue.valueType = ac_sqlite3_const_value_type_int64;
     constValue.value.int64Value = value;
     
     ac_sqlite3_set_const_const_value(constValue);
 }
 */

 /**
 void ac_sqlite3_set_const_null(const char *name, void (*nameFree)(void *))
 {
     acCAssert(name, @"The name argument is NULL.");
     acCAssert((strlen(name) > 0), @"The name argument is invalid.");
     
     ac_sqlite3_const_value constValue;
     memset(&constValue, 0, sizeof(ac_sqlite3_const_value));
     
     constValue.name = name;
     constValue.nameFree = nameFree;
     constValue.valueType = ac_sqlite3_const_value_type_null;
     
     ac_sqlite3_set_const_const_value(constValue);
 }
 */

 /**
 void ac_sqlite3_set_const_text(const char *name, void (*nameFree)(void *), const void *value, void (*valueFree)(void *))
 {
     acCAssert(name, @"The name argument is NULL.");
     acCAssert((strlen(name) > 0), @"The name argument is invalid.");
     acCAssert(value, @"The value argument is NULL.");
     
     ac_sqlite3_const_value constValue;
     memset(&constValue, 0, sizeof(ac_sqlite3_const_value));
     
     constValue.name = name;
     constValue.nameFree = nameFree;
     constValue.valueType = ac_sqlite3_const_value_type_text;
     constValue.value.pointerValue = value;
     constValue.valueFree = valueFree;
     
     ac_sqlite3_set_const_const_value(constValue);
 }
 */

 /**
 void ac_sqlite3_set_const_zeroblob(const char *name, void (*nameFree)(void *), int length)
 {
     acCAssert(name, @"The name argument is NULL.");
     acCAssert((strlen(name) > 0), @"The name argument is invalid.");
     
     ac_sqlite3_const_value constValue;
     memset(&constValue, 0, sizeof(ac_sqlite3_const_value));
     
     constValue.name = name;
     constValue.nameFree = nameFree;
     constValue.valueType = ac_sqlite3_const_value_type_zeroblob;
     constValue.valueLength = length;
     
     ac_sqlite3_set_const_const_value(constValue);
 }
 */

 /**
 void ac_sqlite3_remove_const_name(const char *name)
 {
     acCAssert(name, @"The name argument is NULL.");
     
     int firstIndex = 0;
     int lastIndex = ac_sqlite3_const_value__numberOfValues - 1;
     
     int indexOfConstValue = -1;
     
     while (firstIndex <= lastIndex)
     {
         int middleIndex = (firstIndex + lastIndex) / 2;
         
         int comparisonResult = strcmp(ac_sqlite3_const_value__values[middleIndex].name, name);
         
         if (comparisonResult < 0)
         {
             firstIndex = middleIndex + 1;
         }
         
         else if (comparisonResult == 0)
         {
             indexOfConstValue = middleIndex;
             break;
         }
         
         else if (comparisonResult > 0)
         {
             lastIndex = middleIndex - 1;
         }
     }
     
     if (indexOfConstValue >= 0)
     {
         ac_sqlite3_const_value oldConstValue = ac_sqlite3_const_value__values[indexOfConstValue];
         
         if (oldConstValue.nameFree)
         {
             oldConstValue.nameFree((void *)oldConstValue.name);
         }
         
         if ((oldConstValue.valueType == ac_sqlite3_const_value_type_blob) ||
             (oldConstValue.valueType == ac_sqlite3_const_value_type_text))
         {
             if (oldConstValue.valueFree)
             {
                 oldConstValue.valueFree((void *)oldConstValue.value.pointerValue);
             }
         }
         
         int numberOfNewConstValues = ac_sqlite3_const_value__numberOfValues - 1;
         
         ac_sqlite3_const_value *newConstValues = (ac_sqlite3_const_value *)malloc(sizeof(ac_sqlite3_const_value) * numberOfNewConstValues);
         acCAssert(newConstValues, @"Low memory.");
         
         memcpy(newConstValues, ac_sqlite3_const_value__values, (sizeof(ac_sqlite3_const_value) * indexOfConstValue));
         memcpy((newConstValues + indexOfConstValue), (ac_sqlite3_const_value__values + indexOfConstValue + 1), (sizeof(ac_sqlite3_const_value) * (ac_sqlite3_const_value__numberOfValues - indexOfConstValue - 1)));
         
         free(ac_sqlite3_const_value__values);
         ac_sqlite3_const_value__values = newConstValues;
         ac_sqlite3_const_value__numberOfValues = numberOfNewConstValues;
     }
 }
 */

 /**
 void ac_sqlite3_remove_all_const_names()
 {
     for (int indexOfConstValue = 0; indexOfConstValue < ac_sqlite3_const_value__numberOfValues; indexOfConstValue++)
     {
         ac_sqlite3_const_value constValue = ac_sqlite3_const_value__values[indexOfConstValue];
         
         if (constValue.nameFree)
         {
             constValue.nameFree((void *)constValue.name);
         }
         
         if ((constValue.valueType == ac_sqlite3_const_value_type_blob) ||
             (constValue.valueType == ac_sqlite3_const_value_type_text))
         {
             if (constValue.valueFree)
             {
                 constValue.valueFree((void *)constValue.value.pointerValue);
             }
         }
     }
     
     free(ac_sqlite3_const_value__values);
     ac_sqlite3_const_value__values = NULL;
     ac_sqlite3_const_value__numberOfValues = 0;
 }
 */

 /**
 void ac_sqlite3_get_const_value(sqlite3_context *context, int numberOfValues, sqlite3_value **values)
 {
     // Validating the arguments.
     acCAssert(context, @"The context argument is nil.");
     acCAssert((numberOfValues == 1), @"The numberOfValues argument does not equal 1.");
     acCAssert(values, @"The values argument is nil.");
     
     // Getting the value of argumets.
     sqlite3_value *nameValue = values[0];
     
     // Getting the C string for argument nameValue.
     const char *cName = (const char *)sqlite3_value_text(nameValue);
     acCAssert(cName, @"The function has a logical error.");
     
     int firstIndex = 0;
     int lastIndex = ac_sqlite3_const_value__numberOfValues - 1;
     
     int indexOfConstValue = -1;
     
     while (firstIndex <= lastIndex)
     {
         int middleIndex = (firstIndex + lastIndex) / 2;
         
         int comparisonResult = strcmp(ac_sqlite3_const_value__values[middleIndex].name, cName);
         
         if (comparisonResult < 0)
         {
             firstIndex = middleIndex + 1;
         }
         
         else if (comparisonResult == 0)
         {
             indexOfConstValue = middleIndex;
             break;
         }
         
         else if (comparisonResult > 0)
         {
             lastIndex = middleIndex - 1;
         }
     }
     
     acCAssert((indexOfConstValue >= 0), @"The function has a logical error.");
     
     ac_sqlite3_const_value constValue = ac_sqlite3_const_value__values[indexOfConstValue];
     
     if (constValue.valueType == ac_sqlite3_const_value_type_null)
     {
         sqlite3_result_null(context);
     }
     
     else if (constValue.valueType == ac_sqlite3_const_value_type_blob)
     {
         sqlite3_result_blob(context, constValue.value.pointerValue, constValue.valueLength, constValue.valueFree);
     }
     
     else if (constValue.valueType == ac_sqlite3_const_value_type_double)
     {
         sqlite3_result_double(context, constValue.value.doubleValue);
     }
     
     else if (constValue.valueType == ac_sqlite3_const_value_type_int)
     {
         sqlite3_result_int(context, constValue.value.intValue);
     }
     
     else if (constValue.valueType == ac_sqlite3_const_value_type_int64)
     {
         sqlite3_result_int64(context, constValue.value.int64Value);
     }
     
     else if (constValue.valueType == ac_sqlite3_const_value_type_text)
     {
         sqlite3_result_text(context, (const char *)constValue.value.pointerValue, -1, constValue.valueFree);
     }
     
     else if (constValue.valueType == ac_sqlite3_const_value_type_zeroblob)
     {
         sqlite3_result_zeroblob(context, constValue.valueLength);
     }
     
     else
     {
         acCAbort(@"The function has a logical error.");
     }
 }
 */
