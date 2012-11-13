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

@property NSArray *points;

+ (PointController *)getInstance;

- (SignificantPoint *)pointObjectAtIndex:(NSUInteger)index;
- (SignificantPoint *)pointObjectAtName:(NSString *)newName;
- (NSUInteger)countPoints;
- (int)pointIndexWithName:(NSString *)newName;

@end
