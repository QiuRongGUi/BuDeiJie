//
//  UIImage+Extensions.m
//  BuDeiJie
//
//  Created by QIUGUI on 2017/9/10.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "UIImage+Extensions.h"

@implementation UIImage (Extensions)


+ (UIImage *)imageWithRadiusImage:(UIImage *)aIamage{
    
    UIImage *image;
    
    image = aIamage;
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0,image.size.width , image.size.height)];
    [path addClip];
    
    [image drawAtPoint:CGPointZero];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
