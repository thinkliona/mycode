//
//  HGChoiceController.m
//  HiGo
//
//  Created by Think_lion on 15/7/25.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGChoiceController.h"
#import "HGChoiceCell.h"
#import "HGScroll.h"
#import "HGCategoryModel.h"
#import "HGCategoryList.h"
#import "HGGoodsModel.h"
#import "HGGoodsMainImageModel.h"
#import "HGGoodsInfoModel.h"
#import "HGGoodsImageModel.h"
#import "HGGoodsFrame.h"
#import "HGHttpTool.h"

#define HGChoiceName @"HGChoiceCell"


@interface HGChoiceController ()<UITableViewDataSource,UITableViewDelegate,HGScrollDelegate,HGCategoryListDelegate,MJRefreshBaseViewDelegate>

@property (nonatomic,weak) HGScroll *scroll;
@property (nonatomic,weak) HGCategoryList *cateList;

@property (nonatomic,weak) UITableView *tableView;


@property (nonatomic,strong) MJRefreshHeaderView *header;
@property (nonatomic,strong) MJRefreshFooterView *footer;
//存放frame模型的数组
@property (nonatomic,strong) NSMutableArray *arrFrames;

@end

@implementation HGChoiceController

-(NSMutableArray *)arrFrames
{
    if(!_arrFrames){
        _arrFrames=[NSMutableArray array];
    }
    return _arrFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  // NSString *url=@"http://v.higo.meilishuo.com/goods/goods_discover";
    //1.添加tableView
    [self setupTableView];
    //2.添加头视图
    [self setupHeaderView];
    //3.自动刷新
    [self setupRefresh];
 
}


//刷新控件
-(void)setupRefresh
{
    //1.刷新控件
    MJRefreshHeaderView *header=[MJRefreshHeaderView header];
    header.scrollView=self.tableView;
    header.delegate=self;
    //开始自动加载数据
    [header beginRefreshing];
    self.header=header;
    
    
    //2.上拉刷新
    MJRefreshFooterView *footer=[MJRefreshFooterView footer];
    footer.delegate=self;
    footer.scrollView=self.tableView;
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
        NSMutableArray *arrayFrames=[NSMutableArray array];
        
        //1.获得分类的数据
        NSArray *categoryList= json[@"data"][@"category_list"];
        NSArray *cateModels= [HGCategoryModel objectArrayWithKeyValuesArray:categoryList];
        self.cateList.data=cateModels;
        //2.获得商品展示的数据  goods_list
        NSArray *tempGoods = json[@"data"][@"goods_list"];
        NSArray *goodsArr=[HGGoodsModel objectArrayWithKeyValuesArray:tempGoods];
        //遍历商品模型
      
        for(HGGoodsModel *goodsModel in goodsArr) {
            HGGoodsFrame *goodsFrame=[[HGGoodsFrame alloc]init];
            
            goodsFrame.goodsModel=goodsModel;  //传递模型
            
            //把frame模型添加到数组
            [arrayFrames addObject:goodsFrame];
           
        }
        
        //把新获得的数组放在前面
        NSMutableArray *tempArray=[NSMutableArray array];
        [tempArray addObjectsFromArray:arrayFrames]; //添加新的数组
        [tempArray addObjectsFromArray:self.arrFrames];
        
        
        self.arrFrames=tempArray; //在真个传递给主数组
        
        
        //刷新表示图
        [self.tableView reloadData];
        //停止刷新
        [self.header endRefreshing];

    } failture:^(id error) {
         [self.header endRefreshing];
    }];
    
}

#pragma mark 上啦刷新
-(void)loadMoreData
{
    [HGHttpTool getWirhUrl:HGURL parms:nil success:^(id json) {
        
        NSMutableArray *lastArrFrames=[NSMutableArray array];
        //2.获得商品展示的数据  goods_list
        NSArray *tempGoods = json[@"data"][@"goods_list"];
        NSArray *goodsArr=[HGGoodsModel objectArrayWithKeyValuesArray:tempGoods];
        //遍历商品模型
        
        for(HGGoodsModel *goodsModel in goodsArr) {
            HGGoodsFrame *goodsFrame=[[HGGoodsFrame alloc]init];
            goodsFrame.goodsModel=goodsModel;  //传递模型
            
            //把frame模型添加到数组
            [lastArrFrames addObject:goodsFrame];
            
        }
      
        //把获取的就得数据放在这个数组的后面
        [self.arrFrames addObjectsFromArray:lastArrFrames];
        
        //刷新标示图
        [self.tableView reloadData];
        [self.footer endRefreshing];
        
    } failture:^(id error) {
        
    }];
}

#pragma mark 添加setupCollection
-(void)setupTableView
{
    UITableView *tableView=[[UITableView alloc]init];
    
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.frame=self.view.bounds;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.contentInset=UIEdgeInsetsMake(0, 0, 40, 0);
    [self.view addSubview:tableView];
    self.tableView=tableView;
    
}

#pragma mark 添加头视图
-(void)setupHeaderView
{
    //1.添加无限滚动
    CGFloat scrollH=250;
    HGScroll *scroll=[[HGScroll alloc]initWithFrame:CGRectMake(0, 0, self.view.width, scrollH)];
    scroll.delegate=self;
    //2.添加左右滚动
    CGFloat cateListH=100;
    HGCategoryList *cateList=[[HGCategoryList alloc]initWithFrame:CGRectMake(0, scrollH, self.view.width, cateListH)];
    cateList.delegate=self;
    
    UIView *tempV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, (cateListH+scrollH))];
    [tempV addSubview:scroll];
    [tempV addSubview:cateList];
   
    self.tableView.tableHeaderView=tempV;
    self.scroll=scroll;
    self.cateList=cateList;

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrFrames.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HGChoiceCell *cell=[HGChoiceCell cellWithTableView:tableView indentifier:HGChoiceName];
    HGGoodsFrame *goodsFrame=self.arrFrames[indexPath.row];
    cell.goodsFrame=goodsFrame;
   
    return cell;
}

#pragma mark 返回单元格的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HGGoodsFrame *goodsFrame=self.arrFrames[indexPath.row];
    
   
    return goodsFrame.cellH;
}

#pragma mark 添加点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //HGGoodsFrame *goodsFrame=self.arrFrames[indexPath.row];
    UIViewController *vc=[[UIViewController alloc]init];
    vc.view.backgroundColor=[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark 滚动图片点击的方法

-(void)scrollClick:(HGScroll *)click clickIndex:(NSInteger)clickIndex
{
    UIViewController *vc=[[UIViewController alloc]init];
    vc.view.backgroundColor=[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 商品横向列表的点击方法

-(void)categoaryList:(HGCategoryList *)categoaryList clickIndex:(NSInteger)clickIndex
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
