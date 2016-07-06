//
//  ZoozTests.m
//  ZoozTests
//
//  Created by Ronen Morecki on 9/16/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Zooz.h"
#import "ZoozTestsActionDelegate.h"


@interface ZoozTests : XCTestCase

@end

@implementation ZoozTests



- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAddCard {
    // This is an example of a functional test case.
    NSLog(@"button click");
    ZoozTestsActionDelegate * delgate = [[ZoozTestsActionDelegate alloc] init];
    
    ZoozController *zooz = [[ZoozController alloc] initWithProgramId:@"com.ugol.app" zoozServerURL:@"http://192.168.1.17:8080" delegate:delgate];
    
    
    ZoozPaymentMethodDetails *card = [[ZoozPaymentMethodDetails alloc] init];
    card.cardNumber = @"4580458045804580";
    card.cvvNumber = @"123";
    card.expirationMonth = @"09";
    card.expirationYear = @"2019";
    card.cardHolderName = @"test holder name";
    card.userIdNumber = @"3074987855";

    
    ZoozAddPaymentMethodRequest *addRequest = [ZoozAddPaymentMethodRequest createRequestWithPaymentToken:@"UXAAJQ4UDB2S7MAQYNU6IBG5YA" emailAddress:@"test@zooz.co" address:nil paymentMethodDetails: card isRememberPaymentMethod:YES];
    
    
    [zooz executeZoozRequest:addRequest];

    
    XCTAssert(YES, @"Pass");
}

-(void)testRemoveCard{
    ZoozTestsActionDelegate * delgate = [[ZoozTestsActionDelegate alloc] init];
    
    ZoozController *zooz = [[ZoozController alloc] initWithProgramId:@"com.zooz.ecomm.test1" zoozServerURL:@"https://sandbox.zooz.co" delegate:delgate];
    
    
    
    ZoozRemovePaymentMethodRequest *removeRequest = [ZoozRemovePaymentMethodRequest createRequestWithPaymentToken:@"XIRDJK4KVHP4EN3DSJSPJUMHNU" paymentMethodToken:@"KV2DL5HEUGWSZXZXEORMO7FNNQ"];
    
    
    [zooz executeZoozRequest:removeRequest];
    
    
    XCTAssert(YES, @"Pass");

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
    
    
}

@end
