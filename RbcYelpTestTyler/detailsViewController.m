//
//  detailsViewController.m
//  RbcYelpTestTyler
//
//  Created by rbc mobile tech 5 on 2016-05-08.
//  Copyright © 2016 RBC. All rights reserved.
//
#import "TableTableViewController.h"
#import "YelpApi.h"
#import "NSURLRequest.h"
#import <TDOAuth/TDOAuth.h>
#import "detailsViewController.h"
#import <MapKit/MapKit.h>
#import "pin.h"
@import SafariServices;



@implementation detailsViewController

@synthesize Selected, nameTitle, arrayOfRestaurants, indexInArray, lat,lon,imgView, phone, address;
NSDictionary *myDictionary;
//Selected holds the value of the selected row (Name of the restaurant
//arrayOfRestaurants holds the data for each restaurant
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDetails];
    [self setMap];


}

-(void) setDetails{
    myDictionary= arrayOfRestaurants[indexInArray];
    nameTitle.text = [myDictionary objectForKey:@"name"];
    NSString *lo = [myDictionary valueForKeyPath:@"location.coordinate.longitude"];
    NSString *la = [myDictionary valueForKeyPath:@"location.coordinate.latitude"];
    lon = [lo doubleValue];
    lat = [la doubleValue];
    imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[myDictionary objectForKey:@"rating_img_url_large"]]]];
    phone.text = [myDictionary objectForKey:@"display_phone"];
    NSString *a = [[myDictionary valueForKeyPath:@"location.address"] firstObject];
    address.text = a;
    

}

-(void)setMap{
    MKCoordinateRegion myRegion;
    CLLocationCoordinate2D center;
    MKCoordinateSpan span;
//    NSLog(@"%f,  %f", lat, lon);
    center.latitude = lat;
    center.longitude = lon;
    span.latitudeDelta = .01f;
    span.longitudeDelta = .01f;
    myRegion.center = center;
    myRegion.span = span;
    [_map setRegion:myRegion animated:YES];
    
    CLLocationCoordinate2D location;
    location.latitude = lat;
    location.longitude = lon;
    pin *myPin = [[pin alloc]init];
    myPin.coordinate = location;
    myPin.title = Selected;
    myPin.subtitle = [[myDictionary valueForKeyPath:@"location.address"] firstObject];
    
    [self.map addAnnotation:myPin];
    
    
    
   
}
- (IBAction)showWebPage:(id)sender {
    NSURL *url = [NSURL URLWithString:[myDictionary objectForKey:@"mobile_url"]];
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
    [self showViewController:safariVC sender:nil];
    
    
}
@end
