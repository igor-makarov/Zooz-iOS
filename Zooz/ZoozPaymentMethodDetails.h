//
//  ZoozPaymentMethodDetails.h
//  Zooz
//
//  Created by Ronen Morecki on 9/17/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZoozPaymentMethodDetails : NSObject



@property (nonatomic, retain) NSString *expirationMonth;
@property (nonatomic, retain) NSString *expirationYear;
@property (nonatomic, retain) NSString *cardHolderName;
@property (nonatomic, retain) NSString *cvvNumber;
@property (nonatomic, retain) NSString *cardNumber;
@property (nonatomic, retain) NSString *userIdNumber;

@end
