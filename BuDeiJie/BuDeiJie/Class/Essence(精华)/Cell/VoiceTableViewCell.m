//
//  VoiceTableViewCell.m
//  BuDeiJie
//
//  Created by QIUGUI on 2017/9/8.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "VoiceTableViewCell.h"

#import "EssenceModelF.h"

#import "EssenceModel.h"


@interface VoiceTableViewCell ()


@end

@implementation VoiceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        VoiceView *aImageView = [VoiceView createVoiceView];
        [self.contentView addSubview:aImageView];
        self.image1 = aImageView;
        
        [self.image1.butType addTarget:self action:@selector(clikePlayer:) forControlEvents:UIControlEventTouchUpInside];
                
    }
    return self;
}

- (void)toolbarHidden:(BOOL)state{
    
    NSLog(@"%d--bool",state);
}

- (void)clikePlayer:(UIButton *)sends{
    
    
    if(self.modF.mod.videouri.length){
        NSLog(@"播放--- 视频");
        
        if([self.delegate respondsToSelector:@selector(videoPlayerWithIndexPath:)]){
            [self.delegate videoPlayerWithIndexPath:sends];
        }
            
    }else{
        NSLog(@"播放--- 音频");

        if([self.delegate respondsToSelector:@selector(voicePlayerWithIndexPath:)]){
            [self.delegate voicePlayerWithIndexPath:self.indexPath];
        }

    }
    
    
}
- (void)changePross:(UISlider *)sends{
    
    if([self.delegate respondsToSelector:@selector(voicePlayerUpdateProgressWithSlider:cell:)]){
        [self.delegate voicePlayerUpdateProgressWithSlider:sends cell:self];
    }
}

- (void)setModf:(EssenceModelF *)modf{
    
    [super setModF:modf];
    
    self.image1.icon = modf.mod.image1;
    self.image1.count = modf.mod.playfcount;
    self.image1.time = modf.mod.voicetime;

    self.image1.butType.tag = self.indexPath;
    if(modf.mod.voiceuri.length){
        
        self.image1.progress.hidden = YES;
        self.image1.progressSlider.hidden = YES;
        
        self.image1.progress.progress = modf.mod.progress;
        self.image1.progressSlider.maximumValue = [modf.mod.voicetime floatValue];

    }
    

    NSLog(@"%f---",modf.mod.progress);
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    CGFloat h =  [self.modF.mod.height doubleValue] / [self.modF.mod.width doubleValue] * (kScreenWidth - Margen * 2);
    
    self.image1.X = Margen;
    self.image1.Y = CGRectGetMaxY(self.modF.textF) + Margen;
    self.image1.width = kScreenWidth - Margen * 2;
    self.image1.height = h;
    
}


@end
