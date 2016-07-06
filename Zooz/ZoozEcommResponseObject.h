//
//  ZoozResponseObject.h
//  Zooz
//
//  Created by Ronen Morecki on 9/17/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZoozEcommResponseObject : NSObject

@property(nonatomic) NSInteger responseErrorCode;
@property (nonatomic, retain) NSString *errorDescription;


@end
