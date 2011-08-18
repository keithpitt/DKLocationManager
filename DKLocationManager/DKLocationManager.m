//
//  DKLocationManager.m
//  DiscoKit
//
//  Created by Keith Pitt on 13/07/11.
//  Copyright 2011 Mostly Disco. All rights reserved.
//

#import "DKLocationManager.h"

@implementation DKLocationManager

@synthesize locationManager, currentLocation, locationUpdatedBlock,
            locationErrorBlock, stubbedLocation;

- (id)init {
    
    if ((self = [super init])) {
        
        // Setup the location manager 
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        locationManager.distanceFilter = 10; // or whatever
        
    }
    
    return self;
    
}

- (id)initWithStubbedLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude {
    
    if ((self = [self init])) {
        stubbedLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    }
    
    return self;
    
}


- (void)findLocation {
    
    if (self.stubbedLocation) {
        [self locationManager:self.locationManager didUpdateToLocation:self.stubbedLocation fromLocation:nil];
    } else {
        [self.locationManager startUpdatingLocation];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    // Test the age of the location measurement to determine if the measurement is cached
    // in most cases you will not want to rely on cached measurements
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    
    if (locationAge > 5.0) return;
    
    // Test that the horizontal accuracy does not indicate an invalid measurement
    if (newLocation.horizontalAccuracy < 0) return;
    
    // Store the new location
    self.currentLocation = newLocation;
    
    // Call the location updated block
    if (self.locationUpdatedBlock)
        self.locationUpdatedBlock(newLocation);
    
    // IMPORTANT!!! Minimize power usage by stopping the location manager as soon as possible.
    [self.locationManager stopUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    // Call the location error block
    if (self.locationErrorBlock) {
        self.locationErrorBlock(error);
    }
    
}

- (void)dealloc {
    
    // Releation the location updated block
    if (locationUpdatedBlock) {
        Block_release(locationUpdatedBlock);
    }
    
    // Releation the location error block
    if (locationErrorBlock) {
        Block_release(locationErrorBlock);
    }
        
    // Release the location manager
    self.locationManager = nil;
    
    [super dealloc];
    
}

@end
