//
//  AirportController.m
//  FlightNavigator
//
//  Created by Yoo Rinjae on 12. 11. 10..
//  Copyright (c) 2012년 DearMai. All rights reserved.
//

#import "AirportController.h"

#import "DataBuilder.h"

#import "Airport.h"

static AirportController *instance = nil;

@implementation AirportController {
    NSArray *airports;
}

+ (AirportController *)getInstance {
    @synchronized(self){
        if(instance == nil) {
            // 리소스 경로 가져오기
            NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"point" ofType:@"txt"];
            NSRange match = [bundlePath rangeOfString:@"point\\.txt$" options:NSRegularExpressionSearch];
            bundlePath = [bundlePath substringToIndex:match.location - 1];
            
            NSLog(@"%d", match.location);
            NSLog(@"%@", bundlePath);
            
            instance = [[AirportController alloc] initWithBundlePath:bundlePath];
        }
    }
    return instance;
}

- (id)initWithBundlePath:(NSString *)newBundlePath {
    if ([self init]) {
        DataBuilder *builder = [[DataBuilder alloc] initWithDataPath:newBundlePath];
        airports = [builder buildAirport];
    }
    return self;
}

#pragma -
- (Airport *)airportAtIndex:(NSUInteger)index {
    return [airports objectAtIndex:index];
}
- (NSUInteger)countAirports {
    return [airports count];
}

@end
