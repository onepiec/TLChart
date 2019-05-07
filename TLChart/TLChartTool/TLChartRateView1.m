//
//  TLChartRateView1.m
//  test
//
//  Created by hello on 2019/5/6.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "TLChartRateView1.h"

@interface TLChartRateView1()

@property (nonatomic,weak) CALayer              *contentLayer;
@property (nonatomic,weak) CAShapeLayer         *needleLayer;
@property (nonatomic,strong)CABasicAnimation    *needleAnimation;
@property (nonatomic,assign)double               needleAngle;

@property (nonatomic,weak)CAShapeLayer          *animationLayer;              //动画效果mask
@property (nonatomic,strong)CABasicAnimation    *animation;

@end

@implementation TLChartRateView1

- (CABasicAnimation *)needleAnimation{
    if (!_needleAnimation) {
        _needleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        
        _needleAnimation.fromValue = @(-M_PI_2);
        _needleAnimation.fillMode = kCAFillModeForwards;
        _needleAnimation.removedOnCompletion = NO;
        _needleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    }
    if (_needleAnimation) {
        _needleAnimation.duration = durationTime *_arcData;
        _needleAnimation.toValue = @(M_PI_2 +self.needleAngle);

    }
    return _needleAnimation;
}

- (CABasicAnimation *)animation{
    if (!_animation) {
        _animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _animation.duration = durationTime;
        _animation.fromValue = @(0);
        _animation.toValue = @(1);
        _animation.removedOnCompletion = NO;
        _animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];;
    }
    return _animation;
}
- (CAShapeLayer *)animationLayer{
    if (!_animationLayer) {

        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(RateViewWidth/2, RateViewHeight) radius:RateViewWidth/2 startAngle:-M_PI_2 *2 endAngle:0 clockwise:YES];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = [UIColor blackColor].CGColor;
        layer.lineWidth = RateViewWidth;
        _animationLayer = layer;
    }
    return _animationLayer;
}
- (void)addAnimation{

    self.contentLayer.mask = self.animationLayer;
    [self.animationLayer removeAnimationForKey:@"starAnimation"];
    [self.animationLayer addAnimation:self.animation forKey:@"starAnimation"];
    
    [self.needleLayer removeAnimationForKey:@"rotate-layer"];
    [self.needleLayer addAnimation:self.needleAnimation forKey:@"rotate-layer"];
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        _needleRadius       = 5;
        _needleColor        = [UIColor blackColor];
        
        _lineWidth          = 1;
        _lineColor          = [UIColor blackColor];
        
        _title              = @"柱状图";
        _titleFont          = 15;
        _titleColor         = [UIColor redColor];
        
        _arcWidth           = 15;
        _arcData            = 0.3;
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
    [self addAnimation];
    
}
- (void)reloadData{
    
    [self.contentLayer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.contentLayer removeFromSuperlayer];
    self.contentLayer = nil;
    
    [self.needleLayer removeFromSuperlayer];
    self.needleLayer = nil;
}

