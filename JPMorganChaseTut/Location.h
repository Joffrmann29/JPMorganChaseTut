//
//  JMLocations.h
//  HomePlaces
//
//  Created by Fiseha Wondimu on 7/22/14.
//  Copyright (c) 2014 Fiseha Wondimu All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Location : NSObject<MKAnnotation>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zip;
@property (nonatomic, strong) NSString *locType;
@property (nonatomic, strong) NSString *distance;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (nonatomic) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)name address:(NSString*)address andLocType:(NSString *)locType andDistance:(NSString *)distance andCity:(NSString *)city andState:(NSString *)state andZip:(NSString *)zip andLatitude:(NSString *)latitude andLongitude:(NSString *)longitude;

-(id)initWithDictionary:(NSDictionary *)dictionary;

-(MKAnnotationView *)annotationView;

@end
