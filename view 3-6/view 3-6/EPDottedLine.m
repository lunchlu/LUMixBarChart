//
//  EPDottedLine.m
//  view 3-6
//
//  Created by lu_ios on 17/3/9.
//  Copyright © 2017年 luchanghao. All rights reserved.
//

#import "EPDottedLine.h"

@interface EPDottedLine ()
@property (nonatomic, strong) CALayer *line;

@end

@implementation EPDottedLine

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    //获得处理的上下文
    CGContextRef context =UIGraphicsGetCurrentContext();
    //开始一个起始路径
    CGContextBeginPath(context);
    //设置线条粗细宽度
    CGContextSetLineWidth(context, 1);
    //设置线条的颜色
    
    
    if (_lineColor) {
        CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
    }
    else{
        CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    }
    
    //lengths说明虚线如何交替绘制,lengths的值{4，4}表示先绘制4个点，再跳过4个点，如此反复
    CGFloat lengths[] = {2,1};
    //画虚线
    CGContextSetLineDash(context, 0, lengths,2);
    //设置开始点的位置
    CGContextMoveToPoint(context, 0, self.frame.size.height/2);
    //设置终点的位置
    CGContextAddLineToPoint(context,self.frame.size.width - 20 ,self.frame.size.height/2);
    //开始绘制虚线
    CGContextStrokePath(context);
    //封闭当前线路
    CGContextClosePath(context);
    
}


@end
