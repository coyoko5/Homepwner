//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Jin on 16/9/28.
//  Copyright © 2016年 ETONE. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRImageStore.h"
#import "BNRItem.h"

@interface BNRItemStore ()

//私有成员属性 私有模型数组[可变]
@property(nonatomic) NSMutableArray *privateItems;

@end

@implementation BNRItemStore

+(instancetype)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    
    //判断是否需要创建一个sharedStore对象
    if(!sharedStore)
    {
        sharedStore = [[BNRItemStore alloc] initPrivate];
    }
    return sharedStore;
}

-(void)removeItem:(BNRItem *)item
{
    NSString *key = item.itemKey;
    [[BNRImageStore sharedStore] deleteImageForKey:key];
    
    [self.privateItems removeObjectIdenticalTo:item];
    
}

-(void)moveItemAtIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    if(fromIndex == toIndex)
    {
        return;
    }
    
    //得到要移动对象的指针
    BNRItem *item = self.privateItems[fromIndex];
    
    //将item从allItems数组中移除
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    //根据新的索引位置,将item插回数组
    [self.privateItems insertObject:item atIndex:toIndex];
}

//如果调用init 提示商用initPrivate
-(instancetype)init
{
    //抛出一个异常
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRItemStore sharedStore]" userInfo:nil];
    return nil;
}

//Here is the real(secret) initializer
-(instancetype)initPrivate
{
    self = [super init];
    if(self)
    {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSArray *)allItems
{
    return self.privateItems;
}

-(BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];
    [self.privateItems addObject:item];
    return item;
}
@end
