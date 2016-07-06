//
//  CryptoUtils.h
//  TactusPay1
//
//  Created by Ronen Morecki on 8/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZooZEcommCryptoUtils : NSObject {

}
+(NSString *)hash:(NSString *)input;
+(NSString *)encrypt:(NSString *)plainText key:(NSString *)key;
@end
