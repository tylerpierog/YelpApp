//
//  NSURLRequest.m
//  RbcYelpTestTyler
//
//  Created by rbc mobile tech 5 on 2016-05-05.
//  Copyright © 2016 RBC. All rights reserved.
//
#import <TDOAuth/TDOAUTH.h>
#import "NSURLRequest.h"

static NSString * const kConsumerKey       = @"-xxptV9UUw4bICMvyABZrQ";
static NSString * const kConsumerSecret    = @"YP37eeB3uVoF3QEe6NZOKvGmsSE";
static NSString * const kToken             = @"9kN5GTAS6X5NIAClCwdP8PMYhJJKgemX";
static NSString * const kTokenSecret       = @"P8TpdSh_WL3qogVpNXQT56Y01N0";

@implementation NSURLRequest (OAuth)

+ (NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path{
    return [self requestWithHost:host path:path params:nil];
}

+ (NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)params{
    if ([kConsumerKey length] == 0 || [kConsumerSecret length] == 0 || [kToken length] == 0 || [kTokenSecret length] == 0) {
        NSLog(@"WARNING: Please enter your api v2 credentials before attempting any API request. You can do so in NSURLRequest.m");
    }
    
    return [TDOAuth URLRequestForPath:path
                        GETParameters:params
                               scheme:@"https"
                                 host:host
                          consumerKey:kConsumerKey
                       consumerSecret:kConsumerSecret
                          accessToken:kToken
                          tokenSecret:kTokenSecret];

}
@end
