//
//  EssenceModelF.h
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/8.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@class EssenceModel;

@interface EssenceModelF : NSObject

/** 发帖人的昵称*/
@property(nonatomic,assign) CGRect screen_nameF;
/** 头像的图片url地址*/
@property(nonatomic,assign) CGRect profile_imageF;
/** 系统审核通过后创建帖子的时间*/
@property(nonatomic,assign) CGRect created_atF;
/** 帖子的内容*/
@property(nonatomic,assign) CGRect textF;

@property (nonatomic,assign) int CellH;

@property (nonatomic,strong) EssenceModel * mod;

@end
