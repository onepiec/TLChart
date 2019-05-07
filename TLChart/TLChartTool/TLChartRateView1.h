//
//  TLChartRateView1.h
//  test
//
//  Created by hello on 2019/5/6.
//  Copyright © 2019 tanglei. All rights reserved.
//
#define RateViewWidth 300
#define RateViewHeight RateViewWidth/2 +15 *2
#define durationTime 1

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLChartRateView1 : UIView

@property (nonatomic, assign) CGFloat        needleRadius;//针头的半径
@property (nonatomic, strong) UIColor       *needleColor;//针的颜色

@property (nonatomic, assign) CGFloat        lineWidth;//底部虚线宽度
@property (nonatomic, strong) UIColor       *lineColor;//底部虚线颜色

@property (nonatomic, copy  ) NSString      *title;//title数据
@property (nonatomic, assign) CGFloat        titleFont;//title字号
@property (nonatomic, strong) UIColor       *titleColor;//title字色

@property (nonatomic, assign) CGFloat        arcWidth;//环形宽度
@property (nonatomic, assign) CGFloat        arcData;//环形比例数据
@property (nonatomic, strong) UIColor       *arcColor0;//环形色
@property (nonatomic, strong) UIColor       *arcColor1;//环形默认色

@property (nonatomic, strong) NSArray       *defaultTextArr;//环形里面数据
@property (nonatomic, assign) CGFloat        defaultTextFont;//环形里面字号
@property (nonatomic, strong) UIColor       *defaultTextColor;//环形里面字色

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
