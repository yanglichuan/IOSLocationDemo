//
//  ViewController.m
//  03-地图的基本使用
//
//  Created by apple on 15/1/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController () <MKMapViewDelegate>

// 显示地图的View
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置代理
    self.mapView.delegate = self;
    
    // 跟踪用户的位置
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    // 设置地图类型
    self.mapView.mapType = MKMapTypeSatellite;
}

/**
 *  定位到用户的位置会执行该方法
 *
 *  @param userLocation 大头针模型
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    // 取出用户的位置
    CLLocationCoordinate2D coordinate = userLocation.location.coordinate;
    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    
    // 改变大头针显示的内容(通过改变大头针模型的属性)
    // userLocation.title = @"广州市";
    // userLocation.subtitle = @"广东省广州市天河区";
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = userLocation.location;
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count == 0 || error) return;
        
        CLPlacemark *pm = [placemarks firstObject];
        
        if (pm.locality) {
            userLocation.title = pm.locality;
        } else {
            userLocation.title = pm.administrativeArea;
        }
        userLocation.subtitle = pm.name;
    }];
}

@end
