//
//  ZoozController.m
//  ecommApi
//
//  Created by Ronen Morecki on 9/16/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import "ZoozController.h"
#import "ZoozDictionaryEx.h"
#import "ZooZEcommServerProxy.h"
#import "ZoozServerResponse.h"

#import "ZoozAddPaymentMethodRequest.h"

#define ZOOZ_CLIENT_PAYMENT_API_URL @"/mobile/ZooZClientPaymentAPI"

@interface ZoozController (){
    NSString *_programId;
    BOOL _isSandbox;
    __unsafe_unretained id<ZoozActionDelegate> _delegate;
}
@property (nonatomic, retain) NSString *programId;
@property (nonatomic, retain) NSString *zoozServerURL;
@property (assign) id<ZoozActionDelegate> delegate;
@end


@implementation ZoozController


-(id)initWithProgramId:(NSString * )programId zoozServerURL:(NSString *)zoozURL delegate:(id<ZoozActionDelegate>)delegate{
    self = [super init];
    if (self) {
        self.zoozServerURL = zoozURL;
        self.programId = programId;
        self.delegate = delegate;
    }
    return self;
    
}

-(void)executeZoozRequest:(ZoozRequest *)request{
    
    NSDictionary *json = [ZoozDictionaryEx dictionaryWithPropertiesOfObject:request];
    //NSLog(@"%@", json);
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSString *urlStr = [NSString stringWithFormat: @"%@%@",self.zoozServerURL, ZOOZ_CLIENT_PAYMENT_API_URL];
    
    dispatch_async(queue, ^{
        NSError *error = nil;

        
        NSData * response=[ZooZEcommServerProxy sendJsonToURL:urlStr data:json programUniqueId:self.programId zoozToken:((ZoozAddPaymentMethodRequest *)request).paymentToken];
       
        
        NSDictionary * jsonResponse = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
        if(error){
            if(response != nil) NSLog(@"Parse error raw data: %@", [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
            NSData * dat = [ZooZEcommServerProxy createLocalErrorResponse:0x070201 errorDescription:@"Parse error, cannot parse Zooz server response"];
            jsonResponse = [NSJSONSerialization JSONObjectWithData:dat options:NSJSONReadingAllowFragments error:&error];
        }
        
        
        ZoozServerResponse * respObject = [request parseResponse:jsonResponse];
        
        if(self.delegate){
            if(respObject.responseStatus != 0){
            //failure response received
                NSLog(@"Zooz call failed: %@", jsonResponse);
                [self.delegate requestDidFinishedWithFailure:respObject.responseObject.errorDescription andErrorCode:respObject.responseObject.responseErrorCode rawResponse: respObject];
            }else{
            //success response
                [self.delegate requestDidFinishedWithSuccess:respObject];
            }
        }       
        
    });
    
   //
    
    
    
}

-(void)createAddPaymentMethodRequest{

}

@end
