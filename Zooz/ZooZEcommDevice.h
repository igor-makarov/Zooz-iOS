//
//  ZooZDevice.h
//  PayDemoApp
//
//  Created by Ronen Morecki on 9/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZooZEcommDevice : NSObject {

}

+(NSString *)getDeviceStamp;
+(NSString *)getAuthId;
+(BOOL)hasSK;
+(BOOL)hasSign;
+(NSString *)pk;
+(void)storePK:(NSString *)pk symKey:(NSString *)sym;
+(NSString *)encrypt:(NSString *)input;
+(void)resetToFirstTime;
+(NSString *) generateGuid;
+(NSString *)deviceAlternateUDID;
+(NSString *)udid;
+ (BOOL)isJB;
@end
