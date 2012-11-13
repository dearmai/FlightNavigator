//
//  AirportController.h
//  FlightNavigator
//
//  Created by Yoo Rinjae on 12. 11. 10..
//  Copyright (c) 2012년 DearMai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Airport;

@interface AirportController : NSObject

@property NSArray *airports;

+ (AirportController *)getInstance;

- (Airport *)airportAtIndex:(NSUInteger)index;
- (NSUInteger)countAirports;
- (NSInteger)findKeyWithICAO:(NSString *)newICAO;

@end
