//
//  HGWaterFlow.m
//  HiGo
//
//  Created by Think_lion on 15/7/27.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGWaterFlow.h"

@interface HGWaterFlow ()

//存放的最大的Y值
@property (nonatomic,strong) NSMutableDictionary *maxDict;

@property (nonatomic,strong) NSMutableArray *attrsArr;

@end

@implementation HGWaterFlow

-(NSMutableDictionary *)maxDict
{
    if(!_maxDict) {
        _maxDict=[NSMutableDictionary dictionary];
        for(int i=0;i<self.columsCount;i++){
            NSString *column=[NSString stringWithFormat:@"%d",i];
            self.maxDict[column]=@"0";
        }
    }
    return _maxDict;
}

-(NSMutableArray *)attrsArr
{
    if(!_attrsArr){
        _attrsArr=[NSMutableArray array];
    }
    return _attrsArr;
}

-(instancetype)init
{
    self=[super init];
    if(self){
        self.columnMargin=10;
        self.rowMargin=10;
        self.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
        self.columsCount=3;
        
    }
    return self;
}

-(void)prepareLayout
{
    [super prepareLayout];
    //每次刷新前清空
    for(int i=0;i<self.columsCount;i++){
        NSString *column=[NSString stringWithFormat:@"%d",i];
        self.maxDict[column]=@(self.sectionInset.top);
    }
    
    [self.attrsArr removeAllObjects];
    //查看有多少个模型
    NSInteger count=[self.collectionView numberOfItemsInSection:0];
    //便利每一个item的属性
    for(int i=0;i<count;i++) {
        //2.取出对应的集合视图的布局属性
        UICollectionViewLayoutAttributes *attr=[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        //3.把每一个布局属性添加到数据中
        [self.attrsArr addObject:attr];
    }
    
}

#pragma mark  设置滚动的范围
-(CGSize)collectionViewContentSize
{
    __block  NSString *maxColumn=@"0";
    
    [self.maxDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if([maxY floatValue]>[self.maxDict[maxColumn] floatValue]){
            maxColumn=column;
        }
    }];
    
    return CGSizeMake(0, [self.maxDict[maxColumn] floatValue]+self.sectionInset.bottom);
    
}


/*
 只要滚动屏幕 就会调用  方法  -(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
 只要布局页面的属性发生改变 就会重新调用  -(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect  这个方法
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
#pragma mark 设置内个单元格的属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //假设最短的那一列是第零列
    __block NSString *miniColumn=@"0";
    //遍历字典
    [self.maxDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        //如果y值小于当前最小的值
        
        //NSLog(@"--->%d",[maxY intValue]);
        if([maxY floatValue]<[self.maxDict[miniColumn] floatValue]){
            // NSLog(@"%@   %@",column,maxY);
            miniColumn=column;
        }
        
    }];
    
    //计算frame
    CGFloat width=(self.collectionView.frame.size.width-self.sectionInset.left-self.sectionInset.right-self.columnMargin*(self.columsCount-1))/self.columsCount;
    //计算高度
    CGFloat height=[self.delegate waterFlow:self heightForWidth:width indexPath:indexPath];
    
    CGFloat x=self.sectionInset.left+(width+self.columnMargin)*[miniColumn intValue];
    CGFloat y=[self.maxDict[miniColumn] floatValue]+self.rowMargin;
    //更新这一列最大的y值
    self.maxDict[miniColumn]=@(y+height);
    
    UICollectionViewLayoutAttributes *attr=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attr.frame=CGRectMake(x, y, width, height);
    return attr;
}

#pragma mark 设置每个cell属性的位置 大小
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    return self.attrsArr;
    
}

@end
