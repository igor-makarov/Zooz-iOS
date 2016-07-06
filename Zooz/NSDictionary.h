//
//  NSDictionary.h
//  Zooz
//
//  Created by Ronen Morecki on 9/18/14.
//  Copyright (c) 2014 Zooz. All rights reserved.
//


#import <objc/runtime.h>

@interface NSDictionary(dictionaryWithObject)

+(NSDictionary *) dictionaryWithPropertiesOfObject:(id) obj;

@end

@implementation NSDictionary(dictionaryWithObject)
+(NSDictionary *) dictionaryWithPropertiesOfObject:(id)obj
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        //Class classObject = NSClassFromString([key capitalizedString]);
        
        id object = [obj valueForKey:key];
        
        BOOL isZoozClass = [[[object class] description] containsString:@"Zooz"];
        
        if (isZoozClass) {
            id subObj = [self dictionaryWithPropertiesOfObject:object];
            [dict setObject:subObj forKey:key];
        }
        else if([object isKindOfClass:[NSArray class]])
        {
            NSMutableArray *subObj = [NSMutableArray array];
            for (id o in object) {
                [subObj addObject:[self dictionaryWithPropertiesOfObject:o] ];
            }
            [dict setObject:subObj forKey:key];
        }
        else
        {
            if(object) [dict setObject:object forKey:key];
        }
    }
    
    free(properties);
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end