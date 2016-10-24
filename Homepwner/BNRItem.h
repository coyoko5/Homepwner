//
//  BNRItem.h
//  RandomItems
//
//  Created by Jin on 16/9/11.
//  Copyright © 2016年 ETONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

//属性
{
    NSString *_itemName;
    NSString *_serialNumber;
    int _valueInDollars;
    NSDate *_dateCreated;
}

@property(nonatomic,copy) NSString *itemKey;

//set get方法声明
-(void)setItemName:(NSString *)str;
-(NSString *)itemName;

-(void)setSerialNumber:(NSString *)str;
-(NSString *)serialNumber;

-(void)setValueInDollars:(int)v;
-(int)valueInDollars;

-(NSDate *)dateCreated;

//类的指定初始化方法
-(instancetype)initWithItemName:(NSString *)name ValueInDollars:(int)value serialNumber:(NSString *)sNumber;
-(instancetype)initWithItemName:(NSString *)name;
-(instancetype)initWithItemName:(NSString *)name serialNumber:(NSString *)snumber;

//类方法
+(instancetype)randomItem;

@end
