//
//  GeocodeViewController.m
//  02-Geocoder的使用
//
//  Created by apple on 15/1/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "GeocodeViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface GeocodeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *addressFIeld;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

/**
 *  地理编码
 */
- (IBAction)geocode;

@end

@implementation GeocodeViewController

- (IBAction)geocode {
    // 1.取出用户输入的地址
    NSString *address = self.addressFIeld.text;
    if (address.length == 0) {
        NSLog(@"输入地址不能为空");
        return;
    }
    
    // 2.地理编码
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        // 1.如果解析有错误,或者解析出的数组个数为0.直接返回
        if (placemarks.count == 0 || error) return;
        
        // 2.便利所有的地标对象(如果是实际开发,可以给用户以列表的形式展示)
        for (CLPlacemark *pm in placemarks) {
            // 2.1.取出用户的位置信息
            CLLocation *location = pm.location;
            // 2.2.取出用户的经纬度
            CLLocationCoordinate2D coordinate = location.coordinate;
            
            // 2.3.将信息设置到界面上
            self.latitudeLabel.text = [NSString stringWithFormat:@"%.2f", coordinate.latitude];
            self.longitudeLabel.text = [NSString stringWithFormat:@"%.2f",coordinate.longitude];
            self.resultLabel.text = pm.name;
        }
    }];
}
@end
