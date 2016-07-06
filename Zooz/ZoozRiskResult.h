//
//  ZoozRiskResult.h
//  Zooz
//
//  Created by Rona Yadid on 11/16/15.
//  Copyright (c) 2015 Zooz. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface ZoozRiskResult : NSObject

@property (nonatomic, readonly) NSString * action;
@property (nonatomic, readonly) NSString * context;
@property (nonatomic, readonly) NSString * riskScore;
@property (nonatomic, readonly) NSString * riskDescription;
@property (nonatomic, readonly) NSString * riskScoreOrigin;
@property (nonatomic, readonly) NSString * determiningRule;


@end






