//
//  CryptoUtils.m
//  TactusPay1
//
//  Created by Ronen Morecki on 8/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ZooZEcommCryptoUtils.h"
#import "ZooZEcommSecKeyWrapper.h"

//#import "NSData+CommonCrypto.h"

@implementation ZooZEcommCryptoUtils

static char base64EncodingTable[64] = {
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
    'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
};


+ (NSString *) base64StringFromData: (NSData *)data length: (int)length {
	unsigned long ixtext, lentext;
	long ctremaining;
	unsigned char input[3], output[4];
	short i, charsonline = 0, ctcopy;
	const unsigned char *raw;
	NSMutableString *result;
	
	lentext = [data length]; 
	if (lentext < 1)
		return @"";
	result = [NSMutableString stringWithCapacity: lentext];
	raw = [data bytes];
	ixtext = 0; 
	
	while (true) {
		ctremaining = lentext - ixtext;
		if (ctremaining <= 0) 
			break;        
		for (i = 0; i < 3; i++) { 
			unsigned long ix = ixtext + i;
			if (ix < lentext)
				input[i] = raw[ix];
			else
				input[i] = 0;
		}
		output[0] = (input[0] & 0xFC) >> 2;
		output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
		output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
		output[3] = input[2] & 0x3F;
		ctcopy = 4;
		switch (ctremaining) {
			case 1: 
				ctcopy = 2; 
				break;
			case 2: 
				ctcopy = 3; 
				break;
		}
		
		for (i = 0; i < ctcopy; i++)
			[result appendString: [NSString stringWithFormat: @"%c", base64EncodingTable[output[i]]]];
		
		for (i = ctcopy; i < 4; i++)
			[result appendString: @"="];
		
		ixtext += 3;
		charsonline += 4;
		
		if ((length > 0) && (charsonline >= length))
			charsonline = 0;
		
		
	}
	return result;
}	

+ (NSData *) dataWithBase64EncodedString:(NSString *) string {
	NSMutableData *mutableData = nil;
	
	if( string ) {
		unsigned long ixtext = 0;
		unsigned long lentext = 0;
		unsigned char ch = 0;
		unsigned char inbuf[4], outbuf[3];
		short i = 0, ixinbuf = 0;
		BOOL flignore = NO;
		BOOL flendtext = NO;
		NSData *base64Data = nil;
		const unsigned char *base64Bytes = nil;
		
		// Convert the string to ASCII data.
		base64Data = [string dataUsingEncoding:NSASCIIStringEncoding];
		base64Bytes = [base64Data bytes];
		mutableData = [NSMutableData dataWithCapacity:[base64Data length]];
		lentext = [base64Data length];
		
		while( YES ) {
			if( ixtext >= lentext ) break;
			ch = base64Bytes[ixtext++];
			flignore = NO;
			
			if( ( ch >= 'A' ) && ( ch <= 'Z' ) ) ch = ch - 'A';
			else if( ( ch >= 'a' ) && ( ch <= 'z' ) ) ch = ch - 'a' + 26;
			else if( ( ch >= '0' ) && ( ch <= '9' ) ) ch = ch - '0' + 52;
			else if( ch == '+' ) ch = 62;
			else if( ch == '=' ) flendtext = YES;
			else if( ch == '/' ) ch = 63;
			else flignore = YES;
			
			if( ! flignore ) {
				short ctcharsinbuf = 3;
				BOOL flbreak = NO;
				
				if( flendtext ) {
					if( ! ixinbuf ) break;
					if( ( ixinbuf == 1 ) || ( ixinbuf == 2 ) ) ctcharsinbuf = 1;
					else ctcharsinbuf = 2;
					ixinbuf = 3;
					flbreak = YES;
				}
				
				inbuf [ixinbuf++] = ch;
				
				if( ixinbuf == 4 ) {
					ixinbuf = 0;
					outbuf [0] = ( inbuf[0] << 2 ) | ( ( inbuf[1] & 0x30) >> 4 );
					outbuf [1] = ( ( inbuf[1] & 0x0F ) << 4 ) | ( ( inbuf[2] & 0x3C ) >> 2 );
					outbuf [2] = ( ( inbuf[2] & 0x03 ) << 6 ) | ( inbuf[3] & 0x3F );
					
					for( i = 0; i < ctcharsinbuf; i++ )
						[mutableData appendBytes:&outbuf[i] length:1];
				}
				
				if( flbreak )  break;
			}
		}
	}
	
	return [NSData dataWithData: mutableData];
}



+(NSString *)hash:(NSString *)input{
	ZooZEcommSecKeyWrapper * sk = [ZooZEcommSecKeyWrapper sharedWrapper];
	NSData * pinCode = [input dataUsingEncoding:NSUTF8StringEncoding];
	NSData * hash = [sk getHashBytes: pinCode];
	NSString * hashStr = [ZooZEcommCryptoUtils base64StringFromData:hash length:(int)[hash length]];
	
	return hashStr;
}	


+(NSString *)encrypt:(NSString *)plainText key:(NSString *)key{
	
	ZooZEcommSecKeyWrapper * sk = [ZooZEcommSecKeyWrapper sharedWrapper];
	
	NSData * inputData1 = [plainText dataUsingEncoding:NSUTF8StringEncoding];
	int len = (int)[inputData1 length];
	int add = 16 - len % 16;
	NSMutableData * inputData = [NSMutableData dataWithData:inputData1];
	[inputData setLength:len + add];
	
	
	NSData * keyData = [ZooZEcommCryptoUtils dataWithBase64EncodedString:key];
	//NSLog(@"input: %@   key: %@", [inputData description], [keyData description]);
	CCOptions pad = kCCOptionECBMode;	
	NSData * encData = [sk doCipher:inputData key:keyData context:kCCEncrypt padding:&pad];
	NSString * encStr = [ZooZEcommCryptoUtils base64StringFromData:encData length:0];//[encData length]];
	return encStr;
	 /*
	
	NSData * inputData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
	NSData * keyData = [NSString dataWithBase64EncodedString:key];
	NSData * iv = [@"1010101010101010" dataUsingEncoding:NSASCIIStringEncoding]; 
	CCCryptorStatus status = kCCSuccess;
	//NSData * encData = [inputData dataEncryptedUsingAlgorithm:kCCAlgorithmAES128 key:keyData initializationVector:iv options:kCCOptionPKCS7Padding error:&status];
	NSData * encData = [inputData dataEncryptedUsingAlgorithm:kCCAlgorithmAES128 key:keyData options:kCCOptionECBMode error:&status];
	
	
	NSString * encStr = [NSString base64StringFromData:encData length:[encData length]];
	return encStr; */
}

@end
