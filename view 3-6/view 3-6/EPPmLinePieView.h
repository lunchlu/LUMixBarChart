//
//  EPPmLinePieView.h
//  view 3-6
//
//  Created by lu_ios on 17/3/6.
//  Copyright © 2017年 luchanghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPPmLinePieView : UIView
@property (nonatomic, strong) NSMutableArray *valueArray;
@property (nonatomic, strong) NSMutableArray *colorArray;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) NSMutableArray *downTitleArray;
@end
