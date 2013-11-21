//
//  KeepData.m
//  myoasis
//
//  Created by Andrew on 10/8/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import "KeepData.h"

@implementation KeepData

+ (NSArray*) parseJSON: (NSDictionary*) dictionary {
    
    if( [dictionary valueForKey: @"objects"] == nil ) {
        return [dictionary valueForKey:@"data"];
    } else {
        return [dictionary valueForKey: @"objects"];
    }
    
}

@end
