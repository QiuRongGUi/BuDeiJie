//
//  QRGUIKit.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/6.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "QRGUIKit.h"

@implementation QRGUIKit


+ (UIButton *)buttonWithframe:(CGRect)frame aTag:(NSInteger)tag addTarget:(id)target action:(SEL)action aTitleColor:(UIColor *)color aImage:(NSString *)image aHighlightedImage:(NSString *)highlightedimage aSelectedImage:(NSString *)selectedImage aBackgroundImage:(NSString *)backgroundImage aFontOfSize:(CGFloat)fontSize aTitle:(NSString *)title{
    
       
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = frame;
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    
    if(image){
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if(highlightedimage){
        [button setImage:[UIImage imageNamed:highlightedimage] forState:UIControlStateHighlighted];
    }
    if(selectedImage){
        [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    }

    if(backgroundImage){
        [button setBackgroundImage:[UIImage imageNamed:backgroundImage] forState:UIControlStateNormal];
    }
    
    
    [button setTitleColor:color forState:UIControlStateNormal];

    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}
@end
