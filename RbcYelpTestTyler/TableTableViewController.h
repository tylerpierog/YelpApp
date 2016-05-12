//
//  TableTableViewController.h
//  RbcYelpTestTyler
//
//  Created by rbc mobile tech 5 on 2016-05-05.
//  Copyright © 2016 RBC. All rights reserved.
//
#import "detailsViewController.h"
#import "TableTableViewController.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface TableTableViewController : UITableViewController
- (instancetype)initWithDetails:(detailsViewController *)dvc;
@property (nonatomic,strong)NSString *selectedTitle;
@property (nonatomic, assign)NSInteger indexInArray;
@property (nonatomic,strong)NSMutableArray *arrayOfRestaurants;
@property (nonatomic, weak) detailsViewController *dvc;
@property (nonatomic,retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIView *menu;
@property(nonatomic,strong)NSString *selectedSort;
- (NSString *)deviceLocation;
- (IBAction)sortButton:(id)sender;
- (IBAction)closestBtn:(id)sender;
- (IBAction)azbtn:(id)sender;
- (IBAction)search:(id)sender;
@end
