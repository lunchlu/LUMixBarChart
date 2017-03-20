//
//  EPPmMixBarChartCoreView.m
//  view 3-6
//
//  Created by lu_ios on 17/3/8.
//  Copyright © 2017年 luchanghao. All rights reserved.
//

#import "EPPmMixBarChartCoreView.h"
#import "UIView+Frame.h"
#import "EPDottedLine.h"

#define COLOR_HEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface EPPmMixBarChartCoreView ()
@property (nonatomic, strong) UIScrollView *scrollViwe;
@end

@implementation EPPmMixBarChartCoreView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup{
    self.scrollViwe = [[UIScrollView alloc] initWithFrame:(CGRectMake(0, 0, self.width-30, self.height))];
    _scrollViwe.left = 30;
    _scrollViwe.bounces = NO;
    _scrollViwe.showsVerticalScrollIndicator = NO;
    _scrollViwe.showsHorizontalScrollIndicator= NO;
    [self addSubview:_scrollViwe];
    
    UIView *Xline = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, _scrollViwe.width, 1))];
    Xline.backgroundColor = COLOR_HEX(0x999999);
    Xline.left = _scrollViwe.left;
    Xline.bottom = _scrollViwe.bottom - 20;
    [self addSubview:Xline];
    
    UIView *Yline = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 1, _scrollViwe.height - 20))];
    Yline.backgroundColor = COLOR_HEX(0x999999);
    Yline.left = _scrollViwe.left;
    [self addSubview:Yline];
    
    [self setupYvalueView];

}

-(void)setModel:(EPPmMixBarChartCoreModel *)model {
    _model = model;
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[EPPmMixBarLine class]]) {
            [view removeFromSuperview];
        }
    }
    
    for (int i = 0; i< model.titleArray.count; i++) {
        EPPmMixBarLine *barLine = [[EPPmMixBarLine alloc] initWithAnchorPoint:(CGPointMake(30+i*50, [model.YHeight.lastObject floatValue])) viewHeight:[model.lineHeightArray[i] floatValue]];
        [barLine setWithOneColor:COLOR_HEX(0xef7e3e) oneValue:model.oneValueArray[i] twoColor:COLOR_HEX(0x84c24e) twoValue:model.twoValueArray[i]];
        barLine.title = model.titleArray[i];
        [_scrollViwe addSubview:barLine];
    }
    
    _scrollViwe.contentSize = CGSizeMake(30 +50*_model.titleArray.count, 0);
    
    [self makeYvalueData];
    
}


-(void)setupYvalueView{
    
    CGFloat start = 10;
    CGFloat jiange = (self.height - 20 - 10)/6;
    NSMutableArray *YHeight = [[NSMutableArray alloc] initWithArray:@[@(0*jiange +start),@(1*jiange+start),@(2*jiange+start),@(3*jiange+start),@(4*jiange+start),@(5*jiange+start),@(6*jiange+start),]];
    
    
    for (int i = 0; i<7; i++) {
        UILabel * lab = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 25, 20))];
        lab.left = 0;
        lab.centerY = [YHeight[i] floatValue];
        [self addSubview:lab];
        lab.textColor = [UIColor whiteColor];
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = [UIFont systemFontOfSize:10];
        lab.textColor = COLOR_HEX(0x999999);
        lab.tag = 3000 +i;
        [self addSubview:lab];
        
        
        EPDottedLine *line = [[EPDottedLine alloc] initWithFrame:lab.frame];
        line.width = 1000;
        line.left =0;
        line.centerY = [YHeight[i] floatValue];
        line.lineColor = COLOR_HEX(0xdedede);
        [_scrollViwe addSubview:line];
    }
}

-(void)makeYvalueData{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            
            if (view.tag >= 3000) {
                int f = (int)view.tag-3000;
                NSString *str = [NSString stringWithFormat:@"%.0f",_model.marge * (6-f)];
                [(UILabel *)view setText:str];
                view.centerY = [_model.YHeight[f] floatValue];
            }
        }
    }
}
@end




@interface EPPmMixBarChartCoreModel ()
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSMutableArray *totalArray;
@end

@implementation EPPmMixBarChartCoreModel

-(instancetype)initWithDict:(NSArray *)array{
    if (self = [super init]) {
        self.dataArray = array;
        [self setup];
    }
    return self;
}

