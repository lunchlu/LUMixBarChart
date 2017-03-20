//
//  EPPmLinePieCoreView.h
//  view 3-6
//
//  Created by lu_ios on 17/3/6.
//  Copyright © 2017年 luchanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPDrawPieView.h"

@interface EPPmLinePieCoreModel : EPDrawPieModel

@property (nonatomic, strong) NSMutableArray *pmLinePievalueArray;

@property (nonatomic, strong) NSMutableArray *upTitleArray;
@property (nonatomic, strong) NSMutableArray *downTitleArray;

@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat totalValue;
@property (nonatomic, strong) NSMutableArray *centerPointRadArray;
@property (nonatomic, strong) NSMutableArray *centerPointArray;
@property (nonatomic, strong) NSMutableArray *infoViewFrame;
@property (nonatomic, strong) NSMutableArray *startPointArray;
@property (nonatomic, strong) NSMutableArray *endPointArray;
@property (nonatomic, strong) NSMutableArray *leftArray;
@property (nonatomic, strong) NSMutableArray *rightArray;
@end

@interface EPPmLinePieCoreView : UIView
@property (nonatomic, strong) EPPmLinePieCoreModel *model;
@end
