//
//  ViewController.h
//  FlightNavigator
//
//  Created by Yoo Rinjae on 12. 11. 9..
//  Copyright (c) 2012년 DearMai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Airport;

@interface ViewController : UIViewController <MKMapViewDelegate>

@property Airport *departureAirport, *arrivalAirport;

@property (weak, nonatomic) IBOutlet UILabel *labelAirport;

- (void)actionReloadAirportData;

- (IBAction)actionSelectAirport:(UIBarButtonItem *)sender;

@end
