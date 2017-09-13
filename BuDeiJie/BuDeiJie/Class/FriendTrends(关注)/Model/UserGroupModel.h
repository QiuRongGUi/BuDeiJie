//
//  UserGroupModel.h
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/12.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserGroupModel : NSObject

/**此标签下的用户数**/
@property (nonatomic,copy) NSString * header;
/**标签名称**/
@property (nonatomic,copy) NSString * screen_name;
/**标签id**/
@property (nonatomic,copy) NSString * fans_count;


@end
