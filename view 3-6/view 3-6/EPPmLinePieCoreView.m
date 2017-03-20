//
//  EPPmLinePieCoreView.m
//  view 3-6
//
//  Created by lu_ios on 17/3/6.
//  Copyright © 2017年 luchanghao. All rights reserved.
//

#import "EPPmLinePieCoreView.h"
#import "EPDrawPieView.h"
#import "EPLinePieInfoView.h"
#import "UIView+Frame.h"
#import "EPLinePieLineView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

CGFloat distanceBetweenPoints (CGPoint first, CGPoint second) {
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY );
};


@interface EPPmLinePieCoreModel ()

@end


@implementation EPPmLinePieCoreModel


-(void)setPmLinePievalueArray:(NSMutableArray *)pmLinePievalueArray{
    _pmLinePievalueArray = pmLinePievalueArray;
    [self setDataForValue];
    [self setupFrame];
    [self getBestPointForLine];
}

-(void)setDataForValue{
    for (NSInteger i = 0; i < _pmLinePievalueArray.count; i++) {
        _totalValue += [_pmLinePievalueArray[i] floatValue];
    }
    NSArray *sortedArray = [_pmLinePievalueArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        int obj11 = [obj1 intValue];
        int obj22 = [obj2 intValue];
        NSComparisonResult result = obj11 - obj22;
        return result;
    }];
    
    
    NSMutableArray *aaa = [NSMutableArray new];
    NSMutableArray *bbb = [NSMutableArray new];

    for (NSString *str in sortedArray) {
        for (int i = 0; i<_pmLinePievalueArray.count; i++)
        {
            if (str == _pmLinePievalueArray[i]) {
                
                if ([bbb containsObject:_downTitleArray[i]]) {
                    continue;
                }
                else{
                    [aaa addObject:_downTitleArray[i]];
                    [bbb addObject:_downTitleArray[i]];
                    break;
                }
            }
        }
    }
    
    
    //从大到小
    _pmLinePievalueArray = [NSMutableArray arrayWithArray:sortedArray];
    _downTitleArray = [NSMutableArray arrayWithArray:aaa];
    //拆分数组
    self.leftArray = [NSMutableArray new];
    self.rightArray  = [NSMutableArray new];
    
    NSMutableArray *leftStrArray = [NSMutableArray new];
    NSMutableArray *rightStrArray = [NSMutableArray new];
    
    for (int i = 0; i<_pmLinePievalueArray.count; i++) {
        if (i%2) {
            [_leftArray addObject:_pmLinePievalueArray[i]];
            [leftStrArray addObject:_downTitleArray[i]];
        }
        else{
            [_rightArray addObject:_pmLinePievalueArray[i]];
            [rightStrArray addObject:_downTitleArray[i]];
        }
    }
    _leftArray = [NSMutableArray arrayWithArray :[[_leftArray reverseObjectEnumerator] allObjects]];
    self.valueArray = [NSMutableArray array];
    [self.valueArray addObjectsFromArray:_leftArray];
    [self.valueArray addObjectsFromArray:_rightArray];
    
    leftStrArray = [NSMutableArray arrayWithArray :[[leftStrArray reverseObjectEnumerator] allObjects]];
    self.upTitleArray = [NSMutableArray array];
    [self.upTitleArray addObjectsFromArray:leftStrArray];
    [self.upTitleArray addObjectsFromArray:rightStrArray];
}

