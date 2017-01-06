//
//  ViewController.h
//  ScrollView
//
//  Created by 宋学谦 on 2017/1/4.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong)UICollectionView *collectionView;
//collectionView数组
@property (nonatomic, strong)NSMutableArray *dataCollectionArray;




@end

