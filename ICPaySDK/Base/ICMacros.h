//
//  ICDebugLog.h
//  Pods
//
//  Created by iCorki on 2017/12/28.
//

#ifndef ICDebugLog_h
#define ICDebugLog_h

#if __OBJC__

#ifdef DEBUG
#define ICLog(...) NSLog(__VA_ARGS__)
#else
#define ICLog(...)
#endif

#ifndef ICAssert
#define ICAssert( condition, ... ) NSCAssert( (condition) , ##__VA_ARGS__)
#endif

#ifndef ICFailAssert
#define ICFailAssert( ... ) ICAssert( (NO) , ##__VA_ARGS__)
#endif


#ifndef ICParameterAssert
#define ICParameterAssert( condition ) ICAssert( (condition) , @"Invalid parameter not satisfying: %@", @#condition)
#endif // ICParameterAssert

#endif

#endif /* ICDebugLog_h */
