//
//  ToDoList.m
//  To-Do List
//
//  Created by Mohamed Ali on 2/25/21.
//

#import "ToDoList.h"

@implementation ToDoList

// *ID ,*name, *desc , *priority , *DeadLineData , *DateCreation , *state

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.ID forKey:@"ID"];
    [coder encodeObject:self.desc forKey:@"desc"];
    [coder encodeObject:self.priority forKey:@"priority"];
    [coder encodeObject:self.DeadLineData forKey:@"DeadLineData"];
    [coder encodeObject:self.DateCreation forKey:@"DateCreation"];
    [coder encodeObject:self.state forKey:@"state"];
    
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.name = [coder decodeObjectForKey:@"name"];
        self.ID = [coder decodeObjectForKey:@"ID"];
        self.desc = [coder decodeObjectForKey:@"desc"];
        self.priority = [coder decodeObjectForKey:@"priority"];
        self.DeadLineData = [coder decodeObjectForKey:@"DeadLineData"];
        self.DateCreation = [coder decodeObjectForKey:@"DateCreation"];
        self.state = [coder decodeObjectForKey:@"state"];
    }
    return self;
}
 

- (void)saveCustomObject:(NSMutableArray<ToDoList *> *)object key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object requiringSecureCoding:NO error:nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];

}

- (NSArray<ToDoList *> *)loadCustomObjectWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:encodedObject error:nil];
    [unarchiver setRequiresSecureCoding:NO];
    NSArray<ToDoList *> *object = [unarchiver decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    //[NSKeyedUnarchiver unarchiveObjectWithData:encodedObject]; // Old Way Library.
    return object;
}

@end

