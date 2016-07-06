//
//  ZoozRiskResult.m
//  Zooz
//
//  Created by Rona Yadid on 11/16/15.
//  Copyright (c) 2015 Zooz. All rights reserved.
//

#import "ZoozRiskResult.h"

@interface ZoozRiskResult ()

@end

@implementation ZoozRiskResult

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        _riskDescription = value;
    } else {
        [super setValue:value forKey:key];
    }
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //  NSLog(@"key = %@", key);
}

@end
