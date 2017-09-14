//
//  VoiceTableViewCell.h
//  BuDeiJie
//
//  Created by QIUGUI on 2017/9/8.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "TopicTableViewCell.h"

#import "VoiceView.h"

@class VoiceTableViewCell;

@protocol VoiceTableViewCellDelegate <NSObject>

/**音频**/
- (void)voicePlayerWithIndexPath:(NSInteger)aIndexPath;
/**视频**/
- (void)videoPlayerWithIndexPath:(NSInteger)aIndexPath tableViewCell:(VoiceTableViewCell *)cell;
/**进度**/
- (void)voicePlayerUpdateProgressWithSlider:(UISlider *)slider cell:(VoiceTableViewCell *)cell;


@end
@interface VoiceTableViewCell : TopicTableViewCell

@property(nonatomic,strong) EssenceModelF  *modf;

@property (nonatomic,assign) NSInteger indexPath;
/** <#class#>*/
@property(nonatomic,strong) VoiceView  *image1;

@property (nonatomic,strong) UIButton * testBut;
@property (nonatomic,weak) id<VoiceTableViewCellDelegate> delegate;


@end
