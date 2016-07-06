//  ZooZDevice.m
//  PayDemoApp
//
//  Created by Ronen Morecki on 9/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ZooZEcommDevice.h"
#import "ZooZEcommKeychainUtils.h"
#import "ZooZEcommCryptoUtils.h"

//#import <AdSupport/AdSupport.h>

#define KS_SERVICE_NAME @"Inapp-ZooZ"


@implementation ZooZEcommDevice


+ (NSString *) generateGuid {	
	CFUUIDRef uuid = CFUUIDCreate(NULL);	
	CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);	
	CFRelease(uuid);	
	//(NSString *) uuidStr ;
	return (NSString *) CFBridgingRelease(uuidStr);
} 

+(NSString *)getDeviceStamp{
	NSError * err = nil;
	NSString * sign = [ZooZEcommKeychainUtils getPasswordForUsername:@"zooz-sign" andServiceName:KS_SERVICE_NAME error:&err];
//	NSLog(@"yyyyyyy%@", sign);
	
	if(sign && [sign length] > 5){
        return sign;
	}
	
	
    sign = [ZooZEcommDevice generateGuid];
	err = nil;
	[ZooZEcommKeychainUtils storeUsername:@"zooz-sign" andPassword:sign forServiceName:KS_SERVICE_NAME updateExisting:YES error:&err];
	//  NSLog(sign);
	return sign;
}

+(BOOL)isJB {
	BOOL jailbroken = NO;
	NSString *cydiaPath = @"/Applications/Cydia.app";
	NSString *aptPath = @"/private/var/lib/apt/";
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
		jailbroken = YES;
	}
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
		jailbroken = YES;
	}
	
	return jailbroken;
}

+(BOOL)hasSign{
	UIPasteboard * pb = [UIPasteboard pasteboardWithName:@"zooz-do-not-delete" create:NO];
	return pb && pb.string;
}

+(NSString *)getAuthId{
	NSString *suffix= [[NSUserDefaults standardUserDefaults] stringForKey:@"zoozCustomBundleId"];
	NSString *bundle = [[NSBundle mainBundle] bundleIdentifier];
	
	if(suffix)
		return [NSString stringWithFormat:@"%@.%@", bundle, suffix];

	return bundle;
}

+(NSString *)deviceAlternateUDID{
	NSError * err = nil;
	NSString * did = [ZooZEcommKeychainUtils getPasswordForUsername:@"altUDID" andServiceName:KS_SERVICE_NAME error:&err];
	
	if(!did){
        did = [ZooZEcommDevice generateGuid];
		NSError * err2 = nil;
		[ZooZEcommKeychainUtils storeUsername:@"altUDID" andPassword:did forServiceName:KS_SERVICE_NAME updateExisting:NO error:&err2];
	}
	
	return did;
    
}


+(NSString *)udid{
	UIDevice * device = [UIDevice currentDevice];
	
	NSString * did = nil;
	if([device respondsToSelector:@selector(identifierForVendor)]){
	//	ASIdentifierManager * aim = [ASIdentifierManager sharedManager];
	
	//	if([aim isAdvertisingTrackingEnabled]){
	//		did =[NSString stringWithFormat:@"aim_%@", aim.advertisingIdentifier.UUIDString ];
	//	}else{
			did =[NSString stringWithFormat:@"vendor_%@", [device identifierForVendor].UUIDString] ;
	//	}
	}else{
		did  = [ZooZEcommDevice deviceAlternateUDID];
	}
	
	return did;
}

+(NSString *)pk{
	NSError * err = nil;
	NSString * sk = [ZooZEcommKeychainUtils getPasswordForUsername:@"sk.pgp" andServiceName:KS_SERVICE_NAME error:&err];
	NSString * pk = [ZooZEcommKeychainUtils getPasswordForUsername:@"private.pgp" andServiceName:KS_SERVICE_NAME error:&err];
	if(pk != nil)
		return [ZooZEcommCryptoUtils encrypt:pk key:sk];
	return nil;
}

+(NSString *)encrypt:(NSString *)input{
	NSError * err = nil;
	NSString * sk = [ZooZEcommKeychainUtils getPasswordForUsername:@"sk.pgp" andServiceName:KS_SERVICE_NAME error:&err];
//	NSLog(@"%@ %@ %@",sk, input, [ZooZCryptoUtils encrypt:input key:sk]);
	if(sk != nil)
		return [ZooZEcommCryptoUtils encrypt:input key:sk];
	else{
		NSLog(@"WARNING - missing zooz-sk");
		return input;
	}
}
+(void)resetToFirstTime{
	NSError * err = nil;
	//NSLog(@"debug debug debug %@", KS_SERVICE_NAME);
	[ZooZEcommKeychainUtils deleteItemForUsername:@"sk.pgp" andServiceName:KS_SERVICE_NAME error:&err];
	[ZooZEcommKeychainUtils deleteItemForUsername:@"zooz-sign" andServiceName:KS_SERVICE_NAME error:&err];
}

+(BOOL)hasSK{
	NSError * err = nil;
	NSString * sk = [ZooZEcommKeychainUtils getPasswordForUsername:@"sk.pgp" andServiceName:KS_SERVICE_NAME error:&err];
	return sk != nil;
}

+(void)storePK:(NSString *)pk symKey:(NSString *)sym{
	if(sym == nil)
		return;
	
	NSError * err = nil;
	[ZooZEcommKeychainUtils storeUsername:@"sk.pgp" andPassword:sym forServiceName:KS_SERVICE_NAME updateExisting:YES error:&err];
	if(pk)
		[ZooZEcommKeychainUtils storeUsername:@"private.pgp" andPassword:pk forServiceName:KS_SERVICE_NAME updateExisting:YES error:&err];
}

@end
