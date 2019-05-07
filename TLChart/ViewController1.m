//
//  ViewController1.m
//  TLChart
//
//  Created by hello on 2019/5/7.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "ViewController1.h"
#import "TLChartRateView.h"
#import "TLChartRateView1.h"
#import "TLChartTableView.h"
#import "TLChartSingleHistogramView.h"
#import "TLChartDoubleHistogramView.h"

@interface ViewController1 ()

@property (nonatomic ,strong)UILabel                    *lab;
@property (nonatomic ,strong)TLChartRateView            *rateView;
@property (nonatomic ,strong)TLChartRateView1           *rateView1;
@property (nonatomic ,strong)TLChartTableView           *tableView;
@property (nonatomic ,strong)TLChartSingleHistogramView *singleHistogramView;
@property (nonatomic ,strong)TLChartDoubleHistogramView *doubleHistogramView;

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    [self createBtn];
    
}
- (void)createBtn{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(50, 50 +NavBarHeight, 100, 40);
    [btn setTitle:@"刷新数据" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.lab = [UILabel new];
    self.lab.frame = CGRectMake(0, TLDeviceHeight -200, TLDeviceWidth, 50);
    self.lab.textAlignment = 1;
    [self.view addSubview:self.lab];
}
- (void)click:(UIButton *)btn{
    
    if ([@"饼图/速率图0" isEqualToString:self.title]) {
        
        self.rateView.arcData = @"0.7";
        [self.rateView reloadData];
        
        
    }else if ([@"饼图/速率图1" isEqualToString:self.title]){
        
        self.rateView1.arcData = 0.9;
        [self.rateView1 reloadData];
        
    }else if ([@"表图" isEqualToString:self.title]){
        
        NSArray *arr0 = @[@"宠物|姓名",@"狗",@"🐈",@"老鼠",@"🦁"];
        NSArray *arr1 = @[@"张三",@"10",@"0",@"1",@"20"];
        NSArray *arr2 = @[@"李四",@"0",@"60",@"60",@"20"];
        NSArray *arr3 = @[@"王老五",@"7",@"30",@"5",@"15"];
        NSArray *dataArr = @[arr0,arr1,arr2,arr3];
        
        self.tableView.dataArr = dataArr;
        [self.tableView reloadData];
        
    }else if ([@"单柱状图" isEqualToString:self.title]){
        
        self.singleHistogramView.verTitleArr = @[@"战争机器",@"钢铁侠",@"蜘蛛侠"];
        self.singleHistogramView.horTitleArr = @[@"0",@"50",@"100",@"150"];
        self.singleHistogramView.dataArr = @[@(0.2),@(0.8),@(0.5)];
        self.singleHistogramView.dataTitleArr = @[@"😃",@"😜",@"😭"];
        [self.singleHistogramView reloadData];
        
    }else if ([@"双柱状图" isEqualToString:self.title]){
        
        self.doubleHistogramView.data0Arr = @[@(53/80.0),@(44/80.0),@(77/80.0)];
        self.doubleHistogramView.data1Arr = @[@(66/80.0),@(48/80.0),@(74/80.0)];
        self.doubleHistogramView.dataTitle0Arr = @[@"上月53",@"上月44",@"上月77"];
        self.doubleHistogramView.dataTitle1Arr = @[@"本月66",@"本月48",@"本月74"];
        [self.doubleHistogramView reloadData];
        
    }
    
}
- (void)initUI{
    
    if ([@"饼图/速率图0" isEqualToString:self.title]) {
        
        [self initTLChartRateView0];
        
    }else if ([@"饼图/速率图1" isEqualToString:self.title]){
        
        [self initTLChartRateView1];
        
    }else if ([@"表图" isEqualToString:self.title]){
        
        [self initTLChartTableView];
        
    }else if ([@"单柱状图" isEqualToString:self.title]){
        
        [self initTLChartSingleHistogramView];
        
    }else if ([@"双柱状图" isEqualToString:self.title]){
        
        [self initTLChartDoubleHistogramView];
    }
    
}
- (void)initTLChartRateView0{
    
    self.rateView = [TLChartRateView new];
    self.rateView.frame = CGRectMake((TLDeviceWidth -RateViewWidth)/2, 150 +NavBarHeight, RateViewWidth, RateViewHeight);
    [self.view addSubview:self.rateView];
    
}
- (void)initTLChartRateView1{
    
    self.rateView1 = [TLChartRateView1 new];
    self.rateView1.frame = CGRectMake((TLDeviceWidth -RateViewWidth)/2, 150 +NavBarHeight, RateViewWidth, RateViewHeight);
    [self.view addSubview:self.rateView1];
    
}
- (void)initTLChartTableView{
    
    NSArray *arr0 = @[@"学科|姓名",@"数学",@"语文",@"英语",@"物理"];
    NSArray *arr1 = @[@"张三",@"100",@"50",@"",@"70"];
    NSArray *arr2 = @[@"李四",@"",@"60",@"100",@"0"];
    NSArray *arr3 = @[@"王老五",@"7",@"0",@"",@"70"];
    NSArray *dataArr = @[arr0,arr1,arr2,arr3];
    
    self.tableView = [TLChartTableView new];
    self.tableView.frame = CGRectMake(10, 150 +NavBarHeight, 400, 300);
    self.tableView.dataArr = dataArr;
    self.tableView.horWidthProArr = @[@(80),@(80),@(70),@(90),@(80)];
    self.tableView.verHeightProArr = @[@(90),@(70),@(80),@(60)];
    [self.view addSubview:self.tableView];
    
    WS(weakSelf);
    self.tableView.clickBlock = ^(NSInteger indexX, NSInteger indexY) {
        SS(strongSelf);
        
        NSLog(@"%ld------%ld",(long)indexX,(long)indexY);
        strongSelf.lab.text = [NSString stringWithFormat:@"点击了：(X:%ld-----Y:%ld)",(long)indexX,(long)indexY];
    };
}
- (void)initTLChartSingleHistogramView{
    
    
    UIColor *color0 = [UIColor colorWithRed:121.0 / 255.0 green:134.0 / 255.0 blue:142.0 / 255.0 alpha:1.0f];
    UIColor *color1 = [UIColor colorWithRed:88.0 / 255.0 green:75.0 / 255.0 blue:103.0 / 255.0 alpha:1.0f];
    UIColor *color2 = [UIColor colorWithRed:82.0 / 255.0 green:116.0 / 255.0 blue:188.0 / 255.0 alpha:1.0f];
    
    self.singleHistogramView = [TLChartSingleHistogramView new];
    self.singleHistogramView.frame = CGRectMake(20, 150 +NavBarHeight, 350, 300);
    self.singleHistogramView.verTitleArr = @[@"张三",@"李四",@"王老五"];
    self.singleHistogramView.horTitleArr = @[@"50",@"100",@"150",@"200"];
    self.singleHistogramView.dataArr = @[@(0.7),@(0.2),@(1)];
    self.singleHistogramView.dataTitleArr = @[@"数据0",@"数据1",@"数据2"];
    self.singleHistogramView.dataColorArr = @[color0,color1,color2];
    [self.view addSubview:self.singleHistogramView];
    
    WS(weakSelf);
    self.singleHistogramView.clickBlock = ^(NSInteger index) {
        SS(strongSelf);
        
        NSLog(@"----%ld",(long)index);
        strongSelf.lab.text = [NSString stringWithFormat:@"点击了：----%ld",(long)index];
    };
}
- (void)initTLChartDoubleHistogramView{
    
    UIColor *color0 = [UIColor colorWithRed:88.0 / 255.0 green:75.0 / 255.0 blue:103.0 / 255.0 alpha:1.0f];
    UIColor *color1 = [UIColor colorWithRed:121.0 / 255.0 green:134.0 / 255.0 blue:142.0 / 255.0 alpha:1.0f];
    
    
    self.doubleHistogramView = [TLChartDoubleHistogramView new];
    self.doubleHistogramView.frame = CGRectMake(20, 150 +NavBarHeight, 350, 300);
    self.doubleHistogramView.verTitleArr = @[@"进货量",@"销售量",@"囤货量"];
    self.doubleHistogramView.horTitleArr = @[@"0",@"20",@"40",@"60",@"80"];
    self.doubleHistogramView.data0Arr = @[@(76/80.0),@(74/80.0),@(50/80.0)];
    self.doubleHistogramView.data1Arr = @[@(72/80.0),@(73/80.0),@(45/80.0)];
    self.doubleHistogramView.dataTitle0Arr = @[@"上月76",@"上月74",@"上月50"];
    self.doubleHistogramView.dataTitle1Arr = @[@"本月72",@"本月73",@"本月45"];
    self.doubleHistogramView.dataColor0Arr = @[color0,color0,color0];
    self.doubleHistogramView.dataColor1Arr = @[color1,color1,color1];
    [self.view addSubview:self.doubleHistogramView];
    
    WS(weakSelf);
    self.doubleHistogramView.clickBlock = ^(NSInteger secIndex, NSInteger rowIndex) {
        SS(strongSelf);
        
        NSLog(@"%ld------%ld",(long)secIndex,(long)rowIndex);
        strongSelf.lab.text = [NSString stringWithFormat:@"点击了：(数据源:%ld---row:%ld)",(long)secIndex,(long)rowIndex];
    };
    
}


@end
