//
//  ZoozResponseObject.m
//  Zooz
//
//  Created by Ronen Morecki on 9/17/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import "ZoozEcommResponseObject.h"
#import "ZoozDictionaryEx.h"

@implementation ZoozEcommResponseObject


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
  //  NSLog(@"key = %@", key);
}



-(NSString *)description{
    if(self){
        NSDictionary * dict = [ZoozDictionaryEx dictionaryWithPropertiesOfObject:self];
        return [dict description];
    }
    return nil;
}
@end
