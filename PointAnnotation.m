//
//  MapViewAnnotation.m
//  FlightNavigator
//
//  Created by Yoo Rinjae on 12. 11. 9..
//  Copyright (c) 2012년 DearMai. All rights reserved.
//

#import "PointAnnotation.h"

@implementation PointAnnotation

- (id)initWithTitle:(NSString *)newTitle andLatitude:(double)latitude
       andLongitude:(double)longitude {
    CLLocationCoordinate2D location;
    location.latitude = latitude;
    location.longitude = longitude;
    
    return [self initWithTitle:newTitle andLocation:location];
}

- (id)initWithTitle:(NSString *)newTitle andLocation:(CLLocationCoordinate2D)newLocation {
    if ([self init]){
        self.title = newTitle;
        self.coordinate = newLocation;
    }
    return self;
}

@end
