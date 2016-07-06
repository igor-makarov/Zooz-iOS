//
//  ZoozAddPaymentMethodRequest.m
//  Zooz
//
//  Created by Ronen Morecki on 9/17/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import "ZoozAddPaymentMethodRequest.h"
#import "ZoozAddPaymentMethodResponse.h"

@interface ZoozAddPaymentMethodRequest (){
    
}

@property(readonly) NSString * command;

@end

@implementation ZoozAddPaymentMethodRequest



-(id)initWithPaymentToken:(NSString *)token emailAddress:(NSString *)billingEmail address:(ZoozAddress *)billingAddress paymentMethodDetails:(ZoozPaymentMethodDetails *)paymentMethodDetails isRememberPaymentMethod:(BOOL)rememberMe{
    
    self = [super init];
    if(self){
        _paymentToken = token;
        _email = billingEmail;
        _billingAddress = billingAddress;
        _paymentMethod = [[ZoozPaymentMethod alloc] init];
        _paymentMethod.paymentMethodDetails = paymentMethodDetails;
        NSString * remember = rememberMe ? @"true" : @"false";
        NSDictionary * dict = [NSDictionary dictionaryWithObject:remember forKey:@"rememberPaymentMethod"];
        _paymentMethod.configuration = dict;
        _paymentMethod.paymentMethodType = @"CreditCard";
        _command = @"addPaymentMethod";
    }
    return self;
}

-(id)initWithPaymentToken:(NSString *)token emailAddress:(NSString *)email paymentMethodDetails:(ZoozPaymentMethodDetails *)paymentMethodDetails isRememberPaymentMethod:(BOOL)rememberMe{
    return [self initWithPaymentToken:token emailAddress:email address:nil paymentMethodDetails:paymentMethodDetails isRememberPaymentMethod:rememberMe];
}


+(ZoozAddPaymentMethodRequest *)createRequestWithPaymentToken:(NSString *)token emailAddress:(NSString *)email address:(ZoozAddress *)billingAddress paymentMethodDetails:(ZoozPaymentMethodDetails *)paymentMethodDetails isRememberPaymentMethod:(BOOL)rememberMe{

    return [[ZoozAddPaymentMethodRequest alloc] initWithPaymentToken:token emailAddress:email address:billingAddress paymentMethodDetails:paymentMethodDetails isRememberPaymentMethod:rememberMe];
}

-(ZoozEcommResponseObject *)parseInternalResponseObject: (NSDictionary *)internalResponseDict{
    ZoozAddPaymentMethodResponse *response = [[ZoozAddPaymentMethodResponse alloc] init];
    [response setValuesForKeysWithDictionary:internalResponseDict];
    return response;
}


@end
