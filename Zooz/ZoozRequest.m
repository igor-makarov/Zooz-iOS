//
//  ZoozRequest.m
//  Zooz
//
//  Created by Ronen Morecki on 9/17/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import "ZoozRequest.h"

@interface ZoozRequest (){
    
}
-(ZoozEcommResponseObject *)parseInternalResponseObject: (NSDictionary *)internalResponseDict;

@end

@implementation ZoozRequest

-(ZoozServerResponse *)parseResponse:(NSDictionary *)dict{
    ZoozServerResponse * resp = [[ZoozServerResponse alloc] init];
    
    [resp setValue:[dict valueForKey: @"responseStatus"] forKey:@"responseStatus"] ;
     
    ZoozEcommResponseObject * internalResponse = [self parseInternalResponseObject: [dict valueForKey:@"responseObject"]];
    
    resp.responseObject = internalResponse;
    
    return resp;
    
}

-(ZoozEcommResponseObject *)parseInternalResponseObject: (NSDictionary *)internalResponseDict{
    NSAssert(NO, @"Subclasses need to overwrite this method");
    return nil;
}


@end
