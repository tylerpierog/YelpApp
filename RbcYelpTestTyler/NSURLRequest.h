//
//  NSURLRequest.h
//  RbcYelpTestTyler
//
//  Created by rbc mobile tech 5 on 2016-05-05.
//  Copyright © 2016 RBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (OAuth)

+ (NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path;

+ (NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)params;

@end
