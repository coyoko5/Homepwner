//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Jin on 16/9/28.
//  Copyright © 2016年 ETONE. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;
@interface BNRItemStore : NSObject

//模型数组
@property(nonatomic,readonly) NSArray *allItems;

//Caution this is a class method + not -
+(instancetype)sharedStore;
-(BNRItem *)createItem;
-(void)removeItem:(BNRItem *)item;
-(void)moveItemAtIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;


@end
