//
//  ICAssert.h
//  Pods
//
//  Created by iCorki on 2017/12/28.
//

#ifndef ICAssert_h
#define ICAssert_h

#ifndef ICAssert
#define ICAssert( condition, ... ) NSCAssert( (condition) , ##__VA_ARGS__)
#endif

#ifndef ICFailAssert
#define ICFailAssert( ... ) ICAssert( (NO) , ##__VA_ARGS__)
#endif


#ifndef ICParameterAssert
#define ICParameterAssert( condition ) ICAssert( (condition) , @"Invalid parameter not satisfying: %@", @#condition)
#endif // ICParameterAssert

#endif /* ICAssert_h */
