//
//  EssenceModelF.m
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/8.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "EssenceModelF.h"
#import "EssenceModel.h"
@implementation EssenceModelF

//- (void)setMod:(EssenceModel *)mod{
//    
//    _mod = mod;
//}
//


- (int)CellH{
    
       
    self.profile_imageF = CGRectMake(Margen, Margen, 40, 40);
    
    self.screen_nameF = CGRectMake(CGRectGetMaxX(self.profile_imageF) + Margen, Margen, kScreenWidth - CGRectGetMaxX(self.profile_imageF) - Margen * 2, 20);
    
    self.created_atF = CGRectMake(CGRectGetMaxX(self.profile_imageF) + Margen, CGRectGetMaxY(self.screen_nameF), kScreenWidth - CGRectGetMaxX(self.profile_imageF) - Margen * 2, 20);

    CGSize textSize = [self.mod.text returnSizeWithFont:15 maxWidth:kScreenWidth - Margen * 2 maxHeight:MAXFLOAT];
    
    self.textF = CGRectMake(Margen,CGRectGetMaxY(self.profile_imageF) + Margen, kScreenWidth - Margen * 2, textSize.height);
    
    if(self.mod.image1){
        
        CGFloat h =  [self.mod.height doubleValue] / [self.mod.width doubleValue] * (kScreenWidth - Margen * 2);
        
        if(h >= kScreenHeight){
            
            h = 200;
        }
    
        
        return CGRectGetMaxY(self.textF) + Margen + 45 + h + 10;

    }else{
        return CGRectGetMaxY(self.textF) + Margen + 45;    
    }
    
    
}


@end
