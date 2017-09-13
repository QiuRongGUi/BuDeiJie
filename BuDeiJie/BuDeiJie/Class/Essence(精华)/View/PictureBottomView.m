//
//  PictureBottomView.m
//  BuDeiJie
//
//  Created by QIUGUI on 2017/9/9.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "PictureBottomView.h"

@implementation PictureBottomView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
     
    NSTextAttachment *imageA = [[NSTextAttachment alloc] init];
    UIImage *aImage = [UIImage imageNamed:@"see-big-picture"];
    imageA.image = aImage;
    imageA.bounds = CGRectMake(0, - 2,aImage.size.width , aImage.size.height);
    
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@" 点击查看大图"];
    
    NSAttributedString *str2 = [NSAttributedString attributedStringWithAttachment:imageA];
    
    NSMutableAttributedString *mA = [[NSMutableAttributedString alloc] init];
    
    [mA appendAttributedString:str2];
    
    [mA appendAttributedString:str1];

    self.hit.attributedText = mA;
    
}

+ (instancetype)createPictureBottomView{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"PictureBottomView" owner:self options:nil]firstObject];
}

@end
