//
//  ZoozRisk.m
//  Zooz
//
//  Created by Rona Yadid on 11/16/15.
//  Copyright (c) 2015 Zooz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZoozRisk.h"
#import "ZoozRiskResult.h"

@interface ZoozRisk ()

@end

@implementation ZoozRisk

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"results"]) {
        NSArray * riskResultsJson = value;
        NSMutableArray * riskResultsMutable = [[NSMutableArray alloc]init];
        for (NSDictionary * json in riskResultsJson) {
            ZoozRiskResult * riskResult =[[ZoozRiskResult alloc] init];
            [riskResult setValuesForKeysWithDictionary:json];
            [riskResultsMutable addObject:riskResult];
        }
        self.results = riskResultsMutable;
    } else {
        [super setValue:value forKey:key];
    }
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //  NSLog(@"key = %@", key);
}

@end
