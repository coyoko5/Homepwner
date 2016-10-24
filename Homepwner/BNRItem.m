//
//  BNRItem.m
//  RandomItems
//
//  Created by Jin on 16/9/11.
//  Copyright © 2016年 ETONE. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

//set get 方法的实现
-(void)setItemName:(NSString *)str
{
    _itemName = str;
}

-(NSString *)itemName
{
    return _itemName;
}

-(void)setSerialNumber:(NSString *)str
{
    _serialNumber = str;
}

-(NSString *)serialNumber
{
    return _serialNumber;
}

-(void)setValueInDollars:(int)v
{
    _valueInDollars = v;
}

-(int)valueInDollars
{
    return _valueInDollars;
}

-(NSDate *)dateCreated
{
    return _dateCreated;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"名称:%@ 序列号:%@ 价格:$%d 日期:%@",self.itemName,self.serialNumber,self.valueInDollars,self.dateCreated];
}

-(instancetype)initWithItemName:(NSString *)name ValueInDollars:(int)value serialNumber:(NSString *)sNumber
{
    self = [super init];
    if(self)
    {
        _itemName = name;
        _valueInDollars = value;
        _serialNumber = sNumber;
        
        //设置时间
        _dateCreated = [[NSDate alloc] init];
        
        //Create an NSUUID object - and get it's string representation
        NSUUID *uuid = [[NSUUID alloc] init];
        NSString *key = [uuid UUIDString];
        _itemKey = key;
    }
    return self;
}

//指定初始化方法
-(instancetype)initWithItemName:(NSString *)name serialNumber:(NSString *)snumber
{
    return [self initWithItemName:name serialNumber:snumber];
}

-(instancetype)initWithItemName:(NSString *)name
{
    return [self initWithItemName:name ValueInDollars:0 serialNumber:@""];
}

-(instancetype)init
{
    return [self initWithItemName:@"Item"];
}

//类方法
+(instancetype)randomItem
{
    NSArray *randomAdjectiveList = @[@"Fluffy",@"Rusty",@"Shiny"];
    NSArray *randomNounList = @[@"Beer",@"Spork",@"Mac"];
    
    NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    NSInteger nounList = arc4random() % [randomNounList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",[randomAdjectiveList objectAtIndex:adjectiveIndex],[randomNounList objectAtIndex:nounList]];
    
    int randomValue = arc4random() % 100;
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0'+arc4random() % 10,
                                    'A'+arc4random() % 26,
                                    '0'+arc4random() % 10,
                                    'A'+arc4random() % 26,
                                    '0'+arc4random() % 10
                                    ];
    
    BNRItem *newItem  = [[self alloc] initWithItemName:randomName ValueInDollars:randomValue serialNumber:randomSerialNumber];
    return newItem;
}


@end
