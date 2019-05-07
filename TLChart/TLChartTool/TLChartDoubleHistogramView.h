//
//  TLChartDoubleHistogramView.h
//  ChartTableView
//
//  Created by hello on 2019/4/1.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLChartDoubleHistogramView : UIView

@property (nonatomic, assign) CGFloat        corner;//柱状图圆角
@property (nonatomic, assign) CGFloat        verTitleWidth;//左边title宽度
@property (nonatomic, assign) CGFloat        horTitleHeight;//下边title高度

@property (nonatomic, strong) NSArray       *verTitleArr;//左边title数据
@property (nonatomic, strong) NSArray       *horTitleArr;//下边title数据

@property (nonatomic, strong) NSArray       *data0Arr;//柱状图0设定宽度的数据-可以转化floatValue
@property (nonatomic, strong) NSArray       *data1Arr;//柱状图1设定宽度的数据-可以转化floatValue

@property (nonatomic, strong) NSArray       *dataTitle0Arr;//柱状图0上面显示的数据
@property (nonatomic, strong) NSArray       *dataColor0Arr;//柱状图0的颜色

@property (nonatomic, strong) NSArray       *dataTitle1Arr;//柱状图1上面显示的数据
@property (nonatomic, strong) NSArray       *dataColor1Arr;//柱状图1的颜色

@property (nonatomic, strong) UIColor       *titleColor;//title颜色
@property (nonatomic, strong) UIColor       *contentColor;//柱状图内容颜色

@property (nonatomic, assign) CGFloat        verTitleFont;//左边title字号
@property (nonatomic, assign) CGFloat        horTitleFont;//下边title字号
@property (nonatomic, assign) CGFloat        contentFont;//柱状图内容字号

@property (nonatomic, strong) UIColor       *lineColor;//line的颜色
@property (nonatomic, assign) CGFloat        lineWidth;//line的粗细
@property (nonatomic, assign) CGFloat        extLineWidth;//突出line的长短


@property (nonatomic,copy) void(^ clickBlock)(NSInteger secIndex ,NSInteger rowIndex);
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
