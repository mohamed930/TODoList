//
//  ViewController.m
//  To-Do List
//
//  Created by Mohamed Ali on 2/25/21.
//

#import "TODoViewController.h"
#import "TODOList Cell.h"
#import "ToDoList.h"
#import "NoteViewController.h"

@interface TODoViewController ()

@property UISearchController *searchController;

@end

@implementation TODoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isSorted = NO;
    
    [_tableView registerNib:[UINib nibWithNibName:@"TODOList Cell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    _todoArray = [[NSMutableArray alloc] init];
    // MARK:- TODO:- Read All TODOList.
    [self ReadTODOList];
    [self initSearchController];
    
}


-(void) initSearchController {
    
    _searchController = [UISearchController new];
    
    [_searchController loadViewIfNeeded];
    _searchController.searchResultsUpdater = self;
    _searchController.obscuresBackgroundDuringPresentation = NO;
    _searchController.searchBar.enablesReturnKeyAutomatically = NO;
    _searchController.searchBar.returnKeyType = UIReturnKeyDone;
    [self setDefinesPresentationContext:YES];
    
    self.navigationItem.searchController = _searchController;
    self.navigationItem.hidesSearchBarWhenScrolling = false;
    
    NSMutableArray *buttonsName = [NSMutableArray new];
    [buttonsName addObject:@"All"];
    [buttonsName addObject:@"High"];
    [buttonsName addObject:@"Mid"];
    [buttonsName addObject:@"Low"];
    
    _searchController.searchBar.scopeButtonTitles = buttonsName;
    _searchController.searchBar.delegate = self;
}


-(void) ReadTODOList {
    
    ToDoList *t = [ToDoList new];
    NSUUID *id1 = [NSUUID new];
    t.ID = [id1 UUIDString];
    t.name = @"Eat";
    t.DateCreation = @"2020-05-10";
    t.priority = @"High";
    t.state = @"In progress";
    [_todoArray addObject: t];
    
    t = [ToDoList new];
    id1 = [NSUUID new];
    t.ID = [id1 UUIDString];
    t.name = @"Spa";
    t.DateCreation = @"2020-05-10";
    t.priority = @"Mid";
    t.state = @"In progress";
    [_todoArray addObject: t];
    
    t = [ToDoList new];
    id1 = [NSUUID new];
    t.ID = [id1 UUIDString];
    t.name = @"Sleep";
    t.DateCreation = @"2020-05-10";
    t.priority = @"Low";
    t.state = @"Completed";
    [_todoArray addObject: t];
    //[_tableView reloadData];
}

- (IBAction)BTNSort:(id)sender {
    
    if (_isSorted == YES) {
        _isSorted = NO;
        [_tableView reloadData];
        
        [_BTNSort setImage:[UIImage imageNamed:@"icons_0608-32-512-2"]];
    }
    else {
        _isSorted = YES;
        _HighTodo = [NSMutableArray new];
        _MedTodo  = [NSMutableArray new];
        _LowTodo  = [NSMutableArray new];
        
        _Sektion = [NSMutableArray new];
        [_Sektion addObject:@"High"];
        [_Sektion addObject:@"Mid"];
        [_Sektion addObject:@"Low"];
        
        for (int i=0;i<(_todoArray.count);i++) {
            if ([[_todoArray objectAtIndex:i].priority isEqualToString:@"High"]) {
                [_HighTodo addObject: [_todoArray objectAtIndex:i]];
            }
            else if ([[_todoArray objectAtIndex:i].priority isEqualToString:@"Mid"]) {
                [_MedTodo addObject: [_todoArray objectAtIndex:i]];
            }
            else if ([[_todoArray objectAtIndex:i].priority isEqualToString:@"Low"]) {
                [_LowTodo addObject: [_todoArray objectAtIndex:i]];
            }
        }
        [_tableView reloadData];
        
        [_BTNSort setImage:[UIImage imageNamed:@"icons_0608-32-515"]];
    }
}

- (IBAction)BTNAdd:(id)sender {
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NoteViewController *next = [story instantiateViewControllerWithIdentifier:@"NotesDetails"];
    next.modalPresentationStyle = UIModalPresentationFullScreen;
    
    next.delegate = self;
    [next setIsEdit:NO];
    
    [self presentViewController:next animated:YES completion:nil];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

// MARK:- TODO:- Protocol Delegate.
// -------------------------
-(void) SendNewNote:(ToDoList *) t :(BOOL) EditTage {
    
    if (EditTage == NO) {
        
        if (_isSorted == YES) {
            
            if ([t.priority isEqualToString:@"High"]) {
                [_HighTodo addObject: t];
                [_tableView reloadData];
            }
            else if ([t.priority isEqualToString:@"Mid"]) {
                [_MedTodo addObject: t];
                [_tableView reloadData];
            }
            else {
                [_LowTodo addObject: t];
                [_tableView reloadData];
            }
            
        }
        else {
            [_todoArray addObject: t];
            [_tableView reloadData];
        }
        
    }
    else {
        
        if (_isSorted == YES) {
            
            if ([t.priority isEqualToString:@"High"]) {
                [self UpdateInTable:_HighTodo :t];
            }
            else if ([t.priority isEqualToString:@"Mid"]) {
                [self UpdateInTable:_MedTodo :t];
            }
            else {
                [self UpdateInTable:_LowTodo :t];
            }
            
        }
        else {
            [self UpdateInTable:_todoArray :t];
        }
    }
}

-(void) UpdateInTable:(NSMutableArray<ToDoList *> *) arr : (ToDoList *) t {
    
    for (int i=0;i<([arr count]); i++) {
        if (t.ID == [arr objectAtIndex:i].ID) {
            [arr removeObjectAtIndex:i];
            [_tableView reloadData];
            break;
        }
    }
    [arr addObject: t];
    [_tableView reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_isSorted == YES) {
        return 3;
    }
    else {
        return 1;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_isSorted == YES) {
        return [_Sektion objectAtIndex:section];
    }
    return NULL;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TODOList_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    ToDoList *list = [ToDoList new];
    
    if (_searchController.isActive) {
        list = [_FilterTodo objectAtIndex:indexPath.row];
        
        if ([list.priority isEqualToString:@"High"]) {
            cell.CellPerioerty.backgroundColor = UIColor.redColor;
        }
        else if ([list.priority isEqualToString:@"Mid"]) {
            cell.CellPerioerty.backgroundColor = UIColor.orangeColor;
        }
        else {
            cell.CellPerioerty.backgroundColor = UIColor.greenColor;
        }
        
    }
    else {
        
        if (_isSorted == YES) {
            
            if (indexPath.section == 0) {
                list = [_HighTodo objectAtIndex:indexPath.row];
                cell.CellPerioerty.backgroundColor = UIColor.redColor;
            }
            else if (indexPath.section == 1) {
                list = [_MedTodo objectAtIndex:indexPath.row];
                cell.CellPerioerty.backgroundColor = UIColor.orangeColor;
            }
            else {
                list = [_LowTodo objectAtIndex:indexPath.row];
                cell.CellPerioerty.backgroundColor = UIColor.greenColor;
            }
            
        }
        else {
            list = [_todoArray objectAtIndex:indexPath.row];
            
            if ([list.priority isEqualToString:@"High"]) {
                cell.CellPerioerty.backgroundColor = UIColor.redColor;
            }
            else if ([list.priority isEqualToString:@"Mid"]) {
                cell.CellPerioerty.backgroundColor = UIColor.orangeColor;
            }
            else {
                cell.CellPerioerty.backgroundColor = UIColor.greenColor;
            }
        }
        
    }
    
    cell.CellTitle.text = list.name;
    cell.CellDate.text  = list.DateCreation;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_isSorted == YES) {
        
        if (section == 0) {
            return _HighTodo.count;
        }
        else if (section == 1) {
            return _MedTodo.count;
        }
        else {
            return _LowTodo.count;
        }
    }
    else {
        if (_searchController.isActive) {
            return _FilterTodo.count;
        }
        
        return _todoArray.count;
    }
    return 0;
}



-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NoteViewController *next = [story instantiateViewControllerWithIdentifier:@"NotesDetails"];
    next.modalPresentationStyle = UIModalPresentationFullScreen;
    
    next.delegate = self;
    [next setIsEdit:YES];
    next.onece = [ToDoList new];
    
    if(_searchController.isActive) {
        next.onece = [_FilterTodo objectAtIndex:indexPath.row];
    }
    else {
        
        if (_isSorted == YES) {
            if (indexPath.section == 0) {
                next.onece = [_HighTodo objectAtIndex:indexPath.row];
            }
            else if (indexPath.section == 1) {
                next.onece = [_MedTodo objectAtIndex:indexPath.row];
            }
            else {
                next.onece = [_LowTodo objectAtIndex:indexPath.row];
            }
        }
        else {
            next.onece = [_todoArray objectAtIndex:indexPath.row];
        }
        
    }
    
    [self presentViewController:next animated:YES completion:nil];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95.0;
}

-(void) updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    _isSorted = NO;
    [_tableView reloadData];

    UISearchBar *s = _searchController.searchBar;
    NSString *scopButton = [s.scopeButtonTitles objectAtIndex: s.selectedScopeButtonIndex];
    NSString *searchText = s.text;
    
    [self filterForSearchTextAndScopeButton:searchText :scopButton];
}

-(void) filterForSearchTextAndScopeButton:(NSString *) searchText : (NSString *) scopButton {
    _FilterTodo = [NSMutableArray new];
    
    if ([_searchController.searchBar.text isEqualToString:@""]) {
        
        if ([scopButton isEqualToString:@"All"]) {
            _FilterTodo = _todoArray;
            
            [_tableView reloadData];
        }
        else {
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"(priority like %@)", scopButton];
            
            _FilterTodo = [_todoArray filteredArrayUsingPredicate: pred];
            
            [_tableView reloadData];
        }
    }
    else {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(name like %@)", searchText];
        
        _FilterTodo = [_todoArray filteredArrayUsingPredicate: pred];
        
        [_tableView reloadData];
    }
}

@end