- (CALayer *)contentLayer{
    if (_contentLayer == nil) {
        
        CALayer *contentLayer = [CALayer layer];
        contentLayer.backgroundColor = [UIColor clearColor].CGColor;
        contentLayer.frame = self.bounds;
        _contentLayer = contentLayer;
        
    }
    return _contentLayer;
}
- (void)tl_layoutContent{
    
    
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;// 这个属性是能够画字符的时候换行
    paragraphStyle.alignment = NSTextAlignmentCenter;

    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:_titleFont],NSForegroundColorAttributeName:_titleColor,NSParagraphStyleAttributeName:paragraphStyle};
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:_title attributes:attributes];
    
    
    CATextLayer *titleLayer = [[CATextLayer alloc] init];
    titleLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 15);
    titleLayer.alignmentMode = kCAAlignmentCenter;
    titleLayer.string = attributedStr;
    titleLayer.contentsScale = [UIScreen mainScreen].scale;
    [_contentLayer addSublayer:titleLayer];
    
    
    CGPoint arcCenter = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame));
    CGFloat arcRadius = CGRectGetWidth(self.frame)/2;
    double angle = -M_PI -(-M_PI *_arcData);
    self.needleAngle = angle;
    
    UIBezierPath *arcPath0 = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                        radius:arcRadius
                                                    startAngle:-M_PI
                                                      endAngle:angle clockwise:YES];
    [arcPath0 addLineToPoint:arcCenter];
    CAShapeLayer *arcLayer0 = [CAShapeLayer layer];
    arcLayer0.path = arcPath0.CGPath;
    arcLayer0.fillColor = _arcColor0.CGColor;
    [_contentLayer addSublayer:arcLayer0];

    UIBezierPath *arcPath1 = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                            radius:arcRadius
                                                        startAngle:angle
                                                          endAngle:0 clockwise:YES];
    [arcPath1 addLineToPoint:arcCenter];
    CAShapeLayer *arcLayer1 = [CAShapeLayer layer];
    arcLayer1.path = arcPath1.CGPath;
    arcLayer1.fillColor = _arcColor1.CGColor;
    [_contentLayer addSublayer:arcLayer1];
    
    // 计算空白半径
    CGFloat whiteRadius = CGRectGetWidth(self.frame)/2 - _arcWidth;
    UIBezierPath *whiteArcPath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                            radius:whiteRadius
                                                        startAngle:-M_PI
                                                          endAngle:0 clockwise:YES];
    [whiteArcPath addLineToPoint:arcCenter];
    CAShapeLayer *whiteArcLayer = [CAShapeLayer layer];
    whiteArcLayer.path = whiteArcPath.CGPath;
    whiteArcLayer.fillColor = [UIColor whiteColor].CGColor;
    [_contentLayer addSublayer:whiteArcLayer];
    
    
    CGRect horLineFrame = CGRectMake(0, CGRectGetHeight(self.frame) -_lineWidth, CGRectGetWidth(self.frame), _lineWidth);
    CAShapeLayer *horLine = [CAShapeLayer layer];
    horLine.frame = horLineFrame;
    horLine.strokeColor = _lineColor.CGColor;
    horLine.fillColor = [UIColor clearColor].CGColor;
    horLine.lineWidth = _lineWidth;//虚线伸出去的宽度
    horLine.lineDashPattern = @[@3,@2];//虚线高度 & 两虚线间隔高度
    
    CGMutablePathRef horPath = CGPathCreateMutable();
    CGPathMoveToPoint(horPath, NULL, 0, 0);
    CGPathAddLineToPoint(horPath, NULL, CGRectGetWidth(self.frame),0);
    horLine.path = horPath;
    [_contentLayer addSublayer:horLine];
    
    
    CGRect verLineFrame = CGRectMake((CGRectGetWidth(self.frame) -_lineWidth)/2, CGRectGetHeight(self.frame) -CGRectGetWidth(self.frame)/2, _lineWidth, CGRectGetWidth(self.frame)/2);
    CAShapeLayer *verLine = [CAShapeLayer layer];
    verLine.frame = verLineFrame;
    verLine.strokeColor = _lineColor.CGColor;
    verLine.fillColor = [UIColor clearColor].CGColor;
    verLine.lineWidth = _lineWidth;//虚线伸出去的宽度
    verLine.lineDashPattern = @[@3,@2];//虚线高度 & 两虚线间隔高度
    
    CGMutablePathRef verPath = CGPathCreateMutable();
    CGPathMoveToPoint(verPath, NULL, 0, 0);
    CGPathAddLineToPoint(verPath, NULL, 0,CGRectGetWidth(self.frame)/2);
    verLine.path = verPath;
    [_contentLayer addSublayer:verLine];
    
    //content文字
    for (int i =0; i <_defaultTextArr.count; i ++) {
        
        CATextLayer *contentLayer = [[CATextLayer alloc] init];
        if (0 == i) {
            contentLayer.frame = CGRectMake(_arcWidth +5, CGRectGetHeight(self.frame) -(_defaultTextFont +2), CGRectGetWidth(self.frame)/2 -(_arcWidth +5), _defaultTextFont);
            contentLayer.alignmentMode = kCAAlignmentLeft;
        }else{
            contentLayer.frame = CGRectMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame) -(_defaultTextFont +2), CGRectGetWidth(self.frame)/2 -(_arcWidth +5), _defaultTextFont);
            contentLayer.alignmentMode = kCAAlignmentRight;
        }

        contentLayer.string = _defaultTextArr[i];
        contentLayer.fontSize = _defaultTextFont;
        contentLayer.foregroundColor = _defaultTextColor.CGColor;
        contentLayer.contentsScale = [UIScreen mainScreen].scale;
        [_contentLayer addSublayer:contentLayer];
        
    }
    
    
    CGRect needleRect = CGRectMake(RateViewWidth/2 -_needleRadius, RateViewHeight -RateViewWidth/2, _needleRadius *2, RateViewWidth/2);
    double newAngle = -M_PI_2;
    //针尾左边弧度
    double needleAngle0 = newAngle -M_PI_2;
    //针尾右边弧度
    double needleAngle1 = newAngle +M_PI_2;

    //圆心坐标
    CGPoint needleCenter = CGPointMake(CGRectGetWidth(needleRect)/2, CGRectGetHeight(needleRect));//-_needleRadius

    //针头point
    CGPoint needlePoint = CGPointMake(_needleRadius, 0);
    UIBezierPath *needlePath = [UIBezierPath bezierPathWithArcCenter:needleCenter
                                                            radius:_needleRadius
                                                        startAngle:needleAngle0
                                                          endAngle:needleAngle1 clockwise:NO];
    [needlePath addLineToPoint:needlePoint];
    CAShapeLayer *needleLayer = [CAShapeLayer layer];
    needleLayer.frame = needleRect;
    needleLayer.path = needlePath.CGPath;
    needleLayer.fillColor = _needleColor.CGColor;
    needleLayer.position = CGPointMake(needleLayer.position.x, needleLayer.position.y +CGRectGetHeight(needleRect)/2);// -_needleRadius
    needleLayer.anchorPoint = CGPointMake(0.5, 0.5 +(CGRectGetHeight(needleRect)/2)/(RateViewWidth/2));//-_needleRadius

    [self.layer addSublayer:needleLayer];
    _needleLayer = needleLayer;

}

@end
