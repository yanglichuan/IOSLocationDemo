//
//  RervsecodeViewController.m
//  02-Geocoder的使用
//
//  Created by apple on 15/1/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "RervsecodeViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface RervsecodeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *latitudeField;
@property (weak, nonatomic) IBOutlet UITextField *longitudeField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

/**
 *  反地理编码
 */
- (IBAction)rervsecode;

@end

@implementation RervsecodeViewController

- (IBAction)rervsecode {
    // 1.取出输入的经纬度
    NSString *latitude = self.latitudeField.text;
    NSString *longitude = self.longitudeField.text;
    if (latitude.length == 0 || longitude.length == 0) {
        return;
    }
    
    // 2.反地理编码
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude.floatValue longitude:longitude.floatValue];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        // 如果有错误,或者解析出来的地址数量为0
        if (placemarks.count == 0 || error) return ;
        
        // 取出地标,就可以取出地址信息,以及CLLocation对象
        CLPlacemark *pm = [placemarks firstObject];
        
#warning 注意:如果是取出城市的话,需要判断locality属性是否有值(直辖市时,该属性为空)
        if (pm.locality) {
            self.resultLabel.text = pm.locality;
        } else {
            self.resultLabel.text = pm.administrativeArea;
        }
    }];
}
@end
