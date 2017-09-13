//
//  TopTitleView.h
//  BuDeiJie
//
//  Created by 邱荣贵 on 2017/9/7.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TopTitleViewDelegate <NSObject>

- (void)TopTitleViewClikeTitleWithIndexPath:(NSInteger)aIndex;

@end
@interface TopTitleView : UIView

@property (nonatomic,strong) NSArray * topTtileData;

@property (nonatomic,assign) NSInteger selectedIndex;

@property (nonatomic,weak) id<TopTitleViewDelegate> delegate;

@end