-(void)setupFrame{
    //设置默认八种frame
    self.infoViewFrame = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@"",@"",@""]];
    for (NSInteger i = 0; i < 8; i++) {
        
        CGFloat width = 60;
        CGFloat height = 50;
        CGRect frame = CGRectMake(0, 0, width, height);
        
        if (i<4) {
            frame.origin.x = 20;
            frame.origin.y = (3-i%4)* 60 + 5;
            
        }
        else{
            frame.origin.x = SCREEN_WIDTH - 80;
            frame.origin.y = (i%4) * 60 + 5;
        }
        
        if (i==0 || i== 3) {
            frame.origin.x +=35;
        }
        if (i==4 || i== 7) {
            frame.origin.x -= 35;
        }
        
        if (i== 3) {
            frame.origin.x +=10;
            frame.origin.y += 5;
        }
        if (i==4) {
            frame.origin.x -= 10;
            frame.origin.y += 5;
        }
        
        if (i== 1 || i==2) {
            frame.origin.x +=10;
        }
        if (i==5 || i== 6) {
            frame.origin.x -= 10;
        }
        
        NSValue *frameValue = [NSValue valueWithCGRect:frame];
        _infoViewFrame[i] = frameValue;
    }
    
    NSMutableArray *aaArray = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@"",@"",@""]];
    //确定left对应frame位置
    int count1 = 3;
    int jiange1 = (int)(4- _leftArray.count);
    for (int i = (int)_leftArray.count-1; i>-1; i--) {
        CGFloat value =  [_leftArray[i] floatValue];
        if (value/_totalValue >= 0.25
            && jiange1 >0) {
            jiange1 -= 1;
            aaArray[i] = @(count1 -1);
            count1 -=1;
        }
        else{
            aaArray[i] = @(count1);
        }
        count1 -=1;
        
        if (i==0
            && jiange1 >0
            && _leftArray.count >2
            ) {
            jiange1 -= 1;
            aaArray[i] = @(0);
        }
    }
    
    //确定right对应frame位置
    int count2 = 4;
    int jainge2 =(int)( 4 - _rightArray.count);
    for (int i = (int)_leftArray.count; i<self.valueArray.count; i++) {
        CGFloat value =  [self.valueArray[i] floatValue];
        if (value/_totalValue >= 0.25
            && jainge2 > 0) {
            jainge2 -=1;
            aaArray[i] = @(count2 +1);
            count2 +=1;
        }
        else{
            aaArray[i] = @(count2);
        }
        count2 +=1;
        if (i == self.valueArray.count-1
            && jainge2 > 0
            && _rightArray.count>2) {
            jainge2 -=1;
            aaArray[i] = @(7);
            count2 +=1;
        }
    }
    
    //重新分配对应的frame
    NSMutableArray *bbArray = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@"",@"",@""]];
    for (int i = 0; i<self.valueArray.count; i++) {
        bbArray[i] = _infoViewFrame[  [aaArray[i] intValue] ];
    }
    _infoViewFrame = bbArray;
}

