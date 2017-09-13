
//
//  GroupTableViewCell.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/12.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "GroupTableViewCell.h"

#import "UIImage+Extensions.h"

#import "UserGroupModel.h"

@interface GroupTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (weak, nonatomic) IBOutlet UILabel *screen_name;

@property (weak, nonatomic) IBOutlet UILabel *fans_count;



@end

@implementation GroupTableViewCell


- (void)setFrame:(CGRect)frame{
    
    frame.size.height -= 1;
    
    [super setFrame:frame];
    
    
}

- (void)setMod:(UserGroupModel *)mod{
    
    _mod = mod;
    
    
    [self.header sd_setImageWithURL:[NSURL URLWithString:mod.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    
        if(!image) return ;
        
        image = [UIImage imageWithRadiusImage:image];
        
        self.header.image = image;
        
    }];
    
    
    
    self.screen_name.text = mod.screen_name;
    
    self.fans_count.text = mod.fans_count;
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
