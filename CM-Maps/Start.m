//
//  ViewController.m
//  CM-Maps
//
//  Created by Walter Gonzalez Domenzain on 27/06/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import "Start.h"
@import GoogleMaps;

#define         nLocalizing     0
#define         nLocalized      1

//Localization
float                   mlatitude;
float                   mlongitude;
static int              iLocalizeState = nLocalizing;

@implementation Start {
    GMSMapView          *mapView;
    GMSMarker           *markerLocation;
    GMSCameraPosition   *camera;
}
/**********************************************************************************************/
#pragma mark - Initialization methods
/**********************************************************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Location
    self.locationManager                    = [[CLLocationManager alloc] init];
    self.locationManager.delegate           = self;
    self.location                           = [[CLLocation alloc] init];
    self.locationManager.desiredAccuracy    = kCLLocationAccuracyBest;
    [self.locationManager  requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**********************************************************************************************/
#pragma mark - Maps methods
/**********************************************************************************************/
- (void) paintMap {
    [mapView removeFromSuperview];
    camera                      = [GMSCameraPosition cameraWithLatitude:mlatitude longitude:mlongitude zoom:14.0];
    mapView                     = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.frame               = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20);
    mapView.myLocationEnabled   = YES;
    [self paintMarker];
    [self.view addSubview:mapView];
}
//------------------------------------------------------------
- (void) paintMarker {
    GMSMarker *marker       = [[GMSMarker alloc] init];
    marker.position         = camera.target;
    
    /*CGFloat lat = (CGFloat)[mmaPlacesLat[i] floatValue];
    CGFloat lng = (CGFloat)[mmaPlacesLng[i] floatValue];
    position = CLLocationCoordinate2DMake(lat, lng);
    markerLocation      = [GMSMarker markerWithPosition:position];*/
    
    marker.title            = @"UAG";
    marker.snippet          = @"Clase de Maestría";
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView;
}
/**********************************************************************************************/
#pragma mark - Localization
/**********************************************************************************************/
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.location = locations.lastObject;
    NSLog(@"didUpdateLocation!");
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:self.locationManager.location completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark *placemark in placemarks) {
            NSString *addressName = [placemark name];
            NSString *city = [placemark locality];
            NSString *administrativeArea = [placemark administrativeArea];
            NSString *country  = [placemark country];
            NSString *countryCode = [placemark ISOcountryCode];
            NSLog(@"name is %@ and locality is %@ and administrative area is %@ and country is %@ and country code %@", addressName, city, administrativeArea, country, countryCode);
        }
        mlatitude = self.locationManager.location.coordinate.latitude;
        mlongitude = self.locationManager.location.coordinate.longitude;
        NSLog(@"mlatitude = %f", mlatitude);
        NSLog(@"mlongitude = %f", mlongitude);
        if (iLocalizeState == nLocalizing) {
            [self paintMap];
            iLocalizeState = nLocalized;
        }
    }];
    
}
@end
