//
//  EssenceModel.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/8.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "EssenceModel.h"

@implementation EssenceModel


- (NSString *)playfcount{
    
    NSString *count = [NSString stringWithFormat:@"%@%@",@"播放次数:",_playfcount];
    
    return count;
}

//- (NSString *)voicetime{
//    
//   NSString *time ;
//        
//   NSString *time1 = [NSString stringWithFormat:@"%.2d:",[_voicetime intValue] / 60];
//    
//   NSString *time2 = [NSString stringWithFormat:@"%.2d",[_voicetime intValue] % 60]; 
//    
//   time = [NSString stringWithFormat:@"%@%@%@",@"播放时长:",time1,time2];
//
//    return time;
//}

//- (BOOL)playerState{
//    
//    return NO;
//}

@end
