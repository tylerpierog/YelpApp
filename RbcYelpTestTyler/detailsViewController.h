//
//  detailsViewController.h
//  RbcYelpTestTyler
//
//  Created by rbc mobile tech 5 on 2016-05-08.
//  Copyright © 2016 RBC. All rights reserved.
//
#import "TableTableViewController.h"
#import "detailsViewController.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface detailsViewController : UIViewController
@property (nonatomic,strong)NSMutableArray *arrayOfRestaurants;
@property (nonatomic,strong)NSString *Selected;
@property (weak, nonatomic) IBOutlet UILabel *nameTitle;
@property(nonatomic, assign)NSInteger indexInArray;
@property(nonatomic, assign)double lat;
@property(nonatomic, assign)double lon;
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
- (IBAction)showWebPage:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *address;

@end
