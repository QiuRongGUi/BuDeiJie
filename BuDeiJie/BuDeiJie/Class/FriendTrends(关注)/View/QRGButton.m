//
//  QRGButton.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/12.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "QRGButton.h"


@implementation QRGButton


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

    self.imageView.Y = 0;
    self.imageView.centerX = self.width * 0.5;
    
    self.titleLabel.centerX = self.width * 0.5;
    [self.titleLabel sizeToFit];
    self.titleLabel.Y = self.height - self.titleLabel.height;
    
    
    
}
@end
