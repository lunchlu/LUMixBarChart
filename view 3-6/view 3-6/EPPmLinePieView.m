//
//  EPPmLinePieView.m
//  view 3-6
//
//  Created by lu_ios on 17/3/6.
//  Copyright © 2017年 luchanghao. All rights reserved.
//

#import "EPPmLinePieView.h"
#import "UIView+Frame.h"
#import "EPPmLinePieCoreView.h"

//画图颜色
//紫色
#define EPColor_Purple COLOR_HEX(0xa48fd9)
//黄色
#define EPColor_Yellow COLOR_HEX(0xf9d546)
//蓝绿色
#define EPColor_BlueGreen COLOR_HEX(0x3fdec3)
//橙色
#define EPColor_Orange COLOR_HEX(0xfd964c)
//红色
#define EPColor_Red COLOR_HEX(0xff6969)
//蓝色
#define EPColor_Blue COLOR_HEX(0x12bdff)
//绿色
#define EPColor_Green COLOR_HEX(0x5fdd9e)
//深蓝
#define EPColor_DarkBlue COLOR_HEX(0x2e96c9)
//青色
#define EPColor_Cyan COLOR_HEX(0x93dc58)
//深绿
#define EPColor_DarkGreen COLOR_HEX(0x1eafad)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define COLOR_HEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation EPPmLinePieView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup{
    UILabel  *titleLab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 40))];
    titleLab.left = 20;
    titleLab.text = @"经营统计";
    titleLab.textColor = COLOR_HEX(0x333333);
    titleLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:titleLab];
    
    UIView *line = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 0.5))];
    line.backgroundColor = COLOR_HEX(0xdedede);
    line.bottom = titleLab.bottom;
    [self addSubview:line];
    
    
}

-(void)setValueArray:(NSMutableArray *)valueArray{
    _valueArray = valueArray;
    EPPmLinePieCoreModel *model = [[EPPmLinePieCoreModel alloc] init];
    model.radius = self.radius;
    model.lineWidth = self.lineWidth;
    model.colorArray = self.colorArray;
    model.downTitleArray = self.downTitleArray;
    model.pmLinePievalueArray = self.valueArray;

    EPPmLinePieCoreView *view = [[EPPmLinePieCoreView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 250))];
    view.top = 40;
    view.model = model;
    [self addSubview:view];
    
    
    UIView *line = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 0.5))];
    line.backgroundColor = COLOR_HEX(0xdedede);
    line.bottom = view.bottom;
    [self addSubview:line];
}

@end














