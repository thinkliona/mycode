//
//  HGFindController.m
//  HiGo
//
//  Created by Think_lion on 15/7/25.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGFindController.h"
#import "HGFindFrameModel.h"
#import "HGHttpTool.h"
#import "HGCategoryList.h"
#import "HGWaterFlow.h"
#import "HGFindBannerModel.h"
#import "HGFindCell.h"
#import "HGFindModel.h"
#import "HGFindHeadView.h"


#define HGFindCellName @"HGFindCellName"
#define HGFindHeaderName @"HGFindHeaderName"

@interface HGFindController ()<UICollectionViewDataSource,UICollectionViewDelegate,HGWaterFlowDelegate,MJRefreshBaseViewDelegate>

@property (nonatomic,weak) UICollectionView *findCollectionView;
@property (nonatomic,weak) HGCategoryList *cateList;

@property (nonatomic,strong) NSMutableArray *findArr;
@property (nonatomic,strong) NSMutableArray *findFrames;

@property (nonatomic,strong) MJRefreshHeaderView *header;
@property (nonatomic,strong) MJRefreshFooterView *footer;

@end

@implementation HGFindController

-(NSMutableArray *)findArr
{
    if(!_findArr){
        _findArr=[NSMutableArray array];
    }
    return _findArr;
}

-(NSMutableArray *)findFrames
{
    if(_findFrames==nil) {
        _findFrames=[NSMutableArray arrayWithCapacity:100];
    }
    return _findFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.添加集合视图
    [self addFind];
    //2.发送网络请求
    [self setupRefresh];
}

#pragma mark 添加集合视图
-(void)addFind
{
    //创建瀑布流
    HGWaterFlow *waterFlow=[[HGWaterFlow alloc]init];
    waterFlow.delegate=self;
    waterFlow.columsCount=2; //显示2列
    waterFlow.sectionInset=UIEdgeInsetsMake(0, 10, 40, 10);
    
    UICollectionView *findCollection=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:waterFlow];
    [findCollection registerClass:[HGFindCell class] forCellWithReuseIdentifier:HGFindCellName];
   
    
    findCollection.backgroundColor=HGColor(237, 237, 237);
    findCollection.delegate=self;
    findCollection.dataSource=self;
    [self.view addSubview:findCollection];
    self.findCollectionView=findCollection;
    
    
}

//刷新控件
-(void)setupRefresh
{
    //1.刷新控件
    MJRefreshHeaderView *header=[MJRefreshHeaderView header];
    header.scrollView=self.findCollectionView;
    header.delegate=self;
    //开始自动加载数据
    [header beginRefreshing];
    self.header=header;
    
    
    //2.上拉刷新
    MJRefreshFooterView *footer=[MJRefreshFooterView footer];
    footer.delegate=self;
    footer.scrollView=self.findCollectionView;
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
     
        NSMutableArray *bannerFrame=[NSMutableArray array];
        //创建frame模型
        if(self.findFrames.count<1){
            HGFindFrameModel *findFrame=[[HGFindFrameModel alloc]init];
            //2.获得广告栏  banner
            NSDictionary *tempBanner=json[@"data"][@"banner"];
            HGFindBannerModel *bannerModel=[HGFindBannerModel objectWithKeyValues:tempBanner];
            findFrame.bannerModel=bannerModel;
            [bannerFrame addObject:findFrame];
           // NSLog(@"hahah");
        }
      
        NSMutableArray *arrayFrames=[NSMutableArray array];
        //3.获得商品展示的数据  goods_list
        NSArray *tempGoods = json[@"data"][@"goods_list"];
        NSArray *goodsArr=[HGFindModel objectArrayWithKeyValuesArray:tempGoods];
        NSMutableArray *arr=[NSMutableArray array];
        [arr addObjectsFromArray:goodsArr];
        [arr addObjectsFromArray:goodsArr];
        
        for(HGFindModel *findModel in arr) {
            HGFindFrameModel *findFrame=[[HGFindFrameModel alloc]init];
            findFrame.findModel=findModel;
            
            [arrayFrames addObject:findFrame];
        }
        
        //把新获得的数组放在前面
        NSMutableArray *tempArray=[NSMutableArray array];
        [tempArray addObjectsFromArray:arrayFrames]; //添加新的数组
        //[tempArray addObjectsFromArray:self.findFrames];
        //广告始终显示在最前面
        [self.findFrames addObjectsFromArray:bannerFrame];
        [self.findFrames addObjectsFromArray:tempArray];
        
        //重新刷新标示图
        [self.findCollectionView reloadData];
        [self.header endRefreshing];
        
    } failture:^(id error) {
        [self.header endRefreshing];
    }];
}

#pragma mark 上啦刷新
-(void)loadMoreData
{
    
    [HGHttpTool getWirhUrl:HGURL parms:nil success:^(id json) {
        
        NSMutableArray *shopFrames=[NSMutableArray array];
        //1.获得商品展示的数据  goods_list
        NSArray *tempGoods = json[@"data"][@"goods_list"];
        NSArray *goodsArr=[HGFindModel objectArrayWithKeyValuesArray:tempGoods];
        NSMutableArray *arr=[NSMutableArray array];
        [arr addObjectsFromArray:goodsArr];
        [arr addObjectsFromArray:goodsArr];
        
        for(HGFindModel *findModel in arr) {
            HGFindFrameModel *findFrame=[[HGFindFrameModel alloc]init];
            findFrame.findModel=findModel;
            
            
            [shopFrames addObject:findFrame];
        }
        
        [self.findFrames addObjectsFromArray:shopFrames];
        
        //重新刷新标示图
        [self.findCollectionView reloadData];
        [self.header endRefreshing];
        
    } failture:^(id error) {
        [self.header endRefreshing];
    }];

}


#pragma mark
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   // NSLog(@"%zd",self.findFrames.count);
    return self.findFrames.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HGFindCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:HGFindCellName forIndexPath:indexPath];
    
    HGFindFrameModel *findFrame=self.findFrames[indexPath.item];
    cell.findFrame=findFrame;
    
    return cell;
}
#pragma mark 返回瀑布流的高度

-(CGFloat)waterFlow:(HGWaterFlow *)waterFlow heightForWidth:(CGFloat)width indexPath:(NSIndexPath *)indexPath
{
    
   HGFindFrameModel *findFrame=self.findFrames[indexPath.item];
   
    return findFrame.cellH;
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

//#pragma mark 设置footer和header
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if (kind == UICollectionElementKindSectionHeader) {
//        // 去重用队列取可用的header
//        HGFindHeadView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HGFindHeaderName forIndexPath:indexPath];
//        
//        // 返回
//        return reusableView;
//    }
//    return nil;
//}
//
//#pragma mark 设置header和footer高度
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(self.view.width, 200);
//}



@end
