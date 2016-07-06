//
//  ZoozAddPaymentMethodRequest.h
//  Zooz
//
//  Created by Ronen Morecki on 9/17/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZoozPaymentMethod.h"
#import "ZoozAddress.h"
#import "ZoozRequest.h"
#import "ZoozPaymentMethodDetails.h"

@interface ZoozAddPaymentMethodRequest : ZoozRequest

@property(readonly, nonatomic) NSString *paymentToken;
@property(readonly, nonatomic) NSString *email;
@property(readonly, nonatomic) ZoozAddress *billingAddress;
@property(readonly, nonatomic) ZoozPaymentMethod *paymentMethod;



-(id)initWithPaymentToken:(NSString *)token emailAddress:(NSString *)email address:(ZoozAddress *)billingAddress paymentMethodDetails:(ZoozPaymentMethodDetails *)paymentMethodDetails isRememberPaymentMethod:(BOOL)rememberMe;

-(id)initWithPaymentToken:(NSString *)token emailAddress:(NSString *)email paymentMethodDetails:(ZoozPaymentMethodDetails *)paymentMethodDetails isRememberPaymentMethod:(BOOL)rememberMe;

+(ZoozAddPaymentMethodRequest *)createRequestWithPaymentToken:(NSString *)token emailAddress:(NSString *)email address:(ZoozAddress *)billingAddress paymentMethodDetails:(ZoozPaymentMethodDetails *)paymentMethodDetails isRememberPaymentMethod:(BOOL)rememberMe;



@end
