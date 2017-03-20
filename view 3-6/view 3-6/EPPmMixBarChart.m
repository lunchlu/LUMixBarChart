//
//  EPPmMixBarChart.m
//  view 3-6
//
//  Created by lu_ios on 17/3/8.
//  Copyright © 2017年 luchanghao. All rights reserved.
//

#import "EPPmMixBarChart.h"
#import "EPPmMixBarChartCoreView.h"
#import "UIView+Frame.h"

#define COLOR_HEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface EPPmMixBarChart ()
@property (nonatomic, strong) EPPmMixBarChartCoreView *coreView;
@property (nonatomic, strong) UILabel *leftPerLab;
@property (nonatomic, strong) UILabel *rightPerLab;

@end

@implementation EPPmMixBarChart

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup{
    self.coreView = [[EPPmMixBarChartCoreView alloc] initWithFrame:(CGRectMake(10, 0, SCREEN_WIDTH-20, 420/3))];
    _coreView.top = 140/3;
    [self addSubview:_coreView];
    
    
    UIView *leftImg = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 10, 10))];
    leftImg.top = 20;
    leftImg.left = 200/3;
    leftImg.backgroundColor = COLOR_HEX(0xef7e3e);
    [self addSubview:leftImg];
    
    UILabel *leftTitleLab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 50, 15))];
    leftTitleLab.left = leftImg.right;
    leftTitleLab.centerY = leftImg.centerY;
    leftTitleLab.textAlignment = NSTextAlignmentCenter;
    leftTitleLab.textColor = COLOR_HEX(0x999999);
    leftTitleLab.font = [UIFont systemFontOfSize:12];
    leftTitleLab.text = @"中端";
    [self addSubview:leftTitleLab];
    
    self.leftPerLab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 50, 17))];
    _leftPerLab.left = leftTitleLab.right;
    _leftPerLab.centerY = leftImg.centerY;
    _leftPerLab.textAlignment = NSTextAlignmentLeft;
    _leftPerLab.textColor = COLOR_HEX(0x666666);
    _leftPerLab.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:_leftPerLab];
    
    
    
    
    
    
    UIView *rightImg = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 10, 10))];
    rightImg.top = 20;
    rightImg.left = SCREEN_WIDTH - _leftPerLab.right;
    rightImg.backgroundColor = COLOR_HEX(0x84c24e);
    [self addSubview:rightImg];
    
    UILabel *rightTitleLab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 50, 15))];
    rightTitleLab.left = rightImg.right;
    rightTitleLab.centerY = rightImg.centerY;
    rightTitleLab.textAlignment = NSTextAlignmentCenter;
    rightTitleLab.textColor = COLOR_HEX(0x999999);
    rightTitleLab.font = [UIFont systemFontOfSize:12];
    rightTitleLab.text = @"低端";
    [self addSubview:rightTitleLab];
    
    self.rightPerLab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 50, 17))];
    _rightPerLab.left = rightTitleLab.right;
    _rightPerLab.centerY = rightImg.centerY;
    _rightPerLab.textAlignment = NSTextAlignmentLeft;
    _rightPerLab.textColor = COLOR_HEX(0x666666);
    _rightPerLab.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:_rightPerLab];

}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    EPPmMixBarChartCoreModel *model = [[EPPmMixBarChartCoreModel alloc] initWithDict:dataArray];
    model.height = _coreView.height;
    _coreView.model = model;
    
    CGFloat oneTotal = 0;
    for (NSString *str in model.oneValueArray) {
        oneTotal += [str floatValue];
    }
    
    CGFloat twoTotal = 0;
    for (NSString *str in model.twoValueArray) {
        twoTotal += [str floatValue];
    }
    
    _leftPerLab.text = [NSString stringWithFormat:@"%.0f%%",oneTotal/(oneTotal + twoTotal) *100];
    
    _rightPerLab.text = [NSString stringWithFormat:@"%.0f%%",(100-oneTotal/(oneTotal + twoTotal) *100)];
}

@end















