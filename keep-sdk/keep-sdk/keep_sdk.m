//
//  keep_sdk.m
//  keep-sdk
//
//  Created by Andrew on 10/8/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import "keep_sdk.h"

@implementation KeepSDK

- (id) initWithUser:(NSString *)user andKey:(NSString *)key {
    
    self = [super init];
    if( self ) {
        
        self.user = user;
        self.key  = key;
        
    }
    
    return self;
}

- (NSArray*) repoList {
    
    NSLog( @"Grabbing repo list" );
    
    return nil;
}

@end
