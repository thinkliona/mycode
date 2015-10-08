//
//  HGSpecialController.m
//  HiGo
//
//  Created by Think_lion on 15/7/25.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGSpecialController.h"
#import "HGSpecialCell.h"
#import "HGHttpTool.h"
#import "HGSpecialModel.h"
#import "HGSpecialMainImageModel.h"

#define HGSpecialName  @"HGSpecialName"

@interface HGSpecialController ()<UICollectionViewDataSource,UICollectionViewDelegate,MJRefreshBaseViewDelegate>
@property (nonatomic,weak) UICollectionView *specialCollection;
@property (nonatomic,strong) NSMutableArray *specialArr;

@property (nonatomic,strong) MJRefreshHeaderView *header;
@property (nonatomic,strong) MJRefreshFooterView *footer;

@end

@implementation HGSpecialController

-(NSMutableArray *)specialArr
{
    if(_specialArr==nil) {
        _specialArr=[NSMutableArray array];
    }
    return _specialArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.添加姿势图
    [self setupFirst];
    //2.发送网络请求
    [self setupRefresh];
}

-(void)setupRefresh
{
    //1.刷新控件
    MJRefreshHeaderView *header=[MJRefreshHeaderView header];
    header.scrollView=self.specialCollection;
    header.delegate=self;
    //开始自动加载数据
    [header beginRefreshing];
    self.header=header;
    
    
    //2.上拉刷新
    MJRefreshFooterView *footer=[MJRefreshFooterView footer];
    footer.delegate=self;
    footer.scrollView=self.specialCollection;
    self.footer=footer;
}
#pragma mark 代理上啦刷新
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    //如果是下拉菜单
    if([refreshView isKindOfClass:[MJRefreshHeaderView class]]){
        
        [self sendRequest];
        
    }else{
        
        [self loadMoreData];  //上拉刷新
    }
    
}

#pragma mark 发送网络请求
-(void)sendRequest
{
    [HGHttpTool getWirhUrl:HGURL parms:nil success:^(id json) {
        
        NSMutableArray *arrays=[NSMutableArray array];
        
        NSArray *tempGoods = json[@"data"][@"goods_list"];
        NSArray *goodsArr=[HGSpecialModel objectArrayWithKeyValuesArray:tempGoods];
        NSArray *goodsArr2=[goodsArr mutableCopy];
        [arrays  addObjectsFromArray:goodsArr];
        [arrays addObjectsFromArray:goodsArr2];
        [arrays addObjectsFromArray:self.specialArr];
        
        self.specialArr=arrays;
        
        [self.specialCollection reloadData];
        [self.header endRefreshing];
        
    } failture:^(id error) {
        [self.header endRefreshing];
    }];
}


#pragma mark 上啦刷新
-(void)loadMoreData
{
    [HGHttpTool getWirhUrl:HGURL parms:nil success:^(id json) {
        
        NSMutableArray *arrays=[NSMutableArray array];
        
        NSArray *tempGoods = json[@"data"][@"goods_list"];
        NSArray *goodsArr=[HGSpecialModel objectArrayWithKeyValuesArray:tempGoods];
        NSArray *goodsArr2=[goodsArr mutableCopy];
        [arrays  addObjectsFromArray:goodsArr];
        [arrays addObjectsFromArray:goodsArr2];
        [arrays addObjectsFromArray:self.specialArr];
        
        [self.specialArr addObjectsFromArray:arrays];
        
        [self.specialCollection reloadData];
        [self.footer endRefreshing];
        
    } failture:^(id error) {
        [self.footer endRefreshing];
    }];

}

-(void)setupFirst
{
    //
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing=20;
    layout.itemSize=CGSizeMake(self.view.width, 250);
    layout.sectionInset=UIEdgeInsetsMake(0, 0, 50, 0);
    
    UICollectionView *specialCollection=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [specialCollection registerClass:[HGSpecialCell class] forCellWithReuseIdentifier:HGSpecialName];
    
    
    specialCollection.backgroundColor=HGColor(237, 237, 237);
    specialCollection.delegate=self;
    specialCollection.dataSource=self;
    [self.view addSubview:specialCollection];
    self.specialCollection=specialCollection;
    
}

#pragma mark
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // NSLog(@"%;",self.findFrames.count);
    return self.specialArr.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HGSpecialCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:HGSpecialName forIndexPath:indexPath];
   
    HGSpecialModel *specialModel=self.specialArr[indexPath.item];
    cell.specialModel=specialModel;
    
   
    
    return cell;
}

#pragma mark 单元格点击的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc=[[UIViewController alloc]init];
    vc.view.backgroundColor=[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)dealloc
{
    [_footer free];
    [_header free];
}


@end
