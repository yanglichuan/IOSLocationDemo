//
//  ViewController.m
//  10-定位补充(iOS8)
//
//  Created by apple on 15/1/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager *mgr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.mgr startUpdatingLocation];
    
    // 如果是iOS8,需要请求授权方式(进行判断,否则在iOS7会崩溃,需要先在info.plist中配置)
    // 1.通过判断系统判断来确定是否需要请求requestAlwaysAuthorization授权
//    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
//        [self.mgr requestAlwaysAuthorization];
//    }
    // 2.通过判断是否有该方法来判断是否需要请求requestAlwaysAuthorization授权
    if ([self.mgr respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.mgr requestAlwaysAuthorization];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"获取到用户的位置");
}

- (CLLocationManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [[CLLocationManager alloc] init];
        _mgr.delegate = self;
    }
    
    return _mgr;
}

@end
