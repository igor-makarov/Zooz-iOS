//
//  ZoozRequest.h
//  Zooz
//
//  Created by Ronen Morecki on 9/17/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZoozServerResponse.h"

@interface ZoozRequest : NSObject

-(ZoozServerResponse *)parseResponse:(NSDictionary *)dict;


@end
