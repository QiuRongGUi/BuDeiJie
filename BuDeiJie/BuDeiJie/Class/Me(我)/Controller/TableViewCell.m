//
//  TableViewCell.m
//  BuDeiJie
//
//  Created by QIUGUI on 2017/9/7.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)setFrame:(CGRect)frame{
    
    frame.size.height -= Margen;
    [super setFrame:frame];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];


    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
