//
//  ZoozPaymentMethod.h
//  Zooz
//
//  Created by Ronen Morecki on 9/21/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZoozPaymentMethodDetails.h"

@interface ZoozPaymentMethod : NSObject


@property (retain, nonatomic)NSDictionary * configuration;
@property (retain, nonatomic)NSString * paymentMethodType;
@property (retain, nonatomic)ZoozPaymentMethodDetails * paymentMethodDetails;



@end
