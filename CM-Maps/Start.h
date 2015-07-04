//
//  ViewController.h
//  CM-Maps
//
//  Created by Walter Gonzalez Domenzain on 27/06/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Start : UIViewController<CLLocationManagerDelegate>
@property (strong, nonatomic)   CLLocationManager   *locationManager;
@property (strong, nonatomic)   CLLocation          *location;
@property (strong, nonatomic) IBOutlet UILabel *lblCountry;
@property (strong, nonatomic) IBOutlet UILabel *lblName;

@end

