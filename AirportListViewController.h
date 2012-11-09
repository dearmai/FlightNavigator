//
//  AirportListViewController.h
//  FlightNavigator
//
//  Created by Yoo Rinjae on 12. 11. 9..
//  Copyright (c) 2012년 DearMai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

typedef enum {
    Depature = 0, Arrival = 1
} AirportType;

@interface AirportListViewController : UITableViewController

@property ViewController* parentViewController;
@property AirportType airportType;

@end
