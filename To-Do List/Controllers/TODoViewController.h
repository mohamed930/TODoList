//
//  ViewController.h
//  To-Do List
//
//  Created by Mohamed Ali on 2/25/21.
//

#import <UIKit/UIKit.h>
#import "ToDoList.h"
#import "ToDoProtocol.h"

@interface TODoViewController : UIViewController <UITableViewDataSource,UITableViewDelegate ,ToDoProtocol>

@property (weak, nonatomic) IBOutlet UISearchBar *SearchTextField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray<ToDoList *> *todoArray;

- (IBAction)BTNAdd:(id)sender;


-(void) ReadTODOList;

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

