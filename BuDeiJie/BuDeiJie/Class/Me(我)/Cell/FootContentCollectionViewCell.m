//
//  FootContentCollectionViewCell.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/7.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "FootContentCollectionViewCell.h"

#import "Square_list.h"

@interface FootContentCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;


@end

@implementation FootContentCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    
}

- (void)setMod:(Square_list *)mod{
    
    _mod = mod;
    
    self.name.text = mod.name;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:mod.icon] placeholderImage:[UIImage imageNamed:@"post_placeholderImage"]];
    
}
@end
