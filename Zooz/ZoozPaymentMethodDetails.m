//
//  ZoozPaymentMethodDetails.m
//  Zooz
//
//  Created by Ronen Morecki on 9/17/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import "ZoozPaymentMethodDetails.h"

@interface ZoozPaymentMethodDetails (){
    
}

@property (nonatomic, retain) NSString *paymentMethodType;
@property (readonly) NSString * expirationDate;

@end
@implementation ZoozPaymentMethodDetails

-(id)init{
    self = [super init];
    if(self){
        self.paymentMethodType = @"CreditCard";
    }
    return self;
}

-(NSString *)expirationDate{
    return [NSString stringWithFormat:@"%@/%@", self.expirationMonth, self.expirationYear];
}


@end
