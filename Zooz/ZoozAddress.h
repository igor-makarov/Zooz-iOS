//
//  ZoozAddress.h
//  Zooz
//
//  Created by Ronen Morecki on 9/17/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZoozPhone.h"


@interface ZoozAddress : NSObject


@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *address1;
@property (nonatomic, retain) NSString *address2;
@property (nonatomic, retain) NSString *address3;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *zipCode;
@property (nonatomic, retain) NSString *countryCode;
@property (nonatomic, retain) ZoozPhone *phone;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSString *title;

@end
