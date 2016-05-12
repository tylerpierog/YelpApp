//
//  TableTableViewController.m
//  RbcYelpTestTyler
//
//  Created by rbc mobile tech 5 on 2016-05-05.
//  Copyright © 2016 RBC. All rights reserved.
//

#import "TableTableViewController.h"
#import "YelpApi.h"
#import "NSURLRequest.h"
#import <TDOAuth/TDOAuth.h>
#import "detailsViewController.h"

@interface TableTableViewController () <CLLocationManagerDelegate>
@end

@implementation TableTableViewController
@synthesize arrayOfRestaurants, selectedTitle, indexInArray, selectedSort, locationManager;
int counter = 1;

UITableViewCell *cell;
NSMutableArray *sortedArray;
NSString *searched;
NSString *defaultTerm = @"Ethiopian";
CLLocationManager *locationManager;
CLLocation *loc;


- (instancetype)initWithDetails:(detailsViewController *)dvc
{
    self = [super init];
    if (self)
    {
        _dvc = dvc;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //locationManager.delegate = self;
    [self getArray];
    
}
- (IBAction)refreshPressed:(id)sender {
    self.selectedSort = @"";
    [self getArray];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) viewWillAppear:(BOOL)animated {
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    locationManager = [[CLLocationManager alloc]init]; // initializing locationManager

    [self getCurrentLocation];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(![selectedSort  isEqual: @"az"] && ! ([selectedSort  isEqual: @"close"])){
        static NSString *CellIdentifier = @"cell";
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            if (cell==nil) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
        NSDictionary *wadb = arrayOfRestaurants[indexPath.row];
        cell.textLabel.text = [wadb objectForKey:@"name"];
        cell.detailTextLabel.text = [[wadb valueForKeyPath:@"location.address"] firstObject];
    }else if([selectedSort  isEqual: @"az"]){

        static NSString *CellIdentifier = @"cell";
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            if (cell==nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
        NSDictionary * wadb = sortedArray[indexPath.row];
        
        cell.textLabel.text = [wadb objectForKey:@"name"];
        cell.detailTextLabel.text = [[wadb valueForKeyPath:@"location.address"] firstObject];
    }else{
        NSLog(@"close");

        
    }
    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    selectedTitle = cell.textLabel.text;
    indexInArray = indexPath.row;
      [self performSegueWithIdentifier:@"details" sender:self];
}

-(NSArray *)getArray{
    NSMutableArray *array;
    NSString *defaultLocation = @"Toronto";
    NSString *term = [[NSUserDefaults standardUserDefaults] valueForKey:@"term"] ?: defaultTerm;
    NSString *location = [[NSUserDefaults standardUserDefaults] valueForKey:@"location"] ?: defaultLocation;
    YelpApi *APISample = [[YelpApi alloc] initWithTableView:self];
    [APISample queryTopBusinessInfoForTerm:(NSString *)term location:(NSString *)location];
    array = arrayOfRestaurants;
    return array;
}


//// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    detailsViewController *d = [segue destinationViewController];
    if(![selectedSort isEqualToString:@"az"]){
        [d setArrayOfRestaurants:arrayOfRestaurants];

    }
    else{
        [d setArrayOfRestaurants:sortedArray];

    }
    [d setSelected:selectedTitle];
    [d setIndexInArray:indexInArray];
}


- (IBAction)sortButton:(id)sender {
    counter++;
    if(counter % 2 == 0){
    _menu.hidden = false;
        CGRect aFrame = _menu.frame;
        
        aFrame.size.height = 100;
        
        _menu.frame = aFrame;
        
        
    }
    else{
        _menu.hidden = true;
        CGRect aFrame = _menu.frame;
        
        aFrame.size.height = 0;
        
        _menu.frame = aFrame;

    }
    
    
}
- (IBAction)closestBtn:(id)sender {
    NSLog(@"not yet implemented");
//    NSLog(@"CLOSEST LOCATION");
//    self.selectedSort = @"close";
//    for(int i = 0; i < 10; i++) {
//    NSDictionary *dic = arrayOfRestaurants[i];
//        CLLocation *shopLocationA = [[CLLocation alloc] initWithLatitude:[[dic objectForKey:@"latitude"] doubleValue] longitude:[[dic objectForKey:@"longitude"] doubleValue]];
//        i++;
//        CLLocation *shopLocationB = [[CLLocation alloc] initWithLatitude:[[dic objectForKey:@"latitude"] doubleValue] longitude:[[dic objectForKey:@"longitude"] doubleValue]];
//        i--;
//        
//        CLLocationDistance distA = [shopLocationA distanceFromLocation:loc];
//        CLLocationDistance distB = [shopLocationB distanceFromLocation:loc];
//        
//        if (distA < distB) {
//            return (NSComparisonResult)NSOrderedAscending;
//        } else if ( distA > distB) {
//            return (NSComparisonResult)NSOrderedDescending;
//        } else {
//            return (NSComparisonResult)NSOrderedSame;
//        }
//    }
//    [self.tableView reloadData];

}

- (IBAction)azbtn:(id)sender {
    sortedArray = [[NSMutableArray alloc]init];
    self.selectedSort = @"az";

    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    sortedArray = [arrayOfRestaurants sortedArrayUsingDescriptors:@[sortDescriptor]];
    [self.tableView reloadData];


}
- (IBAction)search:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Search Dialog" message:@"Search for Restaurants" preferredStyle:UIAlertControllerStyleAlert];
    searched = [[NSString alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @" ";
    }];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"Search", @"Search")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   defaultTerm = [alert.textFields objectAtIndex:0].text;
                                   [self getArray];\
                                   selectedSort = @"";
                                   [self.tableView reloadData];
                               }];
    
    [alert addAction:okAction];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)getCurrentLocation {
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [locationManager stopUpdatingLocation];
    loc = [locations lastObject];
    NSLog(@"%f",loc.coordinate.longitude);
    NSLog(@"%f",loc.coordinate.latitude);
}
@end
