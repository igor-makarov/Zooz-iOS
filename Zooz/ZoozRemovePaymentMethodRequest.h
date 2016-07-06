//
//  ZoozRemovePaymentMethodRequest.h
//  Zooz
//
//  Created by Ronen Morecki on 9/17/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZoozRequest.h"

@interface ZoozRemovePaymentMethodRequest : ZoozRequest


@property(readonly, nonatomic) NSString *paymentToken;
@property(readonly, nonatomic) NSString *paymentMethodToken;

+(ZoozRemovePaymentMethodRequest *)createRequestWithPaymentToken:(NSString *)token paymentMethodToken:(NSString *)paymentMethodToken;



@end
