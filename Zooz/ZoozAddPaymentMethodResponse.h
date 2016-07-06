//
//  ZoozAddPaymentMethodResponse.h
//  Zooz
//
//  Created by Ronen Morecki on 9/17/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZoozEcommResponseObject.h"
#import "ZoozRisk.h"


@interface ZoozAddPaymentMethodResponse : ZoozEcommResponseObject


@property(retain, nonatomic) NSString * paymentMethodToken;
@property(retain, nonatomic) NSString * lastFourDigits;
@property(retain, nonatomic) NSString * subtype;
@property(retain, nonatomic) ZoozRisk * risk;

@end