-(void)getBestPointForLine{
    
    self.angleArray = [NSMutableArray new];
    self.centerPointRadArray = [NSMutableArray new];
    self.centerPointArray = [NSMutableArray new];
    self.startAngleArray = [NSMutableArray new];
    _startAngle = (-90/180.f)*M_PI;

    //设置全部角度
    [self.startAngleArray addObject:@(self.startAngle)];
    for (NSInteger i = 0; i < self.valueArray.count; i++) {
        
        CGFloat angle = [self countAngle:[self.valueArray[i] floatValue]];
        
        [self.angleArray addObject:@(angle)];
        
        [self.startAngleArray addObject:@([self.startAngleArray[i] floatValue] + angle)];
    }
    int count = (int)self.startAngleArray.count;
    int halfCount;
    if (count%2) {
        halfCount = (count+ 1)*0.5;
    }
    else{
        halfCount = count *0.5;
    }
    CGFloat aa = [self.startAngleArray[halfCount-1] floatValue];
    CGFloat cc = -90/180.0 * M_PI;
    CGFloat bb = aa - cc;
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i< self.startAngleArray.count; i++) {
        NSNumber *value = self.startAngleArray[i];
        value = @([value floatValue]-bb);
        [array addObject:value];
    }
    self.startAngleArray = array;
    
    
    //找最佳连线找点
    for (int i = 0; i<self.valueArray.count; i++) {
        //中点
        NSArray *array1 = [self getBezierPathCenterPointWithStartAngle:[self.startAngleArray[i] floatValue] endAngle:[self.startAngleArray[i+1] floatValue]];
        CGPoint middlePoint = [array1[0] CGPointValue];
        CGFloat middleRad = [array1[1] floatValue];
        //up点
        NSArray *array2 = [self getBezierPathCenterPointWithStartAngle:[self.startAngleArray[i] floatValue] endAngle:middleRad];
        CGPoint upPoint = [array2[0] CGPointValue];
        //down点
        NSArray *array3 = [self getBezierPathCenterPointWithStartAngle:middleRad endAngle:[self.startAngleArray[i+1] floatValue]];
        CGPoint downPoint = [array3[0] CGPointValue];
        
        CGRect infoFrame = [_infoViewFrame[i] CGRectValue];
        CGPoint linkpoint;
        if (self.valueArray.count%2) {
            if (i<(self.valueArray.count-1) *0.5) {
                linkpoint = CGPointMake(infoFrame.origin.x+infoFrame.size.width, infoFrame.origin.y+ infoFrame.size.height *0.6);
            }
            else{
                linkpoint = CGPointMake(infoFrame.origin.x, infoFrame.origin.y+ infoFrame.size.height *0.6);
            }
        }
        else {
            if (i<(self.valueArray.count) *0.5) {
                linkpoint = CGPointMake(infoFrame.origin.x+infoFrame.size.width, infoFrame.origin.y+ infoFrame.size.height *0.6);
            }
            else{
                linkpoint = CGPointMake(infoFrame.origin.x, infoFrame.origin.y+ infoFrame.size.height *0.6);
            }
        }
        
        linkpoint.x -= SCREEN_WIDTH*0.5;
        linkpoint.y -= (200) * 0.5;
        double linkTomid =   distanceBetweenPoints(linkpoint, middlePoint);
        double linkToup =   distanceBetweenPoints(linkpoint, upPoint);
        double linkTodown =   distanceBetweenPoints(linkpoint, downPoint);
        CGFloat gg = 20;
        double pointDistance =  MIN( MIN(fabs(linkTomid-gg) , fabs(linkToup-gg) ) , fabs(linkTodown-gg) );
        
        if (pointDistance == fabs(linkToup-gg) ) {
            [self.centerPointRadArray addObject:array2[1]];
            [self.centerPointArray addObject:array2[0]];
        }
        if (pointDistance == fabs(linkTomid-gg) ) {
            [self.centerPointRadArray addObject:array1[1]];
            [self.centerPointArray addObject:array1[0]];
        }
        if (pointDistance == fabs(linkTodown-gg) ) {
            [self.centerPointRadArray addObject:array3[1]];
            [self.centerPointArray addObject:array3[0]];
        }
    }
    
    //只有一个数据的特殊情况
    if (self.valueArray.count == 1) {
        NSArray *array = [self getBezierPathCenterPointWithStartAngle:-90/180.0*M_PI endAngle:90/180.0*M_PI];
        self.centerPointRadArray = [NSMutableArray arrayWithObject:array[1]] ;
        self.centerPointArray = [NSMutableArray arrayWithObject:array[0]] ;
    }
}


- (CGFloat)countAngle:(CGFloat)value{
    //计算百分比
    CGFloat percent = value / _totalValue;
    //需要多少度的圆弧
    CGFloat angle = M_PI * 2 * percent;
    return angle;
}

//计算中点值工具
- (NSArray *)getBezierPathCenterPointWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle{
    //一半角度(弧度)
    CGFloat halfAngle = (endAngle - startAngle) / 2;
    //中心角度(弧度)
    CGFloat centerAngle = halfAngle + startAngle;
    //中心角度(角度)
    CGFloat realAngle = (centerAngle / M_PI * 180.f);
    
    CGFloat center_xPos = cos(realAngle / 180.f * M_PI) * (self.radius+self.lineWidth*0.5 +5) ;
    CGFloat center_yPos = sin(realAngle / 180.f * M_PI) * (self.radius+self.lineWidth*0.5 +5) ;
    
    CGPoint centerPoint = CGPointMake(center_xPos, center_yPos);
    
    NSValue *centerPointValue = [NSValue valueWithCGPoint:centerPoint];
    
    return  @[ centerPointValue ,@(centerAngle)];
}
@end






