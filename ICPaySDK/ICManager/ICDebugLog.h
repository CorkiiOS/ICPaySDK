//
//  ICDebugLog.h
//  Pods
//
//  Created by iCorki on 2017/12/28.
//

#ifndef ICDebugLog_h
#define ICDebugLog_h

#ifdef DEBUG
#define ICLog(...) NSLog(__VA_ARGS__)
#else
#define ICLog(...)
#endif

#endif /* ICDebugLog_h */
