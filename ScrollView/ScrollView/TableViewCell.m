//
//  TableViewCell.m
//  ScrollView
//
//  Created by 宋学谦 on 2017/1/5.
//  Copyright © 2017年 SongXueqian. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.kindLabel = [[UILabel alloc] init];
        self.kindLabel.backgroundColor = [UIColor cyanColor];
        [self addSubview:self.kindLabel];
        
        
        
        
        
    }
    return self;
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.kindLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
