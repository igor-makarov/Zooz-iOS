//
//  ZooZServiceProxy.m
//  PayDemoApp
//
//  Created by Ronen Morecki on 6/28/11.
//  Copyright 2011 Tactusmobile.com. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "ZooZEcommServerProxy.h"
#import "ZooZEcommDevice.h"
#import "ZooZEcommCryptoUtils.h"
#import "ZoozServerResponse.h"
#import "ZoozDictionaryEx.h"

#define SERVLET_URL @"/mobile/LibraryServlet"
#define IS_DEBUG NO
#define VERSION @"1.1"
#define PREFFERED_LANGUAGE [[NSLocale preferredLanguages] objectAtIndex:0]

#define USER_AGENT [NSString stringWithFormat:@"ZoozEcommiOSSDK/1.1/%@/%@ (%@; %@/%@)/iOS",[[NSBundle mainBundle] bundleIdentifier], [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"] ,[UIDevice currentDevice].model, [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion]
#define TIMEOUT_INTERVAL_DEFAULT 60

@implementation ZooZEcommServerProxy

static NSString * escapeHttpString(NSString *input){
	if(!input)
		return @"";
	
	//CFStringRef CFURLCreateStringByAddingPercentEscapes(CFAllocatorRef allocator, CFStringRef originalString, CFStringRef charactersToLeaveUnescaped, CFStringRef legalURLCharactersToBeEscaped, CFStringEncoding encoding);
	
	NSString * result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)input, NULL, CFSTR("/+=&"), kCFStringEncodingUTF8));
	return result;
}



+(NSString *)GUID{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSString * pad = [def stringForKey:@"ZooZTXGUIDS"];
    return pad;
}

+(void)increaseGUID{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSString * pad = [ZooZEcommDevice generateGuid];
    [def setObject:pad forKey:@"ZooZTXGUIDS"];
    [def synchronize];
}


+(NSString *)safeStringValue:(id)obj{
    if(!obj)
        return nil;
    
    if([obj respondsToSelector:@selector(stringValue)]){
        return [obj stringValue];
    }
    
    if([obj isKindOfClass:[NSString class]])
        return obj;
    
    return [NSString stringWithFormat:@"%@", obj];
}


+(NSDate *)dateFromMillis1970:(NSNumber *)millisObj{
    if(!millisObj)
        return nil;
    
    long long secs = [millisObj longLongValue] / 1000;
    return [NSDate dateWithTimeIntervalSince1970:secs];
}

+(NSString *)parseMonthYearDate:(NSDate *)date{
    if(!date)
        return nil;
    
    
    NSDateFormatter * format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"MM-yyyy"];
    //[format setTimeStyle:NSDateFormatterNoStyle];
    return [format stringFromDate:date];
}

+(NSString *)parseMonthYearDayDate:(NSDate *)date{
    if(!date)
        return nil;
    
    
    NSDateFormatter * format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"dd-MMM-yyyy"];
    //[format setTimeStyle:NSDateFormatterNoStyle];
    return [format stringFromDate:date];
}

+(NSData *)createLocalErrorResponse:(NSInteger)errorCode errorDescription:(NSString *)message{
    ZoozServerResponse *resp = [[ZoozServerResponse alloc] init];
    resp.responseStatus = -1;
    resp.responseObject = [[ZoozEcommResponseObject alloc] init];
    resp.responseObject.responseErrorCode = errorCode;
    resp.responseObject.errorDescription = message;
    NSDictionary *dict = [ZoozDictionaryEx dictionaryWithPropertiesOfObject:resp];
    
    NSError *error = nil;
    
    return [NSJSONSerialization dataWithJSONObject:dict options: kNilOptions error:&error];
}

