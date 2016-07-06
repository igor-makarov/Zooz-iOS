//
//  ZoozTestsActionDelegate.m
//  Zooz
//
//  Created by Ronen Morecki on 9/21/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import "ZoozTestsActionDelegate.h"

@implementation ZoozTestsActionDelegate


- (void)requestDidFinishedWithSuccess:(ZoozServerResponse *)response{
    NSLog(@"%@", response);
}

- (void)requestDidFinishedWithFailure:(NSString* )message andErrorCode:(NSInteger)errorCode rawResponse:(ZoozServerResponse *)serverResponse{
        NSLog(@"code: %li  message: %@", (long)errorCode, message);
}


@end
