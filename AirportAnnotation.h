//
//  AirportAnnotation.h
//  FlightNavigator
//
//  Created by Yoo Rinjae on 12. 11. 10..
//  Copyright (c) 2012년 DearMai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AirportAnnotation : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property CLLocationCoordinate2D coordinate;

@end
