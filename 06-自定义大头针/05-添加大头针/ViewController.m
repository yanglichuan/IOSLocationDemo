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


/**
 *  点击之后添加两个大头针
 */
- (IBAction)addAnnotation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置代理
    self.mapView.delegate = self;
    
    // 2.跟踪用户的位置
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
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

/**
 *  在地图上添加一个大头针就会执行该方法
 *
 *  @param annotation 大头针模型对象
 *
 *  @return 大头针的View(返回nil表示默认使用系统, 默认MKAnnotationView是不可见)
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    // 1.如果是用户位置的大头针,直接返回nil,使用系统的
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    
    // 2.创建标识
    static NSString *ID = @"annoView";
    // 3.从缓冲池中取出大头针的View
    MKPinAnnotationView *annoView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    // 4.如果为nil,则创建
    if (annoView == nil) {
        annoView = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:ID];
        
        // 1.设置标题和子标题可以呼出
        annoView.canShowCallout = YES;
        
        // 2.设置大头针的颜色
        annoView.pinColor = MKPinAnnotationColorPurple;
        
        // 3.掉落效果
        annoView.animatesDrop = YES;
    }
    
    // 5.设置大头针的大头针模型
    annoView.annotation = annotation;
    
    return annoView;
}

- (IBAction)addAnnotation {
    MyAnnotation *anno1 = [[MyAnnotation alloc] init];
    anno1.coordinate = CLLocationCoordinate2DMake(40.06, 116.39);
    anno1.title = @"北京市";
    anno1.subtitle = @"中国北京市昌平区";
    [self.mapView addAnnotation:anno1];
    
    MyAnnotation *anno2 = [[MyAnnotation alloc] init];
    anno2.coordinate = CLLocationCoordinate2DMake(30.23, 120.23);
    anno2.title = @"杭州市";
    anno2.subtitle = @"浙江省杭州市萧山区";
    [self.mapView addAnnotation:anno2];
}
@end
