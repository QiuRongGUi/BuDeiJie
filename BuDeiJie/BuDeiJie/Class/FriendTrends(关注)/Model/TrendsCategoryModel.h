//
//  TrendsCategoryModel.h
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/12.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrendsCategoryModel : NSObject
/**此标签下的用户数**/
@property (nonatomic,copy) NSString * count;
/**标签名称**/
@property (nonatomic,copy) NSString * name;
/**标签id**/
@property (nonatomic,copy) NSString * ID;

@end

