//
//  VoiceView.m
//  BuDeiJie
//
//  Created by QIUGUI on 2017/9/9.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "VoiceView.h"


@interface VoiceView ()


/** 真实的播放次数*/
@property (weak, nonatomic) IBOutlet UILabel *playfcount;

/** 如果为音频类帖子，则返回值为音频的时长*/
@property (weak, nonatomic) IBOutlet UILabel *voicetimeL;


@end

@implementation VoiceView


- (void)awakeFromNib{
    
    [super awakeFromNib];
    
//    [self.progressSlider setThumbImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
//    self.progressSlider.minimumTrackTintColor = [UIColor clearColor];
//    self.progressSlider.maximumTrackTintColor = [UIColor clearColor];
//
    
}
- (void)setIcon:(NSString *)icon{
    
    _icon = icon;
    
    [self.aImageView sd_setImageWithURL:[NSURL URLWithString:icon] placeholderImage:[UIImage imageNamed:@"post_placeholderImage"]];
    
}
- (void)setCount:(NSString *)count{
    
    _count = count;
    
    self.playfcount.text = count;
}
- (void)setTime:(NSString *)time{
    
    _time = time;
    self.voicetimeL.text = time;
}

+ (instancetype)createVoiceView{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"VoiceView" owner:self options:nil]firstObject];
}


@end
