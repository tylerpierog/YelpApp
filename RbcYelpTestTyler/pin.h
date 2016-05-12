//
//  pin.h
//  RbcYelpTestTyler
//
//  Created by rbc mobile tech 5 on 2016-05-09.
//  Copyright © 2016 RBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface pin : NSObject <MKAnnotation>

@property(nonatomic,assign)CLLocationCoordinate2D coordinate;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subtitle;

@end
