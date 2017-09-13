//
//  UIView+Extensions.m
//  JIE
//
//  Created by QIUGUI on 2017/8/19.
//  Copyright © 2017年 QIUGUI. All rights reserved.
//

#import "UIView+Extensions.h"

@implementation UIView (Extensions)

- (void)setX:(CGFloat)X{
    
    CGRect frame = self.frame;
    frame.origin.x = X;
    self.frame = frame;
}

- (void)setY:(CGFloat)Y{
    CGRect frame = self.frame;
    frame.origin.y = Y;
    self.frame = frame;
}
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)X{
    return self.frame.origin.x;
}
- (CGFloat)Y{
    return self.frame.origin.y;
}
- (CGFloat)width{
    return self.frame.size.width;
}
- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}
- (CGFloat)centerX{
    return self.center.x;
}
@end
