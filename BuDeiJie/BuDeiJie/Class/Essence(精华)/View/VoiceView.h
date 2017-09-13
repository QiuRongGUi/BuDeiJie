//
//  VoiceView.h
//  BuDeiJie
//
//  Created by QIUGUI on 2017/9/9.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VoiceView : UIView


/** <#class#>*/
@property(nonatomic,copy) NSString  *icon;
/** <#class#>*/
@property(nonatomic,copy) NSString  *count;
/** <#class#>*/
@property(nonatomic,copy) NSString  *time;

@property (weak, nonatomic) IBOutlet UIButton *butType;

+ (instancetype)createVoiceView;

@end
