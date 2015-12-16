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
#import "MyAnnotationView.h"

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
    
    // 2.添加自己的大头针的View
    MyAnnotationView *myAnnoView = [MyAnnotationView myAnnoViewWithMapView:mapView];
    
    return myAnnoView;
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
//    // 1.如果是用户位置的大头针,直接返回nil,使用系统的
//    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
//    
//    // 2.添加自己的大头针的View
//    static NSString *ID = @"myAnnoView";
//    MyAnnotationView *myAnnoView = (MyAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
//    if (myAnnoView == nil) {
//        myAnnoView = [[MyAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:ID];
//        
//        // 设置图片
//        // myAnnoView.image = [UIImage imageNamed:@"category_1"];
//        // 1.设置标题和子标题可以呼出
//        myAnnoView.canShowCallout = YES;
//        
//        // 2.在左右两侧放一个View
//        myAnnoView.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
//        myAnnoView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    }
//    MyAnnotation *anno = (MyAnnotation *)annotation;
//    myAnnoView.image = [UIImage imageNamed:anno.icon];
//    
//    return myAnnoView;
//}

/**
 *  大头针的View已经被添加mapView会执行该方法
 *
 *  @param views   所有大头针的View都存放在该数组中
 */
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    //MKModernUserLocationView
    for (MKAnnotationView *annoView in views) {
        // 如果是系统的大头针View直接返回
        if ([annoView.annotation isKindOfClass:[MKUserLocation class]]) return;
        
        // 取出大头针View的最终应该在位置
        CGRect endFrame = annoView.frame;
        
        // 给大头针重新设置一个位置
        annoView.frame = CGRectMake(endFrame.origin.x, 0, endFrame.size.width, endFrame.size.height);
        
        // 执行动画
        [UIView animateWithDuration:0.5 animations:^{
            annoView.frame = endFrame;
        }];
    }
}

- (IBAction)addAnnotation {
    MyAnnotation *anno1 = [[MyAnnotation alloc] init];
    anno1.coordinate = CLLocationCoordinate2DMake(40.06, 116.39);
    anno1.title = @"北京市";
    anno1.subtitle = @"中国北京市昌平区";
    anno1.icon = @"category_1";
    [self.mapView addAnnotation:anno1];
    
    MyAnnotation *anno2 = [[MyAnnotation alloc] init];
    anno2.coordinate = CLLocationCoordinate2DMake(30.23, 120.23);
    anno2.title = @"杭州市";
    anno2.subtitle = @"浙江省杭州市萧山区";
    anno2.icon = @"category_2";
    [self.mapView addAnnotation:anno2];
}
@end
