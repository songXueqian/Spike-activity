//
//  CollectionViewCell.m
//  ScrollView
//
//  Created by 宋学谦 on 2017/1/5.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "CollectionViewCell.h"
#import "TableViewCell.h"

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
//        self.myImage = [[UIImageView alloc] init];
//        self.myImage.backgroundColor = [UIColor lightGrayColor];
//        [self.contentView addSubview:self.myImage];
//        
//        self.myLabel = [[UILabel alloc] init];
//        self.myLabel.backgroundColor = [UIColor grayColor];
//        [self.contentView addSubview:self.myLabel];
        
        
        //tableView
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.tableView];
        
    }
    return self;
}

#pragma mark -- taleView  的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
//    return [self.dataTableArray count];
        return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TableViewCell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.kindLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    
    cell.backgroundColor = [UIColor purpleColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
//    self.myImage.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height - 30);
//    [self.myImage setContentMode:UIViewContentModeScaleAspectFill];
//    self.myImage.clipsToBounds = YES;
    
//    self.myLabel.frame = CGRectMake(0, self.myImage.frame.origin.y + self.myImage.frame.size.height, self.contentView.bounds.size.width, 30);
}


@end
