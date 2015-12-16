//
//  MyAnnotationView.h
//  05-添加大头针
//
//  Created by apple on 15/1/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MyAnnotationView : MKAnnotationView

+ (instancetype)myAnnoViewWithMapView:(MKMapView *)mapView;

@end
