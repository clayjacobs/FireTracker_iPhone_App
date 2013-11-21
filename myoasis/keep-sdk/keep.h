//
//  keep.h
//  myoasis
//
//  Created by Andrew on 10/8/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KeepSDKDelegate <NSObject>

@optional
- (void) didFetchRepos: (NSArray*) repos;
- (void) didFetchData: (NSArray*) data;

@end


@interface KeepSDK : NSObject

@property (weak) id <KeepSDKDelegate> delegate;
@property (nonatomic, copy) NSString *user;
@property (nonatomic, copy) NSString *key;

- (id) initWithUser: (NSString*)user andKey: (NSString*)key;

// List the public repos for the current user
- (void) repoList;

// List the data under a current directory
- (void) fetchData;

- (void) fetchDataWithBBox: (NSString*) bbox;

@end
