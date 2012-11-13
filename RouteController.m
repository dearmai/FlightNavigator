//
//  RouteController.m
//  FlightNavigator
//
//  Created by Yoo Rinjae on 12. 11. 10..
//  Copyright (c) 2012년 DearMai. All rights reserved.
//

#import "RouteController.h"

#import "DataBuilder.h"

#import "FlightRoute.h"

static RouteController *instance = nil;

@implementation RouteController {
}

@synthesize routes;

+ (RouteController *)getInstance {
    @synchronized(self){
        if(instance == nil) {
            // 리소스 경로 가져오기
            NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"point" ofType:@"txt"];
            NSRange match = [bundlePath rangeOfString:@"point\\.txt$" options:NSRegularExpressionSearch];
            bundlePath = [bundlePath substringToIndex:match.location - 1];
            
            NSLog(@"%d", match.location);
            NSLog(@"%@", bundlePath);
            
            instance = [[RouteController alloc] initWithBundlePath:bundlePath];
        }
    }
    return instance;
}

- (id)initWithBundlePath:(NSString *)newBundlePath {
    if ([self init]) {
        DataBuilder *builder = [[DataBuilder alloc] initWithDataPath:newBundlePath];
        routes = [builder buildFlightRoute];
    }
    return self;
}

#pragma -
- (FlightRoute *)routeAtIndex:(NSUInteger)index {
    return [routes objectAtIndex:index];
}
- (NSUInteger)countRoutes {
    return [routes count];
}
- (NSInteger)findKeyWithName:(NSString *)name {
    NSInteger i = 0;
    for(FlightRoute *route in routes){
        if([route.name isEqualToString:name] == YES) {
            return i;
        }
        i++;
    }
    return -1;
}

@end
