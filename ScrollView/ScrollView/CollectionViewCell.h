//
//  CollectionViewCell.h
//  ScrollView
//
//  Created by 宋学谦 on 2017/1/5.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell<UITableViewDataSource, UITableViewDelegate>
//@property (nonatomic, strong)UIImageView *myImage;
//@property (nonatomic, strong)UILabel *myLabel;

//tableView
@property (nonatomic, strong)UITableView *tableView;
//tableView数组
@property (nonatomic, strong)NSMutableArray *dataTableArray;

@end
