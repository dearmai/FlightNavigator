//
//  MapViewAnnotation.h
//  FlightNavigator
//
//  Created by Yoo Rinjae on 12. 11. 9..
//  Copyright (c) 2012년 DearMai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointAnnotation : NSObject <MKAnnotation> 

@property (nonatomic, copy) NSString *title;
@property CLLocationCoordinate2D coordinate;

- (id)initWithTitle:(NSString *)newTitle andLatitude:(double)latitude
       andLongitude:(double)longitude;
- (id)initWithTitle:(NSString *)newTitle andLocation:(CLLocationCoordinate2D)newLocation;

@end
