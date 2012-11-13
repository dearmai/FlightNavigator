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
#import "RouteController.h"
#import "AirportController.h"

#import "PointAnnotation.h"
#import "AirportAnnotation.h"

#import "SignificantPoint.h"
#import "Airport.h"
#import "FlightRoute.h"

#import "ShortestPath.h"

@interface ViewController () {
    PointController *pointController;
    RouteController *routeController;
    AirportController *airportController;
}



@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnDeparture;
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

@implementation ViewController

@synthesize labelAirport;

#pragma -
- (void)actionReloadAirportData {
    [self reloadDisplayWithPath:NO];
}

-(void)reloadDisplayWithPath:(BOOL)isPath{
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
    
    // 경로 표시
    for (MKOverlayView *view in [self.map overlays]) {
        [self.map removeOverlay:(id)view];
    }
    
    if(isPath == YES){
        // 전체 경로 표시
        NSArray *routes = [routeController routes];
        for(FlightRoute *route in routes){
            NSUInteger routeCount = [route.pointNameArray count];
            CLLocationCoordinate2D coords[routeCount];
            
            for(int i = 0; i < routeCount; i++){
                NSString *name = [route.pointNameArray objectAtIndex:i];
                SignificantPoint *point = [pointController pointObjectAtName:name];
                coords[i].latitude = point.latitude;
                coords[i].longitude = point.longitude;
            }
            
            MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:coords count:routeCount];
            polyLine.title = @"FlightRoute";
            [self.map addOverlay:polyLine];
        }
        
        // 검색된 경로 표시
        ShortestPath *instance = [[ShortestPath alloc] initWithPoints:pointController.points
                                                            andRoutes:routeController.routes
                                                          andAirports:airportController.airports];
        NSArray *route = [instance main:self.departureAirport andArrivalAirport:self.arrivalAirport];
        
        NSUInteger routeCount = [route count] + 3;
        CLLocationCoordinate2D coords[routeCount];
        
        
        coords[0].latitude = self.arrivalAirport.latitude;
        coords[0].longitude = self.arrivalAirport.longitude;
        
        SignificantPoint *nearestArrivalAirport = [instance getNearestPointWithAirport:self.arrivalAirport];
        coords[1].latitude = nearestArrivalAirport.latitude;
        coords[1].longitude = nearestArrivalAirport.longitude;
        
        for(int i = 0; i < routeCount - 3; i++){
            SignificantPoint *point = [route objectAtIndex:i];
            coords[i + 2].latitude = point.latitude;
            coords[i + 2].longitude = point.longitude;
        }
        
        coords[routeCount - 1].latitude = self.departureAirport.latitude;
        coords[routeCount - 1].longitude = self.departureAirport.longitude;
        
        NSLog(@"경로 표시");
        for(int i = 1; i < routeCount; i++){
            NSLog(@"%f - %f", coords[i].latitude, coords[i].longitude);
        }
        
        MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:coords count:routeCount];
        polyLine.title = @"asd";
        [self.map addOverlay:polyLine];
    }
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
    
    [self reloadDisplayWithPath:YES];
}

#pragma Delegate
-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    NSLog(@"이건 뭐지~~~~~~");
    MKPolylineView *polyLineView = [[MKPolylineView alloc] initWithOverlay: overlay];
    
    if([[overlay title] isEqualToString:@"FlightRoute"] == YES) {
        polyLineView.strokeColor = [UIColor blueColor];
        polyLineView.lineWidth   = 1.0;
    } else {
        polyLineView.strokeColor = [UIColor redColor];
        polyLineView.lineWidth   = 5.0;
    }
    return polyLineView;
}

#pragma -
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    pointController = [PointController getInstance];
    airportController = [AirportController getInstance];
    routeController = [RouteController getInstance];

//
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
    [self.map setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
