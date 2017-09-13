//
//  EssenceBottonView.h
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/8.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EssenceBottonView : UIView
/**顶**/
@property (nonatomic,strong) UIButton * dingBut;
/** 踩的数量**/
@property (nonatomic,strong) UIButton * hateBut;
/** 转发的数量*/
@property (nonatomic,strong) UIButton * repostBut;
/** 帖子的被评论数量*/
@property (nonatomic,strong) UIButton * commentBut;


@end
