//
//  TLChartRateView.m
//  ChartTableView
//
//  Created by hello on 2019/4/3.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "TLChartRateView.h"

@interface TLChartRateView()

@property (nonatomic,strong) CALayer * contentLayer;

@end

@implementation TLChartRateView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        _needleRadius       = 5;
        _needleColor        = [UIColor blackColor];
        
        _lineWidth          = 1;
        _lineColor          = [UIColor blackColor];
        
        _title              = @"饼图/速率图";
        _titleFont          = 15;
        _titleColor         = [UIColor redColor];
        
        _arcWidth           = 15;
        _arcData            = @"0";
        _arcColor0          = [UIColor colorWithRed:82.0 / 255.0 green:116.0 / 255.0 blue:188.0 / 255.0 alpha:1.0f];
        _arcColor1          = [UIColor grayColor];
        
        _defaultTextArr     = @[@"30",@"70"];
        _defaultTextFont    = 12;
        _defaultTextColor   = [UIColor grayColor];

        
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    [self.layer addSublayer:self.contentLayer];
    
    [self tl_layoutContent];
    
}
- (void)reloadData{

    self.layer.contents = nil;
    [self tl_layoutContent];
//    [self layoutSubviews];
    
}

- (CALayer *)contentLayer{
    if (_contentLayer == nil) {
        
        _contentLayer = [CALayer layer];
        _contentLayer.backgroundColor = [UIColor clearColor].CGColor;
        _contentLayer.frame = self.bounds;

    }
    return _contentLayer;
}
- (void)tl_layoutContent{
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //文字居中显示在画布上
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;// 这个属性是能够画字符的时候换行
    paragraphStyle.alignment = NSTextAlignmentCenter;

    //画title
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:_titleFont],NSForegroundColorAttributeName:_titleColor,NSParagraphStyleAttributeName:paragraphStyle};
    [_title drawInRect:CGRectMake(0, 0, CGRectGetWidth(self.frame), _titleFont) withAttributes:attributes];
    
    
    //画半圆
    CGContextSetLineWidth(context, _arcWidth);
    CGContextSetLineCap(context, kCGLineCapButt);//线条起点终点样式

    // 计算空白半径
    CGFloat radius = CGRectGetWidth(self.frame)/2 - _arcWidth/2;
    double angle = -M_PI -(-M_PI *[_arcData floatValue]);
    /*
       CGFloat x    圆心x坐标
       CGFloat y  圆形y坐标
       CGFloat radius  圆半径
       CGFloat startAngle  起始弧度
       CGFloat endAngle  结束弧度
       int clockwise  绘制方向，0 顺时针，1 逆时针
     */
    //第一段
    [_arcColor0 setStroke];
    CGContextAddArc(context, CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame), radius, -M_PI, angle, 0);
    CGContextDrawPath(context, kCGPathStroke);
    //第二段
    [_arcColor1 setStroke];
    CGContextAddArc(context, CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame), radius, angle, 0, 0);
    CGContextDrawPath(context, kCGPathStroke);
    
    //虚线
    [_lineColor setStroke];
    CGContextSetLineWidth(context, _lineWidth);
    CGFloat lengths[] = {3,2};//线长，空白长
    CGContextSetLineDash(context, 0, lengths, 2);//起始长度-lengths-lengths数组长度
    //横
    CGContextMoveToPoint(context, 0, CGRectGetHeight(self.frame) -_lineWidth);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) -_lineWidth);
    CGContextStrokePath(context);
    //竖
    CGContextMoveToPoint(context, CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame) -CGRectGetWidth(self.frame)/2);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame));
    CGContextStrokePath(context);
    
    //content文字
    for (int i =0; i <_defaultTextArr.count; i ++) {
        
        NSString *contentStr = _defaultTextArr[i];
        CGRect rect;
        if (0 == i) {
            paragraphStyle.alignment = NSTextAlignmentLeft;
            rect = CGRectMake(_arcWidth +5, CGRectGetHeight(self.frame) -(_defaultTextFont +2), CGRectGetWidth(self.frame)/2 -(_arcWidth +5), _defaultTextFont);
        }else{
            paragraphStyle.alignment = NSTextAlignmentRight;
            rect = CGRectMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame) -(_defaultTextFont +2), CGRectGetWidth(self.frame)/2 -(_arcWidth +5), _defaultTextFont);
        }
        
        //画content
        NSDictionary *attribute = @{ NSFontAttributeName:[UIFont systemFontOfSize:_defaultTextFont],NSForegroundColorAttributeName:_defaultTextColor,NSParagraphStyleAttributeName:paragraphStyle};
        [contentStr drawInRect:rect withAttributes:attribute];
        
    }
    
    //针
    [_needleColor setFill];
    //针头point
    CGPoint point0 = [self calcCircleCoordinateWithCenter:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)) andWithAngle:angle andWithRadius:CGRectGetWidth(self.frame)/2];

    //针尾左边弧度
    double angle1 = angle -M_PI_2;
    //针尾右边弧度
    double angle2 = angle +M_PI_2;

    CGContextAddArc(context, CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame) -_needleRadius, _needleRadius, angle1, angle2, 1);
    CGContextAddLineToPoint(context, point0.x, point0.y);
    CGContextFillPath(context);
    
    UIImage * currentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.contentLayer.contents = (__bridge id _Nullable)(currentImage.CGImage);
}
#pragma mark 计算圆圈上点在IOS系统中的坐标
/*
 center中心点坐标
 angle是角度，如果是6个点 应分别传入 60 120 180 240 300 360
 radius半径
 */
- (CGPoint)calcCircleCoordinateWithCenter:(CGPoint)center andWithAngle:(CGFloat)angle andWithRadius: (CGFloat) radius{
    
    CGFloat x2 = radius*cosf(angle);
    CGFloat y2 = radius*sinf(angle);
    return CGPointMake(center.x+x2, center.y+y2);
}

@end
