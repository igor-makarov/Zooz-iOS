//
//  ZoozRemovePaymentMethodRequest.m
//  Zooz
//
//  Created by Ronen Morecki on 9/17/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import "ZoozRemovePaymentMethodRequest.h"
#import "ZoozRemovePaymentMethodResponse.h"

@interface ZoozRemovePaymentMethodRequest (){
    NSString *_command;
    NSString *_paymentMethodToken;
    NSString *_paymentToken;
}

@property(readonly) NSString * command;

@end

@implementation ZoozRemovePaymentMethodRequest

-(id)initWithPaymentToken:(NSString *)token paymentMethodToken:(NSString *)paymentMethodToken{
    
    self = [super init];
    if(self){
        _paymentToken = token;
        _paymentMethodToken = paymentMethodToken;
        _command = @"removePaymentMethod";
    }
    return self;
}

+(ZoozRemovePaymentMethodRequest *)createRequestWithPaymentToken:(NSString *)token paymentMethodToken:(NSString *)paymentMethodToken{
    
    return [[ZoozRemovePaymentMethodRequest alloc] initWithPaymentToken:token paymentMethodToken:paymentMethodToken];
}

-(ZoozRemovePaymentMethodResponse *)parseInternalResponseObject: (NSDictionary *)internalResponseDict{
    ZoozRemovePaymentMethodResponse *response = [[ZoozRemovePaymentMethodResponse alloc] init];
    [response setValuesForKeysWithDictionary:internalResponseDict];
    return response;
}


@end
