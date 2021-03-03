//
//  DoneViewController.h
//  To-Do List
//
//  Created by Mohamed Ali on 3/2/21.
//

#import <UIKit/UIKit.h>
#import "ToDoProtocol.h"
#import "ToDoList.h"

NS_ASSUME_NONNULL_BEGIN

@interface DoneViewController : UIViewController <UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating ,ToDoProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *BTNSort;


@property NSMutableArray<ToDoList *> *todoArray;
@property NSArray<ToDoList *> *FilterTodo;
@property NSMutableArray<ToDoList *> *HighTodo;
@property NSMutableArray<ToDoList *> *MedTodo;
@property NSMutableArray<ToDoList *> *LowTodo;
@property NSMutableArray *Sektion;
@property BOOL isSorted;
@property NSString *id;


- (IBAction)BTNSort:(id)sender;


-(void) ReadTODOList;
-(void) initSearchController;
-(void) UpdateInTable:(NSMutableArray<ToDoList *> *) arr : (ToDoList *) t;


// MARK:- TODO:- These Methods for tableView.
//-------------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//-------------------------

// MARK:- TODO:- These Methods for search bar textField.
// ------------------------
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController;

-(void) filterForSearchTextAndScopeButton:(NSString *) searchText : (NSString *) scopButton;
// ------------------------

// MARK:- TODO:- This Method For Protocol.
-(void) SendNewNote:(ToDoList *) t :(BOOL) EditTage;


@end

NS_ASSUME_NONNULL_END
