//
//  EssenceModel.h
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/8.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EssenceModel : UIView

/** 发帖人的昵称*/
@property(nonatomic,copy) NSString *screen_name;
/** 头像的图片url地址*/
@property(nonatomic,copy) NSString *profile_image;
/** 系统审核通过后创建帖子的时间*/
@property(nonatomic,copy) NSString *created_at;
/** 帖子的内容*/
@property(nonatomic,copy) NSString *text;


/** 如果为音频，则为音频的播放地址*/
@property(nonatomic,copy) NSString *voiceuri;
/** 视频加载时候的静态显示的图片地址*/
@property(nonatomic,copy) NSString *cdn_img;
/** 显示在页面中的视频图片的url*/
@property(nonatomic,copy) NSString *image1;
/** 显示在页面中的视频图片的url*/
@property(nonatomic,copy) NSString *image_small;


/** 顶！d=====(￣▽￣*)b的数量*/
@property(nonatomic,copy) NSString *ding;
/** 踩的数量*/
@property(nonatomic,copy) NSString *hate;

/** 转发的数量*/
@property(nonatomic,copy) NSString *repost;
/** 帖子的被评论数量*/
@property(nonatomic,copy) NSString *comment;
/** 真实的播放次数*/
@property(nonatomic,copy) NSString *playfcount;


/** 图片或视频等其他的内容的高度*/
@property(nonatomic,copy) NSString *height;
/** 视频或图片类型帖子的宽度*/
@property(nonatomic,copy) NSString *width;

/** 视频播放的url地址*/
@property(nonatomic,copy) NSString *videouri;

/** 是否是gif动画*/
@property(nonatomic,copy) NSString *is_gif;
/** 帖子的所属分类的标签名字*/
@property(nonatomic,copy) NSString *theme_name;

/** 如果为音频类帖子，则返回值为音频的时长*/
@property(nonatomic,copy) NSString *voicetime;

/**是否正在播放**/
@property (nonatomic,assign) BOOL playerState;

@property (nonatomic,assign) BOOL State;


@end
