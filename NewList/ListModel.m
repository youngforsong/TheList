//
//  ListModel.m
//  NewList
//
//  Created by 杨松 on 2016/12/25.
//  Copyright © 2016年 杨松. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        
        self.myId=(NSInteger)value;
        
    }
    
}

-(id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}
-(instancetype)initWithDic:(NSDictionary*)dic
{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dic];
        
    }
    return self;
}
+(ListModel *)parseModelWithDic:(NSDictionary*)dic
{
    ListModel* model=[[ListModel alloc]initWithDic:dic];
    
    return model;
    
}

@end
