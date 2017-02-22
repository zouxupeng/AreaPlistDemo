//
//  ViewController.m
//  TestPlist
//
//  Created by 郑超杰 on 2017/2/21.
//  Copyright © 2017年 ButterJie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *rootArray;
/** 2.当前省数组 */
@property (nonatomic, strong, nullable) NSMutableArray *arrayProvince;
/** 3.当前城市数组 */
@property (nonatomic, strong, nullable) NSMutableArray *arrayCity;
/** 4.当前地区数组 */
@property (nonatomic, strong, nullable) NSMutableArray *arrayArea;
/** 5.当前街道数组 */
@property (nonatomic, strong, nullable) NSMutableArray *arrayStreets;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1. 获取省份
    [self.rootArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.arrayProvince addObject:obj[@"state"]];
    }];

    //2. 随便获取一个省的城市
    NSMutableArray *citys = [NSMutableArray arrayWithArray:[self.rootArray objectAtIndex:12][@"cities"]];
    [citys enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.arrayCity addObject:obj[@"city"]];
    }];
    
    //3. 随便获取一个城市的（县，区，等）
    NSMutableDictionary *countyDic = [NSMutableDictionary dictionaryWithDictionary:citys[0][@"areas"]];
    [countyDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.arrayArea addObject:key];
    }];
    
    //4. 随便获取一个（县，区，等）的（街道，乡，等）
    [countyDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSArray *obj, BOOL * _Nonnull stop) {
        [self.arrayStreets addObjectsFromArray:obj];
        *stop = YES;
    }];
}

- (NSArray *)rootArray {
    if (!_rootArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
        _rootArray = [[NSArray array] initWithContentsOfFile:path];
    }
    return _rootArray;
}

- (NSMutableArray *)arrayProvince
{
    if (!_arrayProvince) {
        _arrayProvince = [NSMutableArray array];
    }
    return _arrayProvince;
}

- (NSMutableArray *)arrayCity
{
    if (!_arrayCity) {
        _arrayCity = [NSMutableArray array];
    }
    return _arrayCity;
}

- (NSMutableArray *)arrayArea
{
    if (!_arrayArea) {
        _arrayArea = [NSMutableArray array];
    }
    return _arrayArea;
}

- (NSMutableArray *)arrayStreets {
    if (!_arrayStreets) {
        _arrayStreets = [NSMutableArray array];
    }
    return _arrayStreets;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
