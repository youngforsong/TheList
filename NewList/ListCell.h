//
//  ListCell.h
//  NewList
//
//  Created by 杨松 on 2016/12/25.
//  Copyright © 2016年 杨松. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"
@interface ListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *dis;
@property (weak, nonatomic) IBOutlet UIImageView *cImageView;
@property (nonatomic, assign) CGFloat cellHeight;
-(void)refreshNewsCellWithModel:(ListModel *)model;
@end
