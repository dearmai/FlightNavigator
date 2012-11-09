//
//  ViewController.h
//  FlightNavigator
//
//  Created by Yoo Rinjae on 12. 11. 9..
//  Copyright (c) 2012년 DearMai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnDeparture;
@property (weak, nonatomic) IBOutlet MKMapView *map;


- (IBAction)actionSelectAirport:(UIBarButtonItem *)sender;

@end
