//
//  TLChartSingleHistogramView.h
//  ChartTableView
//
//  Created by hello on 2019/4/1.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLChartSingleHistogramView : UIView

@property (nonatomic, assign) CGFloat        corner;//柱状图圆角
@property (nonatomic, assign) CGFloat        verTitleWidth;//左边title宽度
@property (nonatomic, assign) CGFloat        horTitleHeight;//下边title高度

@property (nonatomic, strong) NSArray       *verTitleArr;//左边title数据
@property (nonatomic, strong) NSArray       *horTitleArr;//下边title数据
@property (nonatomic, strong) NSArray       *dataArr;//柱状图设定宽度的数据-可以转化floatValue
@property (nonatomic, strong) NSArray       *dataTitleArr;//柱状图上面显示的数据
@property (nonatomic, strong) NSArray       *dataColorArr;//柱状图的颜色

@property (nonatomic, strong) UIColor       *titleColor;//title颜色
@property (nonatomic, strong) UIColor       *contentColor;//柱状图内容颜色

@property (nonatomic, assign) CGFloat        verTitleFont;//左边title字号
@property (nonatomic, assign) CGFloat        horTitleFont;//下边title字号
@property (nonatomic, assign) CGFloat        contentFont;//柱状图内容字号

@property (nonatomic, strong) UIColor       *lineColor;//line的颜色
@property (nonatomic, assign) CGFloat        lineWidth;//line的粗细
@property (nonatomic, assign) CGFloat        extLineWidth;//突出line的长短

@property (nonatomic,copy) void(^ clickBlock)(NSInteger index);
- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