+(NSData *)safeCallURL:(NSMutableURLRequest *)theRequest programUniqueId:(NSString *)programId zoozToken:(NSString *)token requestBodyString:(NSData *)theBody{
    
    
    
    //   if( IS_DEBUG) NSLog(@"Requesting URL: %@", [theRequest URL]);
    //	[[NSNotificationCenter defaultCenter] postNotificationName:@"ServerActivity" object:nil];
    
    NSString *udid = [ZooZEcommDevice udid];
    
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [theRequest setHTTPShouldHandleCookies:YES];
    [theRequest setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest setValue: USER_AGENT forHTTPHeaderField:@"User-Agent"];
    [theRequest setValue:@"JSon" forHTTPHeaderField:@"ZooZResponseType"];
    [theRequest setValue:programId forHTTPHeaderField:@"programId"];
    [theRequest setValue: token forHTTPHeaderField:@"ZooZ-Token"];
    [theRequest setValue:udid forHTTPHeaderField:@"ZooZ-UDID"];
    [theRequest setValue:[ZooZEcommDevice getDeviceStamp] forHTTPHeaderField:@"deviceSignature"];
    NSString *altUdid= [ZooZEcommDevice deviceAlternateUDID];
    [theRequest setValue: altUdid forHTTPHeaderField:@"ZooZ-AltUDID"];
    [theRequest setValue: @"Checkout API" forHTTPHeaderField:@"productType"];
    [theRequest setValue: @"applicationVersion" forHTTPHeaderField: VERSION];
    
    UIDevice * device = [UIDevice currentDevice];
    [theRequest setValue: @"devicePersonalizedName" forHTTPHeaderField: escapeHttpString(device.name)];
    
    
    
    //[theRequest setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    //	[theRequest setValue:@"115" forHTTPHeaderField:@"Keep-Alive"];
    //[headers setValue:@"gzip" forKey:@"Accepts-Encoding"];
    
    
    if(IS_DEBUG){
        NSString * datStr = [[NSString alloc] initWithData:theBody encoding:NSUTF8StringEncoding];
        NSLog(@"Request body=%@\nRequesting header=%@", datStr ,  [theRequest allHTTPHeaderFields]);
    }
    
    
    
    [theRequest setHTTPBody:theBody];
    
    NSError *error = nil;
    NSHTTPURLResponse * httpResponse = nil;
    
    
    NSData *dat = [NSURLConnection sendSynchronousRequest: theRequest returningResponse: &httpResponse error: &error];
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if(IS_DEBUG ) NSLog(@"%@",[httpResponse allHeaderFields]);
    //NSArray * cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:[httpResponse allHeaderFields] forURL:[theRequest URL]];
    
    if(error && [error userInfo]){
        
        NSData *response;
        
        NSLog(@"Network error: %@", [error userInfo]);
        response = [ZooZEcommServerProxy createLocalErrorResponse: 0x070103 errorDescription: @"There was a network error, please check your internet connection and server url"];
        
        return response;
    }
    
    
    
    
    if( IS_DEBUG){
        NSString * datStr = [[NSString alloc] initWithData:theBody encoding:NSUTF8StringEncoding];
        NSLog(@"Response: %@", datStr);
    }
    return dat;
}

+(NSMutableURLRequest *)createRequest:(NSString *)url timeout:(NSTimeInterval)timeoutSeconds useCache:(BOOL)useCache{
    NSURLRequestCachePolicy cachePolicy = (useCache)? NSURLRequestReloadRevalidatingCacheData : NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    NSMutableURLRequest * theRequest=(NSMutableURLRequest*)[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:cachePolicy timeoutInterval:timeoutSeconds];
    [theRequest setHTTPMethod:@"POST"];
    return theRequest;}


+(NSData *)safeCallURL:(NSString *)url programUniqueId:(NSString *)programId zoozToken:(NSString *) token timeout:(NSTimeInterval)timeoutSeconds useCache:(BOOL)useCache requestBody:(NSData *)theBody{
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSMutableURLRequest * theRequest=[ZooZEcommServerProxy createRequest:url timeout:timeoutSeconds useCache:useCache];
    
    return [ZooZEcommServerProxy safeCallURL:theRequest programUniqueId:programId zoozToken:token requestBodyString:theBody];
    
}


#pragma mark APIs section
///*
+(NSData *)sendJsonToURL:(NSString *)serverURL data:(NSDictionary *)data programUniqueId:(NSString *)programId zoozToken:(NSString *) token{
    
    @autoreleasepool {
        
        
        NSError * error = nil;
        NSData *json = [NSJSONSerialization dataWithJSONObject: data options:kNilOptions error:&error];
        
        NSData *response = [ZooZEcommServerProxy safeCallURL:serverURL programUniqueId:programId zoozToken:token timeout:TIMEOUT_INTERVAL_DEFAULT useCache:NO requestBody: json];
        
        return response;
    }
}

@end
