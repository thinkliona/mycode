//
//  HGHomeController.m
//  HiGo
//
//  Created by Think_lion on 15/7/25.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGHomeController.h"
#import "HGTitleView.h"
#import "HGSpecialController.h"
#import "HGFindController.h"
#import "HGChoiceController.h"

@interface HGHomeController ()<UIScrollViewDelegate,HGTitleViewDelegate>
@property (nonatomic,strong) NSMutableArray *childViews;
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) HGTitleView *titView;
@end

@implementation HGHomeController


-(NSMutableArray *)childViews
{
    if(!_childViews){
        _childViews=[NSMutableArray array];
    }
    return _childViews;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.添加右边导航栏上面的点击按钮
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithIcon:@"search02" highIcon:nil target:self action:@selector(searchGoods)];
    //2.添加titleView
    [self setupTitleView];
    //3.添加滚动视图
    [self setupScroll];
}
#pragma mark  添加titleview视图
-(void)setupTitleView
{
    HGTitleView *tv=[[HGTitleView alloc]init];
   // tv.backgroundColor=[UIColor redColor];
    tv.delegate=self;
    tv.frame=CGRectMake(0, 0, 200, 30);
    self.navigationItem.titleView=tv;
    self.titView=tv;
}

#pragma mark 添加titleView的代理方法
-(void)titleView:(HGTitleView *)titleView scrollToIndex:(NSInteger)tagIndex
{

    [self.scrollView scrollRectToVisible:CGRectMake(ScreenWidth*tagIndex, 0, self.view.width, self.view.height) animated:YES];
}



#pragma mark 添加滚动视图
-(void)setupScroll
{
    //1.精选控制器
    HGChoiceController *choice=[[HGChoiceController alloc]init];
    [self addChildViewController:choice];
    //2.发现控制器
    HGFindController *find=[[HGFindController alloc]init];
    [self addChildViewController:find];
    //3.专场控制器
    HGSpecialController *special=[[HGSpecialController alloc]init];
    [self addChildViewController:special];
    //这这几个自控制器的view添加到数组中
    [self.childViews addObject:choice.view];
    [self.childViews addObject:find.view];
    [self.childViews addObject:special.view];
    
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.delegate=self;
    [self.view addSubview:scrollView];
    for(int i=0;i<self.childViews.count;i++){

        CGFloat childVX=ScreenWidth*i;
        UIView *childV=self.childViews[i];
        childV.frame=CGRectMake(childVX, 0, ScreenWidth, self.view.height);
        [scrollView addSubview:childV];
    }
    
    //设置滚动的属性
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.pagingEnabled=YES;
    scrollView.contentSize=CGSizeMake(ScreenWidth*3, 0);
    scrollView.bounces=NO;
    self.scrollView=scrollView;
    
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   // NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    if(scrollView.contentOffset.x/ScreenWidth==0){
        [self.titView wanerSelected:0];
    }else if(scrollView.contentOffset.x/ScreenWidth==1){
        [self.titView wanerSelected:1];
    }else if(scrollView.contentOffset.x/ScreenWidth==2){
        [self.titView wanerSelected:2];
    }
}


-(void)searchGoods
{
    NSLog(@"搜索按钮");
}

@end
