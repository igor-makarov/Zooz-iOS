//
//  ZoozController.h
//  ecommApi
//
//  Created by Ronen Morecki on 9/16/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZoozServerResponse.h"
#import "ZoozPaymentMethodDetails.h"
#import "ZoozRequest.h"


@protocol ZoozActionDelegate <NSObject>

@required
//The request finished successfully, please note this is background thread not UI thread.
- (void)requestDidFinishedWithSuccess:(ZoozServerResponse *)response;

- (void)requestDidFinishedWithFailure:(NSString* )message andErrorCode:(NSInteger)errorCode rawResponse:(ZoozServerResponse *)serverResponse;

@end

@interface ZoozController : NSObject

-(id)initWithProgramId:(NSString * )programId zoozServerURL:(NSString *)zoozURL delegate:(id<ZoozActionDelegate>)delegate;

-(void)executeZoozRequest:(ZoozRequest *)request;


-(void)createAddPaymentMethodRequest;


@end
