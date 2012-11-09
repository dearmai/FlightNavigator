//
//  AirportListViewController.m
//  FlightNavigator
//
//  Created by Yoo Rinjae on 12. 11. 9..
//  Copyright (c) 2012년 DearMai. All rights reserved.
//

#import "AirportListViewController.h"

#import "AirportCell.h"
#import "ViewController.h"

#import "AirportController.h"

#import "Airport.h"

@interface AirportListViewController () {
    AirportController *airportController;
}



@end

@implementation AirportListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (IBAction)actionClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    airportController = [AirportController getInstance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [airportController countAirports];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CELL_AIRPORT";
    
    AirportCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Airport *airport = [airportController airportAtIndex:indexPath.row];
    [cell.name setText:airport.name];
    [cell.icao setText:airport.icao];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Airport *airport = [airportController airportAtIndex:indexPath.row];
    
    ViewController *vc;
    vc = (ViewController *)self.presentingViewController;
    if(vc == nil) {
        vc = (ViewController *)self.presentedViewController;
    }
    if(vc == nil) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SCENE_MAIN"];
    }
    
    NSLog(@"%@", vc.labelAirport);
    
    if(self.airportType == Depature) vc.departureAirport = airport;
    else vc.arrivalAirport = airport;
    
    [vc actionReloadAirportData];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
