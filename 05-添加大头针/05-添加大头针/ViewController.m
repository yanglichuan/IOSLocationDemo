//
//  ViewController.m
//  05-添加大头针
//
//  Created by apple on 15/1/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"

@interface ViewController () <MKMapViewDelegate>

// 显示地图的View
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置代理
    self.mapView.delegate = self;
    
    // 2.跟踪用户的位置
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    // 3.添加两个大头针
    MyAnnotation *anno1 = [[MyAnnotation alloc] init];
    anno1.coordinate = CLLocationCoordinate2DMake(40.06, 116.39);
    anno1.title = @"北京市";
    anno1.subtitle = @"中国北京市昌平区";
    
    MyAnnotation *anno2 = [[MyAnnotation alloc] init];
    anno2.coordinate = CLLocationCoordinate2DMake(30.23, 120.23);
    anno2.title = @"杭州市";
    anno2.subtitle = @"浙江省杭州市萧山区";
    
    [self.mapView addAnnotation:anno1];
    [self.mapView addAnnotation:anno2];
}

/**
 *  定位到用户的位置会调用该方法
 *
 *  @param userLocation 大头针模型对象
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    // 设置用户的位置为地图的中心点
    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获取用户点击的点
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    // 2.将该点转化成经纬度(地图上的坐标)
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.view];
    
    // 3.添加大头针
    MyAnnotation *anno = [[MyAnnotation alloc] init];
    anno.coordinate = coordinate;
    anno.title = @"传智播客";
    anno.subtitle = @"传智播客是中国IT教育的摇篮";
    [self.mapView addAnnotation:anno];
}

@end
