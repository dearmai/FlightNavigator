//
//  PointController.h
//  FlightNavigator
//
//  Created by Yoo Rinjae on 12. 11. 9..
//  Copyright (c) 2012년 DearMai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SignificantPoint;

@interface PointController : NSObject

+ (PointController *)getInstance;

- (SignificantPoint *)pointObjectAtIndex:(NSUInteger)index;
- (NSUInteger)countPoints;

@end
