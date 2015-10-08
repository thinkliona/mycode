//
//  HGTabbarController.m
//  HiGo
//
//  Created by Think_lion on 15/7/25.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGTabbarController.h"
#import "HGHomeController.h"
#import "HGGlobalController.h"
#import "HGMesageController.h"
#import "HGCarController.h"
#import "HGMeController.h"
#import "HGNavController.h"
#import "HGTabView.h"

@interface HGTabbarController ()<HGTabViewDelegate>
@property (nonatomic,weak) HGTabView *tabView;
@end

@implementation HGTabbarController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for(UIView *zv in self.tabBar.subviews){
        if([zv isKindOfClass:[UIControl class]]){
            [zv removeFromSuperview];
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.添加底部自定义的标签栏
    [self setupTabBar];
    //2.添加子控制器
    [self addChildVc];
   
}

#pragma mark 添加底部的标签栏
-(void)setupTabBar
{
    HGTabView *tabView=[[HGTabView alloc]initWithFrame:self.tabBar.bounds];
    tabView.delegate=self;
    [self.tabBar addSubview:tabView];
    self.tabView=tabView;
    
}
#pragma mark 实现底部标签栏按钮点击的代理方法
-(void)tabView:(HGTabView *)tabView didSelectedFrom:(int)from toIndex:(int)to
{
    self.selectedIndex=to;
}
#pragma mark 添加子控制器
-(void)addChildVc
{
    //1.添加首页控制器
    HGHomeController  *home=[[HGHomeController alloc]init];
    [self addChildViewController:home title:@"首页" image:@"home" selectedImage:@"homeH"];
    //2.全球购
    HGGlobalController *global=[[HGGlobalController alloc]init];
    [self addChildViewController:global title:@"全球购" image:@"earth" selectedImage:@"earthH"];
    //3.消息通知
    HGMesageController *message=[[HGMesageController alloc]init];
    [self addChildViewController:message title:@"购物信息" image:@"Message" selectedImage:@"MessageH"];
    //4.购物车
    HGCarController *car=[[HGCarController alloc]init];
    [self addChildViewController:car title:@"购物车" image:@"cart" selectedImage:@"cartH"];
    //5.我
    HGMeController *me=[[HGMeController alloc]init];
    [self addChildViewController:me title:@"设置" image:@"user" selectedImage:@"userH"];
}

#pragma mark 添加子控制器的方法

-(void)addChildViewController:(UIViewController *)childVc title:(NSString*)title image:(NSString*)image selectedImage:(NSString*)selectedImage
{
    childVc.navigationItem.title=title;
    childVc.tabBarItem.image=[UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage=[UIImage imageNamed:selectedImage];
    
    HGNavController *nav=[[HGNavController alloc]initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
    
    [self.tabView addTabItem:childVc.tabBarItem];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
