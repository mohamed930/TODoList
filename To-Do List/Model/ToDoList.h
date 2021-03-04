//
//  ToDoList.h
//  To-Do List
//
//  Created by Mohamed Ali on 2/25/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToDoList : NSObject <NSCoding>

@property NSString  *ID ,*name, *desc , *priority , *DeadLineData , *DateCreation , *state;

- (void)saveCustomObject:(NSMutableArray<ToDoList *> *)object key:(NSString *)key;

- (NSArray<ToDoList *> *)loadCustomObjectWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
