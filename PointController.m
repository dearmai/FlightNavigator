//
//  PointController.m
//  FlightNavigator
//
//  Created by Yoo Rinjae on 12. 11. 9..
//  Copyright (c) 2012년 DearMai. All rights reserved.
//

#import "PointController.h"
#import "DataBuilder.h"
#import "SignificantPoint.h"

static PointController *instance = nil;

@implementation PointController {
}

@synthesize points;

+ (PointController *)getInstance {
    @synchronized(self){
        if(instance == nil) {
            // 리소스 경로 가져오기
            NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"point" ofType:@"txt"];
            NSRange match = [bundlePath rangeOfString:@"point\\.txt$" options:NSRegularExpressionSearch];
            bundlePath = [bundlePath substringToIndex:match.location - 1];
            
            NSLog(@"%d", match.location);
            NSLog(@"%@", bundlePath);
            
            instance = [[PointController alloc] initWithBundlePath:bundlePath];
        }
    }
    return instance;
}

- (id)initWithBundlePath:(NSString *)newBundlePath {
    if ([self init]) {
        DataBuilder *builder = [[DataBuilder alloc] initWithDataPath:newBundlePath];
        points = [builder buildSignificantPoint];
    }
    return self;
}

#pragma -
- (SignificantPoint *)pointObjectAtIndex:(NSUInteger)index {
    return [points objectAtIndex:index];
}

- (NSUInteger)countPoints {
    return [points count];
}

- (SignificantPoint *)pointObjectAtName:(NSString *)newName {
    for (int i = 0; i < [points count]; i++){
        SignificantPoint *point = [points objectAtIndex:i];
        if([point.name isEqualToString:newName] == YES) {
            return point;
        }
    }
    return nil;
}


- (int)pointIndexWithName:(NSString *)newName {
    for (int i = 0; i < [points count]; i++){
        SignificantPoint *point = [points objectAtIndex:i];
        if([point.name isEqualToString:newName] == YES) {
            return i;
        }
    }
    return -1;
}

@end
