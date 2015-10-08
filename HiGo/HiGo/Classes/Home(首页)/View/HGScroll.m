//
//  HGScroll.m
//  HiGo
//
//  Created by Think_lion on 15/7/26.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGScroll.h"
#import "HGScrollModel.h"
#import "HGScrollCell.h"
#define  MaxCount 100

#define HGScrollName  @"scrollNameCell"

@interface HGScroll ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,weak) UICollectionView *scrollCollection;
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,weak) UIPageControl *page;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation HGScroll



-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        //1.添加collectionView
        [self add];
        //2.添加页控件
        [self setupPage];
        //3.添加定时器
        [self addTimer];
    }
    return self;
}

-(NSMutableArray *)arr
{
    if(!_arr){
        _arr=[NSMutableArray array];
    }
    return _arr;
}
#pragma mark 添加定时器
-(void)addTimer
{
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer=timer;
}
-(NSIndexPath*)resetIndexPath
{
    NSIndexPath *currentIndexPath=[[self.scrollCollection indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPathReset=[NSIndexPath indexPathForItem:currentIndexPath.item inSection:MaxCount/2];
    
    [self.scrollCollection scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentIndexPathReset;
}
#pragma mark 定时器下一页的方法
-(void)nextPage
{
  
        // NSArray *arr= [self.collectionView indexPathsForVisibleItems];
        
        NSIndexPath  *currentIndexPathReset=[self resetIndexPath];
        NSInteger item=currentIndexPathReset.item; //行
        NSInteger sec=currentIndexPathReset.section; //区
        item++;
        if(item==self.arr.count){
            item=0;
            sec++;
        }
        
       // self.page.currentPage=item; //当前页数
        
        NSIndexPath *nextIndexPath=[NSIndexPath indexPathForItem:item inSection:sec];
        
        [self.scrollCollection scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    

}
#pragma mark 添加CollectionView
-(void)add
{
    //1添加模型
    NSArray *plist=[HGScrollModel objectArrayWithFilename:@"newses.plist"];
    [self.arr addObjectsFromArray:plist];
    
    UICollectionViewFlowLayout *flow=[[UICollectionViewFlowLayout alloc]init];
    flow.minimumLineSpacing=0;
    
    flow.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    flow.itemSize=self.frame.size;
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flow];
    [collectionView registerClass:[HGScrollCell  class] forCellWithReuseIdentifier:HGScrollName];
    collectionView.showsHorizontalScrollIndicator=NO;
    collectionView.delegate=self;
    collectionView.dataSource=self;
    collectionView.pagingEnabled=YES;
    [self addSubview:collectionView];
    self.scrollCollection=collectionView;
    
}
#pragma mark 删除控制器的方法
-(void)removeTimer
{
    [self.timer invalidate];
    self.timer=nil;
}
#pragma mark 添加页控件setupPage
-(void)setupPage
{
    UIPageControl *page=[[UIPageControl alloc]init];
    page.numberOfPages=self.arr.count;
    page.pageIndicatorTintColor=HGColor(255, 255, 255);
    
    page.currentPageIndicatorTintColor=HGColor(252, 73, 80);
    CGFloat pageW=100;
    CGFloat pageH=30;
    CGFloat pageX=(self.width-pageW)*0.5;
    CGFloat pageY=self.height-pageH+5;
    page.frame=CGRectMake(pageX, pageY, pageW, pageH);
    [self addSubview:page];
    self.page=page;
    
}
#pragma mark  每一组返回多少行
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr.count;
}
#pragma mark 返回多少组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return MaxCount;
}
#pragma mark 返回单元
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HGScrollCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:HGScrollName forIndexPath:indexPath];
    
    //cell.backgroundColor=[UIColor redColor];
    HGScrollModel *model=self.arr[indexPath.item];
    cell.scrollModel=model;
    return cell;
    
}
#pragma mark 店家的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(scrollClick:clickIndex:)]){
        NSInteger clickD=indexPath.item%self.arr.count;
        [self.delegate scrollClick:self clickIndex:clickD];
    }
}


#pragma mark 手指将要托转的时候
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // NSLog(@"scrollViewWillBeginDragging");
    [self removeTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
   // NSLog(@"scrollViewDidEndDragging");
    [self addTimer];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   // NSLog(@"scrollViewDidEndDecelerating--->");
    [self resetIndexPath];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page=(scrollView.contentOffset.x/scrollView.frame.size.width+0.5);
    int currentPage=page%self.arr.count;
    self.page.currentPage=currentPage;
}




@end
