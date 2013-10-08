//
//  keep_sdk.h
//  keep-sdk
//
//  Created by Andrew on 10/8/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeepSDK : NSObject

@property (nonatomic, copy) NSString *user;
@property (nonatomic, copy) NSString *key;

- (id) initWithUser: (NSString*)user andKey: (NSString*)key;

- (NSArray*) repoList;

@end
