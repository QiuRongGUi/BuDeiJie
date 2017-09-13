//
//  PictureTableViewCell.h
//  BuDeiJie
//
//  Created by QIUGUI on 2017/9/8.
//  Copyright © 2017年 邱九. All rights reserved.
//

#import "TopicTableViewCell.h"

@protocol PictureTableViewCellDelegate <NSObject>

- (void)PictureTableViewCellClikePictureWithIndexPath:(NSInteger)indexPath;

@end

@interface PictureTableViewCell : TopicTableViewCell

/** <#class#>*/
@property(nonatomic,strong) EssenceModelF  *modf;

/** <#class#>*/
@property(nonatomic,weak) id<PictureTableViewCellDelegate>  delegate;

/** <#class#>*/
@property(nonatomic,assign) NSInteger  indexPath;


@end