-(void)setup{
        
    _totalArray = [NSMutableArray array];
    _titleArray = [NSMutableArray array];
    _oneValueArray = [NSMutableArray array];
    _twoValueArray = [NSMutableArray array];

    for (NSDictionary *dict in _dataArray) {
        [_titleArray addObject:dict[@"title"]];
        [_totalArray addObject:@([dict[@"oneValue"] floatValue] +[dict[@"twoValue"] floatValue])];
        [_oneValueArray addObject:dict[@"oneValue"]];
        [_twoValueArray addObject:dict[@"twoValue"]];
    }
}

-(void)setHeight:(CGFloat)height{
    _height = height;
    
    [self setupYvalue:_totalArray];
}


//－－－－－－－－－－－－－－－－－－－－－－－－－
- (void)setupYvalue:(NSArray *)array{
    
    NSArray *_valueArray = array;
    
    CGFloat start = 10;
    CGFloat jiange = (_height - 20 - 10)/6;
    self.YHeight = [[NSMutableArray alloc] initWithArray:@[@(0*jiange +start),@(1*jiange+start),@(2*jiange+start),@(3*jiange+start),@(4*jiange+start),@(5*jiange+start),@(6*jiange+start),]];
    
    NSArray *sortedArray = [_valueArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        double obj11 = [obj1 doubleValue];
        double obj22 = [obj2 doubleValue];
        NSComparisonResult result = obj11 - obj22;
        return result;
    }];
    CGFloat max = [sortedArray.lastObject floatValue];
    CGFloat marg = (int)((max / 4) / 10 ) *10;
    self.marge = marg;
    
    self.lineHeightArray = [NSMutableArray new];//坐标轴的Y值；
    for (int i = 0; i<_valueArray.count; i++) {
        CGFloat y = (jiange/marg)* [_valueArray[i] floatValue];
        [_lineHeightArray addObject:@(y)];
    }
    
}

@end






@interface EPPmMixBarLine ()
@property (nonatomic, strong) UIView *oneLine;
@property (nonatomic, strong) UIView *twoLine;
@property (nonatomic, strong) UILabel *titleLab;
@end

@implementation EPPmMixBarLine

-(instancetype)initWithAnchorPoint:(CGPoint)anchorPoint viewHeight:(CGFloat)viewHeight{
    if (self = [super init]) {
        self.anchorPoint = anchorPoint;
        self.viewHeight = viewHeight;
        [self setup];
    }
    return self;
}

-(void)setup{
    self.frame = CGRectMake(0, 0, 90, _viewHeight + 20);
    self.centerX = _anchorPoint.x;
    self.bottom = _anchorPoint.y + 20;
    self.backgroundColor = [UIColor clearColor];
    
    self.titleLab = [[UILabel alloc] init];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.font = [UIFont systemFontOfSize:10];
    _titleLab.textColor = COLOR_HEX(0x999999);
    [self addSubview:_titleLab];
    
    self.oneLine = [[UIView alloc] init];
    [self addSubview:_oneLine];
    
    self.twoLine = [[UIView alloc] init];
    [self addSubview:_twoLine];
}

-(void)setWithOneColor:(UIColor *)oneColor oneValue:(NSString *)oneValue twoColor:(UIColor *)twoColor twoValue:(NSString *)twoValue{
    self.oneColor = oneColor;
    self.oneValue = oneValue;
    self.twoColor = twoColor;
    self.twoValue = twoValue;
    
    CGFloat oneHeight = [_oneValue floatValue]/([_oneValue floatValue] + [_twoValue floatValue]) * _viewHeight;
    CGFloat twoHeight = _viewHeight - oneHeight;

    _titleLab.width = 60;
    _titleLab.height = 20;
    _titleLab.centerX = self.width/2;
    _titleLab.bottom = self.height;
    
    _oneLine.height = oneHeight;
    _oneLine.backgroundColor = _oneColor;
    _oneLine.width = 20;
    _oneLine.top = 0;
    _oneLine.centerX = self.width/2;
    
    _twoLine.height = twoHeight;
    _twoLine.backgroundColor = _twoColor;
    _twoLine.width = 20;
    _twoLine.bottom = _titleLab.top;
    _twoLine.centerX = self.width/2;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLab.text = title;
}
@end

















