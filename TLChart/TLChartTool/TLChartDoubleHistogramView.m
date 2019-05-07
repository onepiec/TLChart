//
//  TLChartDoubleHistogramView.m
//  ChartTableView
//
//  Created by hello on 2019/4/1.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "TLChartDoubleHistogramView.h"

@interface TLChartDoubleHistogramView()


@property (nonatomic,weak) CALayer * contentLayer;
@property (nonatomic,assign)CGFloat allLineWidth;

@end
@implementation TLChartDoubleHistogramView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _corner = 4;
        _verTitleWidth = 80;
        _horTitleHeight = 50;
        
        _titleColor = [UIColor blackColor];
        _contentColor = [UIColor blackColor];
        _verTitleFont = 15;
        _horTitleFont = 15;
        _contentFont = 12;
        _lineColor = [UIColor blackColor];
        _lineWidth = 1;
        _extLineWidth = 3;
        
    }
    return self;
}
- (void)choseItemAction:(UITapGestureRecognizer *)tapGesture{
    
    CGPoint tapPoint =  [tapGesture locationInView:self];
    CGFloat cellHeight = (CGRectGetHeight(self.frame) -_horTitleHeight)/self.verTitleArr.count;
    
    for (int i =0; i <self.verTitleArr.count; i ++) {
        
        CGFloat itemtWidth0 = _allLineWidth *[self.data0Arr[i] floatValue];
        CGFloat itemtWidth1 = _allLineWidth *[self.data1Arr[i] floatValue];
        
        if ((tapPoint.x >= _verTitleWidth && tapPoint.x <= _verTitleWidth +itemtWidth0) &&
            (tapPoint.y >= cellHeight/9 +cellHeight *i && tapPoint.y <= cellHeight *4/9 +cellHeight *i)) {

            if (self.clickBlock) {
                self.clickBlock(0, i);
            }
            return;
        }
        if ((tapPoint.x >= _verTitleWidth && tapPoint.x <= _verTitleWidth +itemtWidth1) &&
            (tapPoint.y >= cellHeight *5/9 +cellHeight *i && tapPoint.y <= cellHeight *8/9 +cellHeight *i)) {
            
            if (self.clickBlock) {
                self.clickBlock(1, i);
            }
            return;
        }
        
        
    }
    
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    [self.layer addSublayer:self.contentLayer];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choseItemAction:)];
    [self addGestureRecognizer:tap];
    
    [self tl_layoutContent];
    
}
- (void)reloadData{
    self.layer.contents = nil;
    [self tl_layoutContent];
}
- (CALayer *)contentLayer{
    if (_contentLayer == nil) {
        CALayer * contentLayer = [CALayer layer];
        contentLayer.backgroundColor = [UIColor clearColor].CGColor;
        contentLayer.frame = self.bounds;
        _contentLayer = contentLayer;
    }
    return _contentLayer;
}
- (void)tl_layoutContent{
    
    //文字居中显示在画布上
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;// 这个属性是能够画字符的时候换行
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, _lineWidth);
    
    
    [_lineColor setStroke];
    // 画竖线
    CGContextSetLineWidth(context, _lineWidth);
    CGContextMoveToPoint(context, _verTitleWidth, 0);
    CGContextAddLineToPoint(context, _verTitleWidth, CGRectGetHeight(self.frame) -_horTitleHeight);
    CGContextStrokePath(context);
    
    
    //画横线
    CGSize lastStrSize = [[self.horTitleArr lastObject] sizeWithAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:_horTitleFont],NSForegroundColorAttributeName:_titleColor,NSParagraphStyleAttributeName:paragraphStyle}];
    _allLineWidth = CGRectGetWidth(self.frame) -_verTitleWidth -lastStrSize.width/2;
    
    CGContextSetLineWidth(context, _lineWidth);
    CGContextMoveToPoint(context, _verTitleWidth, CGRectGetHeight(self.frame) -_horTitleHeight);
    CGContextAddLineToPoint(context, _verTitleWidth +_allLineWidth, CGRectGetHeight(self.frame) -_horTitleHeight);
    CGContextStrokePath(context);
    
    //画额外的横线
    CGFloat cellHeight = (CGRectGetHeight(self.frame) -_horTitleHeight)/self.verTitleArr.count;
    for (int i = 0; i < self.verTitleArr.count +1; i ++) {
        
        CGContextSetLineWidth(context, _lineWidth);
        CGContextMoveToPoint(context, _verTitleWidth -_extLineWidth, cellHeight *i);
        CGContextAddLineToPoint(context, _verTitleWidth, cellHeight *i);
        CGContextStrokePath(context);
    }
    //画额外的竖线
    CGFloat cellWidth = _allLineWidth/(self.horTitleArr.count -1);
    for (int i = 0; i < self.horTitleArr.count; i ++) {
        
        CGContextSetLineWidth(context, _lineWidth);
        CGContextMoveToPoint(context, _verTitleWidth +cellWidth *i, CGRectGetHeight(self.frame) -_horTitleHeight);
        CGContextAddLineToPoint(context, _verTitleWidth +cellWidth *i, CGRectGetHeight(self.frame) -_horTitleHeight +_extLineWidth);
        CGContextStrokePath(context);
    }
    
    //画竖向的标题
    CGFloat allHorExtHeight = 0;
    for (int i =0; i <self.verTitleArr.count; i ++) {
        
        NSString *title = self.verTitleArr[i];
        
        NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:_verTitleFont],NSForegroundColorAttributeName:_titleColor,NSParagraphStyleAttributeName:paragraphStyle};
        
        CGSize strSize = [title sizeWithAttributes:attributes];
        CGFloat newPointY = allHorExtHeight +(cellHeight -strSize.height)/2;
        
        [title drawInRect:CGRectMake(0, newPointY, _verTitleWidth, strSize.height) withAttributes:attributes];
        allHorExtHeight = allHorExtHeight +cellHeight;
    }
    
    //画横向的标题
    CGFloat allVerExtHeight = 0;
    for (int i =0; i <self.horTitleArr.count; i ++) {
        
        NSString *title = self.horTitleArr[i];
        
        NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:_horTitleFont],NSForegroundColorAttributeName:_titleColor,NSParagraphStyleAttributeName:paragraphStyle};
        
        CGSize strSize = [title sizeWithAttributes:attributes];
        
        [title drawInRect:CGRectMake(_verTitleWidth +allVerExtHeight -strSize.width/2, CGRectGetHeight(self.frame) -_horTitleHeight +(_horTitleHeight -strSize.height)/2, strSize.width, strSize.height) withAttributes:attributes];
        
        allVerExtHeight = allVerExtHeight +cellWidth;
    }
    
    //画柱状图
    for (int i =0; i <self.verTitleArr.count; i ++) {
        
        //画第一种柱状图
        UIColor *content0Color = [UIColor redColor];
        if (self.dataColor0Arr.count >0) {
            content0Color = self.dataColor0Arr[i];
        }
        [content0Color setFill];

        CGFloat itemWidth0 = _allLineWidth *[self.data0Arr[i] floatValue];

        CGContextMoveToPoint(context, _verTitleWidth, cellHeight/9 +cellHeight *i);
        
        CGContextAddArcToPoint(context, _verTitleWidth +itemWidth0, cellHeight/9 +cellHeight *i, _verTitleWidth +itemWidth0, cellHeight/9 +cellHeight *i +_corner *2, _corner);
        CGContextAddArcToPoint(context, _verTitleWidth +itemWidth0, cellHeight *4/9 +cellHeight *i, _verTitleWidth +itemWidth0 -_corner *2, cellHeight *4/9 +cellHeight *i, _corner);
        
//        CGContextAddLineToPoint(context, _verTitleWidth +itemWidth0, cellHeight/9 +cellHeight *i);
//        CGContextAddLineToPoint(context, _verTitleWidth +itemWidth0,cellHeight *4/9 +cellHeight *i);
        CGContextAddLineToPoint(context,_verTitleWidth, cellHeight *4/9 +cellHeight *i);
        CGContextFillPath(context);

        //画第一种柱状图里面的文字
        NSDictionary *attributes0 = @{ NSFontAttributeName:[UIFont systemFontOfSize:_contentFont],NSForegroundColorAttributeName:_contentColor,NSParagraphStyleAttributeName:paragraphStyle};

        NSString *title0 = self.dataTitle0Arr[i];
        CGSize strSize0 = [title0 sizeWithAttributes:attributes0];
        [title0 drawInRect:CGRectMake(_verTitleWidth, cellHeight/9 +cellHeight *i +(cellHeight/3 -strSize0.height)/2, itemWidth0, strSize0.height) withAttributes:attributes0];
        
        
        //画第二种柱状图
        UIColor *content1Color = [UIColor redColor];
        if (self.dataColor1Arr.count >0) {
            content1Color = self.dataColor1Arr[i];
        }
        [content1Color setFill];
        
        CGFloat itemWidth1 = _allLineWidth *[self.data1Arr[i] floatValue];
        
        CGContextMoveToPoint(context, _verTitleWidth, cellHeight *5/9 +cellHeight *i);
        
        CGContextAddArcToPoint(context, _verTitleWidth +itemWidth1, cellHeight *5/9 +cellHeight *i, _verTitleWidth +itemWidth1, cellHeight *5/9 +cellHeight *i +_corner *2, _corner);
        CGContextAddArcToPoint(context, _verTitleWidth +itemWidth1, cellHeight *8/9 +cellHeight *i, _verTitleWidth +itemWidth1 -_corner *2, cellHeight *8/9 +cellHeight *i, _corner);
        
//        CGContextAddLineToPoint(context, _verTitleWidth +itemWidth1, cellHeight *5/9 +cellHeight *i);
//        CGContextAddLineToPoint(context, _verTitleWidth +itemWidth1,cellHeight *8/9 +cellHeight *i);
        CGContextAddLineToPoint(context,_verTitleWidth, cellHeight *8/9 +cellHeight *i);
        CGContextFillPath(context);
        
        //画第二种柱状图里面的文字
        NSDictionary *attributes1 = @{ NSFontAttributeName:[UIFont systemFontOfSize:_contentFont],NSForegroundColorAttributeName:_contentColor,NSParagraphStyleAttributeName:paragraphStyle};
        
        NSString *title1 = self.dataTitle1Arr[i];
        CGSize strSize1 = [title1 sizeWithAttributes:attributes1];
        [title1 drawInRect:CGRectMake(_verTitleWidth, cellHeight *5/9 +cellHeight *i +(cellHeight/3 -strSize1.height)/2, itemWidth1, strSize1.height) withAttributes:attributes1];
    }
    
    
    
    UIImage * currentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.contentLayer.contents = (__bridge id _Nullable)(currentImage.CGImage);
    
}

@end
