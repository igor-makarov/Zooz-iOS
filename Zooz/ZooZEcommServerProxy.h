//
//  ZooZServiceProxy.h
//  PayDemoApp
//
//  Created by Ronen Morecki on 6/28/11.
//  Copyright 2011 Tactusmobile.com. All rights reserved.
//

#import <Foundation/Foundation.h>


#define ERROR_CODE_USER_LOGIN_FAILED 3

@interface ZooZEcommServerProxy : NSObject {
	
}

+(NSData *)sendJsonToURL:(NSString *)serverURL data:(NSDictionary *)data programUniqueId:(NSString *)programId zoozToken:(NSString *) token;
+(NSData *)createLocalErrorResponse:(NSInteger)errorCode errorDescription:(NSString *)message;
@end
