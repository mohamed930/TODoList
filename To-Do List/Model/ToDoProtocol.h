//
//  ToDoProtocol.h
//  To-Do List
//
//  Created by Mohamed Ali on 2/27/21.
//

#import <Foundation/Foundation.h>
#import "ToDoList.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ToDoProtocol <NSObject>

-(void) SendNewNote:(ToDoList *) t :(BOOL) EditTage;

@end

NS_ASSUME_NONNULL_END
