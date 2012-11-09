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

#import "PointAnnotation.h"
#import "AirportAnnotation.h"

#import "SignificantPoint.h"
#import "Airport.h"

@interface ViewController () {
    PointController *pointController;
}



@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnDeparture;
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

@implementation ViewController

@synthesize labelAirport;

#pragma -
- (void)actionReloadAirportData {
    NSString *depature, *arrival, *str;
    
    NSLog(@"ViewController#actionReloadAirportData");
    NSLog(@"%@", labelAirport);
    
    if(self.departureAirport == nil) depature = @"선택 않됨";
    else depature = self.departureAirport.name;
    
    if(self.arrivalAirport == nil) arrival = @"선택 않됨";
    else arrival = self.arrivalAirport.name;
    
    str = [NSString stringWithFormat:@"출발 공항 : %@, 도착 공항 : %@", depature, arrival];
    
    NSLog(@"%@", self.labelAirport);
    
    [self.labelAirport setText:str];
    self.labelAirport.text = str;
    
    // Display annocation
    for (MKAnnotationView *anno in [self.map annotations]) {
        [self.map removeAnnotation:(id)anno];
    }
    
    if(self.departureAirport != nil) {
        AirportAnnotation *anno = [[AirportAnnotation alloc] init];
        CLLocationCoordinate2D location;
        location.latitude = self.departureAirport.latitude;
        location.longitude = self.departureAirport.longitude;
        anno.title = self.departureAirport.name;
        anno.coordinate = location;
        
        MKPinAnnotationView *pinAnno =
            [[MKPinAnnotationView alloc] initWithAnnotation:anno
                                            reuseIdentifier:self.departureAirport.name];
        pinAnno.pinColor = MKPinAnnotationColorRed;
        [self.map addAnnotation:(id<MKAnnotation>)pinAnno];
    }
    
    if(self.arrivalAirport != nil) {
        AirportAnnotation *anno = [[AirportAnnotation alloc] init];
        CLLocationCoordinate2D location;
        location.latitude = self.arrivalAirport.latitude;
        location.longitude = self.arrivalAirport.longitude;
        anno.title = self.arrivalAirport.name;
        anno.coordinate = location;
        
        MKPinAnnotationView *pinAnno = [[MKPinAnnotationView alloc] initWithAnnotation:anno reuseIdentifier:self.arrivalAirport.name];
        [self.map addAnnotation:(id<MKAnnotation>)pinAnno];
    }
    
    NSLog(@"%@", self.labelAirport.text);
}

#pragma -
- (IBAction)actionSelectAirport:(UIBarButtonItem *)sender {
    
    AirportListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SCENE_AIRPORT"];
    
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    vc.airportType = sender.tag;
    
    [self presentViewController:vc animated:YES completion:nil];
    //[self performSegueWithIdentifier:@"AIRPORT" sender:self];
    //self.view.alpha = 0.5;
}

- (IBAction)actionCalcPath:(UIBarButtonItem *)sender {
    if(self.departureAirport == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                        message:@"출발 공항이 선택 되지 않았습니다."
                                                       delegate:nil
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if(self.arrivalAirport == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림"
                                                        message:@"도착 공항이 선택 되지 않았습니다."
                                                       delegate:nil
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
}
#pragma -
- (void)viewDidLoad
{
    [super viewDidLoad];

//    pointController = [PointController getInstance];
//    
//    for(NSUInteger i = 0; i < [pointController countPoints]; i++){
//        SignificantPoint *point = [pointController pointObjectAtIndex:i];
//        CLLocationCoordinate2D location;
//        location.latitude = point.latitude;
//        location.longitude = point.longitude;
//        PointAnnotation *pointAnno = [[PointAnnotation alloc] initWithTitle:point.name
//                                                                andLocation:location];
//        
//        [self.map addAnnotation:pointAnno];
//        //[self.map viewForAnnotation:pointAnno];
//    }
//    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    double ratio = 5;
    span.latitudeDelta = ratio;
    span.longitudeDelta = ratio;
    
    CLLocationCoordinate2D location;
    location.latitude = 35.395785;
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
