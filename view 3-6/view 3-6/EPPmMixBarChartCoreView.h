//
//  EPPmMixBarChartCoreView.h
//  view 3-6
//
//  Created by lu_ios on 17/3/8.
//  Copyright © 2017年 luchanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPPmMixBarChartCoreModel : NSObject

-(instancetype)initWithDict:(NSArray *)array;

@property (nonatomic, assign) CGFloat height;

//输出
@property (nonatomic, strong) NSMutableArray *anchorPointArray;
@property (nonatomic, strong) NSMutableArray *lineHeightArray;
@property (nonatomic, strong) NSMutableArray *
oneValueArray;
@property (nonatomic, strong) NSMutableArray *
twoValueArray;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *YHeight;
@property (nonatomic, assign) CGFloat marge;
@end







@interface EPPmMixBarChartCoreView : UIView
@property (nonatomic, strong) EPPmMixBarChartCoreModel *model;
@end










@interface EPPmMixBarLine : UIView

-(instancetype)initWithAnchorPoint:(CGPoint)anchorPoint viewHeight:(CGFloat) viewHeight;

-(void)setWithOneColor:(UIColor *)oneColor oneValue:(NSString *)oneValue twoColor:(UIColor *)twoColor twoValue:(NSString *)twoValue;

@property (nonatomic, strong) NSString *title;
/////////////////////////////////////////////////////
@property (nonatomic, strong) UIColor *oneColor;
@property (nonatomic, strong) UIColor *twoColor;
@property (nonatomic, assign) CGPoint anchorPoint;
@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, strong) NSString *oneValue;
@property (nonatomic, strong) NSString *twoValue;
@end
