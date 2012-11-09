//
//  ViewController.m
//  FlightNavigator
//
//  Created by Yoo Rinjae on 12. 11. 9..
//  Copyright (c) 2012년 DearMai. All rights reserved.
//

#import "ViewController.h"

#import "AirportListViewController.h"

#import "PointController.h"
#import "SignificantPoint.h"

#import "PointAnnotation.h"

@interface ViewController () {
    PointController *pointController;
}
@end

@implementation ViewController

#pragma -
- (IBAction)actionSelectAirport:(UIBarButtonItem *)sender {
    
//    AirportListViewController *vc = [[AirportListViewController alloc] init];
//    vc.modalPresentationStyle = UIModalPresentationFormSheet;
//    [self presentViewController:vc animated:YES completion:^{
//        self.view.alpha = 1;
//    }];
    [self performSegueWithIdentifier:@"AIRPORT" sender:self];
    //self.view.alpha = 0.5;
}

#pragma -
- (void)viewDidLoad
{
    [super viewDidLoad];

    pointController = [PointController getInstance];
    
    for(NSUInteger i = 0; i < [pointController countPoints]; i++){
        SignificantPoint *point = [pointController pointObjectAtIndex:i];
        CLLocationCoordinate2D location;
        location.latitude = point.latitude;
        location.longitude = point.longitude;
        PointAnnotation *pointAnno = [[PointAnnotation alloc] initWithTitle:point.name
                                                                andLocation:location];
        
        [self.map addAnnotation:pointAnno];
        //[self.map viewForAnnotation:pointAnno];
    }
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    double ratio = 5;
    span.latitudeDelta = ratio;
    span.longitudeDelta = ratio;
    
    CLLocationCoordinate2D location;
    location.latitude = 35.295785;
    location.longitude = 127.934143;
    
    region.center = location;
    region.span = span;
    
    [self.map setRegion:region];
    [self.map setCenterCoordinate:region.center animated:YES];
    [self.map regionThatFits:region];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
