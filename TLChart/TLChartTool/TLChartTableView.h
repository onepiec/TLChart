//
//  TLChartTableView.h
//  ChartTableView
//
//  Created by hello on 2019/4/1.
//  Copyright © 2019 tanglei. All rights reserved.
//

#define P_M(x,y) CGPointMake(x, y)

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLChartTableView : UIView

@property (nonatomic, strong) UIColor      *lineColor;//line的颜色
@property (nonatomic, assign) CGFloat       lineWidth;//line的粗细
@property (nonatomic, strong) NSArray       *dataArr;//数据

@property (nonatomic, strong) UIColor      *horLine0bgColor;//第一行的背景色
@property (nonatomic, assign) CGFloat       horLine0Font;//第一行的字号
@property (nonatomic, strong) UIColor      *horLine0TextColor;//第一行的字色
@property (nonatomic, strong) NSArray      *horWidthProArr;//行宽的比重

@property (nonatomic, strong) UIColor      *verLine0bgColor;//第一列的背景色
@property (nonatomic, assign) CGFloat       verLine0Font;//第一列的字号
@property (nonatomic, strong) UIColor      *verLine0TextColor;//第一列的字色
@property (nonatomic, strong) NSArray      *verHeightProArr;//列长的比重

@property (nonatomic, assign) CGFloat       defaultFont;//非第一行、第一列的字号
@property (nonatomic, strong) UIColor      *defaultTextColor;//非第一行、第一列的字色

@property (nonatomic,copy) void(^ clickBlock)(NSInteger indexX ,NSInteger indexY);
- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
