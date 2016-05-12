//
//  YelpApi.m
//  RbcYelpTestTyler
//
//  Created by rbc mobile tech 5 on 2016-05-05.
//  Copyright © 2016 RBC. All rights reserved.
//

#import "YelpApi.h"
#import "NSURLRequest.h"
#import "TableTableViewController.h"

@implementation YelpApi


static NSString * const kAPIHost           = @"api.yelp.com";
static NSString * const kSearchPath        = @"/v2/search/";
static NSString * const kBusinessPath      = @"/v2/business/";
static NSString * const kSearchLimit       = @"10";
@synthesize arrayOfRestaurants;


- (instancetype)initWithTableView:(TableTableViewController *)ttvc
{
    self = [super init];
    if (self)
    {
        _ttvc = ttvc;
    }
    
    return self;
}


- (void)queryTopBusinessInfoForTerm:(NSString *)term location:(NSString *)location {
   // TableTableViewController *tv = [[TableTableViewController alloc]init];
    NSLog(@"Querying the Search API with term \'%@\' and location \'%@'", term, location);
    
    //Make a first request to get the search results with the passed term and location
    NSURLRequest *searchRequest = [self _searchRequestWithTerm:term location:location];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:searchRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (!error && httpResponse.statusCode == 200) {
            NSDictionary *searchResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            arrayOfRestaurants = searchResponseJSON[@"businesses"];

            dispatch_async(dispatch_get_main_queue(), ^{
                //Calling the main queue
                //sets array in table controller and reloads
                _ttvc.arrayOfRestaurants = arrayOfRestaurants;
                [_ttvc.tableView reloadData];
            });
            
        
        }else{
        }
    }] resume];
}



#pragma mark - API Request Builders

/**
 Builds a request to hit the search endpoint with the given parameters.
 
 @param term The term of the search, e.g: dinner
 @param location The location request, e.g: San Francisco, CA
 @return The NSURLRequest needed to perform the search
 */
- (NSURLRequest *)_searchRequestWithTerm:(NSString *)term location:(NSString *)location {
    NSDictionary *params = @{
                             @"term": term,
                             @"location": location,
                             @"limit": kSearchLimit
                             };
    
    return [NSURLRequest requestWithHost:kAPIHost path:kSearchPath params:params];
}


/**
 Builds a request to hit the business endpoint with the given business ID.
 
 @param businessID The id of the business for which we request informations
 @return The NSURLRequest needed to query the business info
 */



@end
