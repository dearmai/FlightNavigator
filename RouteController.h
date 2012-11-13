//
//  RouteController.h
//  FlightNavigator
//
//  Created by Yoo Rinjae on 12. 11. 10..
//  Copyright (c) 2012년 DearMai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FlightRoute;

@interface RouteController : NSObject

@property NSArray *routes;

+ (RouteController *)getInstance;

- (id)routeAtIndex:(NSUInteger)index;
- (NSUInteger)countRoutes;
- (NSInteger)findKeyWithName:(NSString *)name;

@end
