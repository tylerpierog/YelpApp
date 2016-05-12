//
//  YelpApi.h
//  RbcYelpTestTyler
//
//  Created by rbc mobile tech 5 on 2016-05-05.
//  Copyright © 2016 RBC. All rights reserved.
//
#import "YelpApi.h"
#import <Foundation/Foundation.h>
#import "TableTableViewController.h"

@interface YelpApi : NSObject
@property(nonatomic,strong)NSMutableArray *arrayOfRestaurants;
- (instancetype)initWithTableView:(TableTableViewController *)ttvc;

@property (nonatomic, weak) TableTableViewController *ttvc;
/**
 Sample class for accessing the Yelp API V2.
 This class demonstrates the capability of the Yelp API version 2.0 by using the Search API to
 query for businesses by a search term and location, and the Business API to query additional
 information about the top result from the search query.
 See the Yelp Documentation http://www.yelp.com/developers/documentation for more info.
 */

/**
 Query the Yelp API with a given term and location and displays the progress in the log
 
 @param term: The term of the search, e.g: dinner
 @param location: The location in which the term should be searched for, e.g: San Francisco, CA
 */
- (void)queryTopBusinessInfoForTerm:(NSString *)term location:(NSString *)location ;


@end