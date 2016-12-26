//
//  ListModel.h
//  NewList
//
//  Created by 杨松 on 2016/12/25.
//  Copyright © 2016年 杨松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject
@property(nonatomic ,copy)NSString * _image_url;

@property(nonatomic ,assign)NSInteger likes_count;

@property(nonatomic ,assign)NSInteger  myId;

@property(nonatomic ,copy)NSString * title;
@property(nonatomic ,copy)NSString * dis;

+(ListModel *)parseModelWithDic:(NSDictionary*)dic;
@end
