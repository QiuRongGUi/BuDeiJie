//
//  QRGUIKit.h
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/6.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface QRGUIKit : NSObject


+ (UIButton *)buttonWithframe:(CGRect)frame aTag:(NSInteger)tag addTarget:(id)target action:(SEL)action aTitleColor:(UIColor *)color aImage:(NSString *)image aHighlightedImage:(NSString *)highlightedimage aSelectedImage:(NSString *)selectedImage aBackgroundImage:(NSString *)backgroundImage aFontOfSize:(CGFloat)fontSize aTitle:(NSString *)title;


@end
