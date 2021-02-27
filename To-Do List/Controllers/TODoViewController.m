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

@end

@implementation TODoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TODOList Cell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    _todoArray = [[NSMutableArray alloc] init];
    // MARK:- TODO:- Read All TODOList.
    [self ReadTODOList];
    
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
    [_tableView reloadData];
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

-(void) SendNewNote:(ToDoList *) t :(BOOL) EditTage {
    
    if (EditTage == NO) {
        [_todoArray addObject: t];
        [_tableView reloadData];
    }
    else {
        for (int i=0;([_todoArray count] -1); i++) {
            if (t.ID == [_todoArray objectAtIndex:i].ID) {
                [_todoArray removeObjectAtIndex:i];
                [_tableView reloadData];
                break;
            }
        }
        [_todoArray addObject: t];
        [_tableView reloadData];
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TODOList_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.CellTitle.text = [_todoArray objectAtIndex:indexPath.row].name;
    cell.CellDate.text  = [_todoArray objectAtIndex:indexPath.row].DateCreation;
    
    if ([[_todoArray objectAtIndex:indexPath.row].priority isEqualToString:@"High"]) {
        cell.CellPerioerty.backgroundColor = UIColor.redColor;
    }
    else if ([[_todoArray objectAtIndex:indexPath.row].priority isEqualToString:@"Mid"]) {
        cell.CellPerioerty.backgroundColor = UIColor.orangeColor;
    }
    else {
        cell.CellPerioerty.backgroundColor = UIColor.greenColor;
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _todoArray.count;
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
    next.onece = [_todoArray objectAtIndex:indexPath.row];
    
    [self presentViewController:next animated:YES completion:nil];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 87.0;
}


@end
