//
//  ZoozServerResponse.h
//  Zooz
//
//  Created by Ronen Morecki on 9/19/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZoozEcommResponseObject.h"

@interface ZoozServerResponse : NSObject

@property (nonatomic) NSInteger responseStatus;
@property (nonatomic, retain) ZoozEcommResponseObject *responseObject;


@end
