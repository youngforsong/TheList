//
//  ListCell.m
//  NewList
//
//  Created by 杨松 on 2016/12/25.
//  Copyright © 2016年 杨松. All rights reserved.
//

#import "ListCell.h"
#import "UIImageView+AFNetworking.h"
@implementation ListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)refreshNewsCellWithModel:(ListModel *)model
{
    if ([model.title isKindOfClass:[NSNull class]] ) {
        self.title.text=@"";
    }else{
        self.title.text=[NSString stringWithFormat:@"%@",model.title];
    }
    
    if ([model.dis isKindOfClass:[NSNull class]]) {
        self.dis.text=@"";
    }else{
        NSString* content=[NSString stringWithFormat:@"%@",model.dis];
        CGRect s = [content boundingRectWithSize:CGSizeMake(self.dis.frame.size.width,10000) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f]} context:nil];
        self.cellHeight=s.size.height;
        self.dis.text=[NSString stringWithFormat:@"%@",model.dis];
    }
    
    if ([model._image_url isKindOfClass:[NSNull class]]) {
        self.cImageView.image=[UIImage imageNamed:@""];
        
    }else{
        [self.cImageView setImageWithURL:[NSURL URLWithString:model._image_url]];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
