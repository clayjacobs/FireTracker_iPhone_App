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
    #define DATA_LIST       @"data/528e4ceb80a976032b6d7941/"
    #define DATA_POST       @"repos/528e4ceb80a976032b6d7941/"

#else

    #define SERVER          @"myoasis.distributedhealth.org/api/v1/"
    #define DATA_LIST       @"data/529517db2b0d035aa1c92754/"
    #define DATA_POST       @"repos/529517db2b0d035aa1c92754/"

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

- (void) postData: (NSDictionary*)textData andImages: (NSDictionary*)imageData {
    
    [manager POST: [self buildUrl:DATA_POST]
       parameters: baseParams
       constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    
        for( NSString* key in textData ) {
            [formData appendPartWithFormData: [[textData objectForKey:key] dataUsingEncoding:NSUTF8StringEncoding]
                                        name: key];
        }
    
        for( NSString* key in imageData ) {
    
            NSData *image = UIImageJPEGRepresentation( [imageData objectForKey:key], 0.5 );
            
            [formData appendPartWithFileData: image
                                        name: key
                                    fileName: @"photo.jpg"
                                    mimeType: @"image/jpeg" ];
        }
   
     }    success:^(AFHTTPRequestOperation *operation, id responseObject) {

     }    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
     }];
    
}

- (void) fetchDataWithBBox: (NSString*) bbox {
    
    NSMutableDictionary *fetchParams = [[NSMutableDictionary alloc] initWithDictionary: baseParams];
    [fetchParams setObject: @"location" forKey: @"geofield"];
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
