//
//  ZoozPhone.h
//  Zooz
//
//  Created by Ronen Morecki on 9/17/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZoozPhone : NSObject


@property (nonatomic, retain) NSString *countryCode;

//The user's phone number, excluding the country code
@property (nonatomic, retain) NSString *phoneNumber;


@end
