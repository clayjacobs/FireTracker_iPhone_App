//
//  keep.m
//  myoasis
//
//  Created by Andrew on 10/8/13.
//  Copyright (c) 2013 DHLabs. All rights reserved.
//

#import <AFNetworking/AFHTTPRequestOperationManager.h>

#import "keep.h"
#import "KeepData.h"
#import "TargetConditionals.h"

#define REPO_LIST       @"repos/"
#define REAL_DATA_LIST  @"data/525590ab80a97674cee4d28f/"

#if TARGET_IPHONE_SIMULATOR

    #define SERVER          @"localhost:8000/api/v1/"
    #define DATA_LIST       @"data/51b7c05480a9760067a3f956/"

#else

    #define SERVER          @"keep.distributedhealth.org/api/v1/"
    #define DATA_LIST       @"data/51ba78daab2fda2874b1ce90"

#endif

@interface KeepSDK () {
    
    AFHTTPRequestOperationManager *manager;
    NSMutableDictionary *baseParams;
    
}

- (NSString*) buildUrl: (NSString*) command;

@end

@implementation KeepSDK

- (id) initWithUser:(NSString *)user andKey:(NSString *)key {
    
    self = [super init];
    if( self ) {
        
        self.user = user;
        self.key  = key;
        self.delegate = nil;
        
        baseParams = [[NSMutableDictionary alloc] init];
        [baseParams setValue: @"json"   forKey: @"format" ];
        [baseParams setValue: self.user forKey: @"user"];
        [baseParams setValue: self.key  forKey: @"key"];
        
        manager = [AFHTTPRequestOperationManager manager];
        
    }
    
    return self;
}

- (NSString*) buildUrl: (NSString *)command {
    return [NSString stringWithFormat:@"http://%@%@", SERVER, command ];
}

- (void) fetchData {
    
    [manager GET: [self buildUrl:DATA_LIST]
      parameters: baseParams
         success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
             if( [self.delegate respondsToSelector:@selector(didFetchData:)] ) {
                 NSDictionary *dictionary = (NSDictionary*)responseObject;
                 [self.delegate didFetchData: [KeepData parseJSON:dictionary]];
             }
             
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];

}

- (void) fetchDataWithBBox: (NSString*) bbox {
    
    NSMutableDictionary *fetchParams = [[NSMutableDictionary alloc] initWithDictionary: baseParams];
    [fetchParams setObject: @"Location" forKey: @"geofield"];
    [fetchParams setObject: bbox forKey: @"bbox" ];

    [manager GET: [self buildUrl:DATA_LIST]
      parameters: fetchParams
         success: ^(AFHTTPRequestOperation *operation, id responseObject) {
             
             if( [self.delegate respondsToSelector:@selector(didFetchData:)] ) {
                 NSDictionary *dictionary = (NSDictionary*)responseObject;
                 [self.delegate didFetchData: [KeepData parseJSON:dictionary]];
             }
             
     } failure:  ^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"Error: %@", error);
         
     }];
    
}

- (void) repoList {
    
    [manager GET: [self buildUrl:REPO_LIST]
      parameters: baseParams
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             if( [self.delegate respondsToSelector:@selector(didFetchRepos:)] ) {
                 NSDictionary *dictionary = (NSDictionary*)responseObject;
                 [self.delegate didFetchRepos: [KeepData parseJSON:dictionary]];
             }
             
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];

}

@end
