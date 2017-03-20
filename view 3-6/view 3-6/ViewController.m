//
//  ViewController.m
//  view 3-6
//
//  Created by lu_ios on 17/3/6.
//  Copyright © 2017年 luchanghao. All rights reserved.
//

#import "ViewController.h"
#import "EPPmLinePieCoreView.h"
#import "EPPmLinePieView.h"
#import "EPPmMixBarChart.h"
#import "UIView+Frame.h"


#define COLOR_HEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    EPPmMixBarChart *view = [[EPPmMixBarChart alloc] initWithFrame:(CGRectMake(0, 40, SCREEN_WIDTH, 660/3))];
    [self.view addSubview:view];
    NSMutableArray *array = [NSMutableArray arrayWithArray:  @[
                                   @{
                                       @"title":@"iOS",
                                       @"oneValue":@"10",
                                       @"twoValue":@"25",
                                       },
                                   @{
                                       @"title":@"Android",
                                       @"oneValue":@"20",
                                       @"twoValue":@"25",
                                       },
                                   @{
                                       @"title":@"java",
                                       @"oneValue":@"10",
                                       @"twoValue":@"15",
                                       },
                                   @{
                                       @"title":@"iOS",
                                       @"oneValue":@"10",
                                       @"twoValue":@"25",
                                       },
                                   @{
                                       @"title":@"Android",
                                       @"oneValue":@"20",
                                       @"twoValue":@"25",
                                       },
                                   @{
                                       @"title":@"java",
                                       @"oneValue":@"10",
                                       @"twoValue":@"15",
                                       },
                                   @{
                                       @"title":@"iOS",
                                       @"oneValue":@"10",
                                       @"twoValue":@"25",
                                       },
                                   @{
                                       @"title":@"Android",
                                       @"oneValue":@"20",
                                       @"twoValue":@"25",
                                       },
                                   @{
                                       @"title":@"java",
                                       @"oneValue":@"10",
                                       @"twoValue":@"15",
                                       },
                                   
                                                               ]
                             ];
    view.dataArray = array;
    
}


@end
