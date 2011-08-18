//
//  DKLocationManager.h
//  DiscoKit
//
//  Created by Keith Pitt on 13/07/11.
//  Copyright 2011 Mostly Disco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^DKLocationManagerCallback)(CLLocation *);
typedef void (^DKLocationManagerErrorCallback)(NSError *);

@interface DKLocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, copy) DKLocationManagerCallback locationUpdatedBlock;
@property (nonatomic, copy) DKLocationManagerErrorCallback locationErrorBlock;

@property (nonatomic, retain) CLLocationManager * locationManager;

@property (nonatomic, retain) CLLocation * currentLocation;
@property (nonatomic, retain) CLLocation * stubbedLocation;

- (id)initWithStubbedLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude;

- (void)findLocation;

@end