@interface EPPmLinePieCoreView()

@property (nonatomic, strong) EPDrawPieView *drawPieView;

/** 存储value的数组 */
@property (nonatomic, strong) NSMutableArray * valueArray;
/** 存储颜色的数组 */
@property (nonatomic, strong) NSMutableArray * colorArray;
/** 存储类型的数组 */
@property (nonatomic, strong) NSMutableArray * typeArray;
/** 总数 */
@property (nonatomic, assign) CGFloat totalValue;
/** 存储开始角度的数组 */
@property (nonatomic, strong) NSMutableArray * startAngleArray;

/** 记录当前path的中心点 */
@property (nonatomic, assign) CGPoint centerPoint;
@property (nonatomic, assign) CGFloat centerPointRad;
@end


@implementation EPPmLinePieCoreView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.drawPieView = [[EPDrawPieView alloc] initWithFrame:self.bounds];
        [self addSubview:_drawPieView];
    }
    return self;
}

-(void)setModel:(EPPmLinePieCoreModel *)model{
    _model = model;
    
    _model.valueArray = model.valueArray;
    _model.colorArray = model.colorArray;

    
    [model setupFrame];
    _drawPieView.model = _model;
    [self drawLines];
}

-(void)drawLines{
    
    self.valueArray = self.model.valueArray;
    self.colorArray = self.model.colorArray;
    self.typeArray  = self.model.downTitleArray;
    self.totalValue = self.model.totalValue;
    self.startAngleArray = self.model.startAngleArray;
    
    for (NSInteger i = 0; i < self.model.valueArray.count; i++) {
        [self setupLine:i];
    }
}

-(void)setupLine:(NSInteger)i{
    //infoview部分
    CGRect frame = [((EPPmLinePieCoreModel *)self.model).infoViewFrame[i] CGRectValue];
    EPLinePieInfoView *infoView = [[EPLinePieInfoView alloc] initWithFrame:frame];
    if (SCREEN_WIDTH < 375) {
        infoView.width = 60;
    }
    CGPoint endPoint;
    self.centerPointRad = [((EPPmLinePieCoreModel *)self.model).centerPointRadArray[i] floatValue];
    if (_centerPointRad >= (-90 / 180.f * M_PI)
        &&_centerPointRad <= (90/180.f *M_PI))
    {
        endPoint = CGPointMake(infoView.left, infoView.top+ infoView.height*0.6);
        infoView.LineType = EPpieDrawLineType_up_right;
    }
    else{
        endPoint = CGPointMake(infoView.left +infoView.width, infoView.top+ infoView.height*0.6);
        infoView.LineType = EPpieDrawLineType_down_left;
    }
    NSInteger count = i;
    
    CGFloat x = [_valueArray[count] floatValue];
    CGFloat y = x/_totalValue *100;
    infoView.upTitle = [NSString stringWithFormat:@"%.0f",y];
    infoView.downTitle = _typeArray[count];
    infoView.upDetailLab.text = @"%";
    infoView.lineColor = _colorArray[count];
    infoView.backgroundColor = [UIColor clearColor];//////////////////////
    [self addSubview:infoView];
    
    
    //折线部分
    CGPoint point = [self.model.centerPointArray[i] CGPointValue];
    point.x += self.width/2;
    point.y += self.height/2;
    EPLinePieLineView *line = [[EPLinePieLineView alloc] initWithStartPoint:point EndPoint:endPoint LineColor:_colorArray[i]];
    [self addSubview:line];
    line.backgroundColor = [UIColor clearColor];
}

@end






















