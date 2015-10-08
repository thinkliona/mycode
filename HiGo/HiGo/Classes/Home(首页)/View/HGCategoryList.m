//
//  GHCategoryList.m
//  HiGo
//
//  Created by Think_lion on 15/7/27.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGCategoryList.h"
#import "HGCategoryCell.h"
#import "HGCategoryModel.h"
#import "HGImageModel.h"

#define CategoryCell @"CategoryCell"

@interface HGCategoryList ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,weak) UICollectionView *collectionViiew;


@end

@implementation HGCategoryList



-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        //1.添加collectionview
        [self addView];
    }
    return self;
}


#pragma mark 添加collectionView
-(void)addView
{
   //1.创建collectinView
    UICollectionViewFlowLayout *flow=[[UICollectionViewFlowLayout alloc]init];
    flow.minimumLineSpacing=10;
    flow.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    flow.itemSize=CGSizeMake(80, 80);
    flow.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flow];
    [collectionView registerClass:[HGCategoryCell class] forCellWithReuseIdentifier:CategoryCell];
    collectionView.backgroundColor=[UIColor whiteColor];
    collectionView.delegate=self;
    collectionView.dataSource=self;
    collectionView.showsHorizontalScrollIndicator=NO;
    [self addSubview:collectionView];
    self.collectionViiew=collectionView;
}

#pragma mark 返回多少行
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}

#pragma mark  返回cell
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HGCategoryCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:CategoryCell forIndexPath:indexPath];
    HGCategoryModel *cateModel=self.data[indexPath.item];
    
    cell.cateModel=cateModel;
    return cell;
}

-(void)setData:(NSArray *)data
{
    _data=data;
//    for(HGCategoryModel *cate in data) {
//        NSLog(@"%@  %@",cate.name,cate.image.image_original);
//    }
    [self.collectionViiew reloadData];
}


#pragma mark 点击的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(categoaryList:clickIndex:)]){
        [self.delegate categoaryList:self clickIndex:indexPath.item];
    }
}

@end
