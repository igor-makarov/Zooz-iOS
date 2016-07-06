//
//  ZoozAddPaymentMethodResponse.m
//  Zooz
//
//  Created by Ronen Morecki on 9/17/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import "ZoozAddPaymentMethodResponse.h"
#import "ZoozRisk.h"


@interface ZoozAddPaymentMethodResponse ()

@end


@implementation ZoozAddPaymentMethodResponse

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"risk"]) {
        _risk = [[ZoozRisk alloc] init];
        [_risk setValuesForKeysWithDictionary:value];
    } else {
        [super setValue:value forKey:key];
    }
}

@end
