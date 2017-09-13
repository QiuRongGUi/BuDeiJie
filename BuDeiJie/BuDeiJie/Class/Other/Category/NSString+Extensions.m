//
//  NSString+Extensions.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/8.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "NSString+Extensions.h"

#import <UIKit/UIKit.h>

@implementation NSString (Extensions)

- (CGSize )returnSizeWithFont:(CGFloat)aFont maxWidth:(CGFloat)width maxHeight:(CGFloat)height{
    
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:aFont]} context:nil].size;
    
    return size;
}
@end
