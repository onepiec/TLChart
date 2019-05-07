//
//  TLChartTableView.m
//  ChartTableView
//
//  Created by hello on 2019/4/1.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "TLChartTableView.h"

@interface TLChartTableView()


@property (nonatomic,weak) CALayer * contentLayer;
@end

@implementation TLChartTableView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {

        _lineColor                  = [UIColor grayColor];
        _lineWidth                  = 1.0;
        
        _horLine0bgColor            = [UIColor colorWithRed:82.0 / 255.0 green:116.0 / 255.0 blue:188.0 / 255.0 alpha:1.0f];
        _horLine0Font               = 15;
        _horLine0TextColor          = [UIColor blackColor];

        _verLine0bgColor            = [UIColor colorWithRed:242.0 / 255.0 green:197.0 / 255.0 blue:117.0 / 255.0 alpha:1.0f];
        _verLine0Font               = 15;
        _verLine0TextColor          = [UIColor blackColor];
        
        _defaultFont                = 15;
        _defaultTextColor           = [UIColor blackColor];
        
    }
    return self;
}
- (void)choseItemAction:(UITapGestureRecognizer *)tapGesture{
    
    CGPoint tapPoint =  [tapGesture locationInView:self];
    
    CGFloat pointY = 0;
    for (int i =0; self.verHeightProArr.count; i ++) {
        
        CGFloat pointX = 0;
        for (int j =0; j <self.horWidthProArr.count; j ++) {
            
            if ((tapPoint.x >= pointX && tapPoint.x <= pointX +[self.horWidthProArr[j] floatValue]) &&
                (tapPoint.y >= pointY && tapPoint.y <= pointY +[self.verHeightProArr[i] floatValue])) {
                
                if (self.clickBlock) {
                    self.clickBlock(j, i);
                }
                return;
            }
            pointX = pointX +[self.horWidthProArr[j] floatValue];
        }
        pointY = pointY +[self.verHeightProArr[i] floatValue];
    }
}
- (void)addAnimation{
    
    self.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.4 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    [self.layer addSublayer:self.contentLayer];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choseItemAction:)];
    [self addGestureRecognizer:tap];
    
    [self tl_layoutContent];
    [self addAnimation];
}
- (void)reloadData{
    self.layer.contents = nil;
    [self tl_layoutContent];
    [self addAnimation];
//    [self layoutSubviews];
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
    
    
    CGFloat titleWidth0 = [self.horWidthProArr[0] floatValue];
    CGFloat titleHeight0 = [self.verHeightProArr[0] floatValue];
    
    [_horLine0bgColor setFill];
    // 画横向标题的背景
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.frame), 0);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.frame), titleHeight0);
    CGContextAddLineToPoint(context, 0, titleHeight0);
    CGContextFillPath(context);
    
    [_verLine0bgColor setFill];
    // 画竖向标题的背景
    CGContextMoveToPoint(context, 0, titleHeight0);
    CGContextAddLineToPoint(context, titleWidth0, titleHeight0);
    CGContextAddLineToPoint(context, titleWidth0, CGRectGetHeight(self.frame));
    CGContextAddLineToPoint(context, 0, CGRectGetHeight(self.frame));
    CGContextFillPath(context);
    

    [_lineColor setStroke];///
    // 画最外面的四边形
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.frame) -_lineWidth/2, 0);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.frame) -_lineWidth/2, CGRectGetHeight(self.frame) -_lineWidth/2);
    CGContextAddLineToPoint(context, 0, CGRectGetHeight(self.frame) -_lineWidth/2);
    CGContextAddLineToPoint(context, 0, 0);
    CGContextStrokePath(context);

    CGFloat verAllHeight = 0;
    // 画横线
    for (int i = 1; i < self.verHeightProArr.count; i ++) {
        
        verAllHeight = verAllHeight +[self.verHeightProArr[i -1] floatValue];
        CGContextSetLineWidth(context, _lineWidth);
        CGContextMoveToPoint(context, 0, verAllHeight);
        CGContextAddLineToPoint(context, CGRectGetWidth(self.frame), verAllHeight);
        CGContextStrokePath(context);
    }
    
    // 画竖线
    CGFloat horAllWidth = 0;
    for (int i = 1; i < self.horWidthProArr.count; i ++) {
        
        horAllWidth = horAllWidth +[self.horWidthProArr[i -1] floatValue];
        CGContextSetLineWidth(context, _lineWidth);
        CGContextMoveToPoint(context, horAllWidth, 0);
        CGContextAddLineToPoint(context, horAllWidth, CGRectGetHeight(self.frame));
        CGContextStrokePath(context);
    }
    
    // 画内容

    CGFloat pointY = 0;
    for (int i = 0; i < self.verHeightProArr.count; i++) {
        
        CGFloat titleHeight = [self.verHeightProArr[i] floatValue];
        NSArray *horTitleArr = self.dataArr[i];
        
        CGFloat pointX = 0;
        for (int j = 0; j < self.horWidthProArr.count; j++) {
            
            CGFloat titleWidth = [self.horWidthProArr[j] floatValue];
            NSString *title = horTitleArr[j];
            
            NSArray *firArr = [title componentsSeparatedByString:@"|"];
            
            if (2 == firArr.count) {
                // 画斜线
                CGContextMoveToPoint(context, pointX, pointY);
                CGContextAddLineToPoint(context, titleWidth, titleHeight);
                CGContextStrokePath(context);
                
                CGFloat pointY0 = (titleHeight/2 -_horLine0Font)/2;
                CGFloat pointY1 = titleHeight/2 +(titleHeight/2 -_horLine0Font)/2;
                
                [firArr[0] drawInRect:CGRectMake(titleWidth/2 ,pointY0, titleWidth/2, titleHeight/2) withAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:_horLine0Font ],NSForegroundColorAttributeName:_horLine0TextColor,NSParagraphStyleAttributeName:paragraphStyle}];
                
                [firArr[1] drawInRect:CGRectMake(pointX, pointY1, titleWidth/2, titleHeight/2) withAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:_horLine0Font ],NSForegroundColorAttributeName:_horLine0TextColor,NSParagraphStyleAttributeName:paragraphStyle}];
                

            }else{
                
                NSDictionary *attributes;
                if (0 == i) {
                    
                    attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:_horLine0Font],NSForegroundColorAttributeName:_horLine0TextColor,NSParagraphStyleAttributeName:paragraphStyle};

                    
                }else if (0 == j){
                    
                    attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:_verLine0Font],NSForegroundColorAttributeName:_verLine0TextColor,NSParagraphStyleAttributeName:paragraphStyle};
                    
                }else{
                    
                    attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:_defaultFont],NSForegroundColorAttributeName:_defaultTextColor,NSParagraphStyleAttributeName:paragraphStyle};
                }
                CGSize strSize = [title sizeWithAttributes:attributes];
                CGFloat newPointY = pointY +(titleHeight -strSize.height)/2;
                [title drawInRect:CGRectMake(pointX, newPointY, titleWidth, strSize.height) withAttributes:attributes];
                
            }
            pointX = pointX +[self.horWidthProArr[j] floatValue];
        }
        pointY = pointY +[self.verHeightProArr[i] floatValue];
    }
    
    UIImage * currentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.contentLayer.contents = (__bridge id _Nullable)(currentImage.CGImage);

    
    
}

@end
