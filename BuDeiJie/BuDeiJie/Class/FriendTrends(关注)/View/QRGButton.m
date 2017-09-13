//
//  QRGButton.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/12.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "QRGButton.h"


@implementation QRGButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    
    return self;
}

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    self.imageView.backgroundColor = [UIColor redColor];
    
    self.titleLabel.backgroundColor = [UIColor brownColor];
    
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    self.imageView.centerX = self.centerX;
    self.imageView.Y = 0;
    
    
    [self.titleLabel sizeToFit];
    self.titleLabel.centerX = self.centerX;
    self.titleLabel.Y = self.height - self.titleLabel.height;
}
@end
