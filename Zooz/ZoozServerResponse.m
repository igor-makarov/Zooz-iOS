//
//  ZoozServerResponse.m
//  Zooz
//
//  Created by Ronen Morecki on 9/19/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import "ZoozServerResponse.h"
#import "ZoozDictionaryEx.h"

@implementation ZoozServerResponse

-(NSString *)description{
    if(self){
        NSDictionary * dict = [ZoozDictionaryEx dictionaryWithPropertiesOfObject:self];
        return [dict description];
    }
    return nil;
}

@end
