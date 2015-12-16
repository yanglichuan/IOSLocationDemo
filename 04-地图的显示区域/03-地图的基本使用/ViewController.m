//
//  ViewController.m
//  03-地图的基本使用
//
//  Created by apple on 15/1/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

#define kLatitudeDelta 0.002703
#define kLongitudeDelta 0.001717

@interface ViewController () <MKMapViewDelegate>

// 显示地图的View
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

/**
 * 点击之后回到用户的位置
 */
- (IBAction)backToUserLocation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置代理
    self.mapView.delegate = self;
    
    // 跟踪用户的位置
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    // 设置地图类型
    // self.mapView.mapType = MKMapTypeSatellite;
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
    
    // 设置mapView显示的位置
    // [mapView setCenterCoordinate:coordinate animated:YES];
    // 设置mapView的显示区域
    MKCoordinateSpan span = MKCoordinateSpanMake(kLatitudeDelta, kLongitudeDelta);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [mapView setRegion:region animated:YES];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    MKCoordinateRegion region = mapView.region;
    CLLocationCoordinate2D center = region.center;
    MKCoordinateSpan span = region.span;
    NSLog(@"纬度:%f 经度:%f", center.latitude, center.longitude);
    NSLog(@"纬度跨度:%f 经度跨度:%f", span.latitudeDelta, span.longitudeDelta);
}

//- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
//{
//    
//}

- (IBAction)backToUserLocation {
    MKCoordinateSpan span = MKCoordinateSpanMake(kLatitudeDelta, kLongitudeDelta);
    MKCoordinateRegion region = MKCoordinateRegionMake(self.mapView.userLocation.location.coordinate, span);
    // [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
    [self.mapView setRegion:region animated:YES];
}
@end
