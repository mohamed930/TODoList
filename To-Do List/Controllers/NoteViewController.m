//
//  NoteViewController.m
//  To-Do List
//
//  Created by Mohamed Ali on 2/25/21.
//

#import "NoteViewController.h"
#import <SCAlertPicker.h>
#import <UIAlertDateTimePicker.h>
#import "ToDoList.h"

@interface NoteViewController ()

@property NSString *PickState;

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _screenedge = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(Back:)];
    [_screenedge setEdges:UIRectEdgeLeft];
    [_screenedge setDelegate:self];
    [self.view addGestureRecognizer: _screenedge];
    
    _arr = [NSMutableArray new];
    _datePicker = [[UIDatePicker alloc] init];
    
    if (_isEdit == NO) {
        [_NoteTitle setEnabled:YES];
        [_PriorityLabel setEnabled:YES];
        [_DeadLineLabel setEnabled:YES];
        [_NoteDetails setEditable:YES];
        [_SaveButton setTitle:@"Save" forState:UIControlStateNormal];
        [_PriorityLabel setUserInteractionEnabled:YES];
        [_StatePickerView setHidden:YES];
        [self makecornerCriclewithoutborder:_PriorityView];
    }
    else {
        [_NoteTitle setEnabled:NO];
        _NoteTitle.text = _onece.name;
        _PriorityLabel.text = _onece.priority;
        [_DeadLineLabel setEnabled:NO];
        _DeadLineLabel.text = _onece.DeadLineData;
        [_NoteDetails setEditable:NO];
        _NoteDetails.text = _onece.desc;
        [_SaveButton setTitle:@"Edit" forState:UIControlStateNormal];
        [_PriorityLabel setUserInteractionEnabled:NO];
        [_StatePickerView setUserInteractionEnabled:NO];
        [_PickStateLabel setHidden:NO];
        
        if ([_PriorityLabel.text isEqualToString:@"High"]) {
            [self makecornerCriclewithoutborder:_PriorityView];
            _PriorityView.backgroundColor = UIColor.redColor;
        }
        else if ([_PriorityLabel.text isEqualToString:@"Mid"]) {
            [self makecornerCriclewithoutborder:_PriorityView];
            _PriorityView.backgroundColor = UIColor.orangeColor;
        }
        else {
            [self makecornerCriclewithoutborder:_PriorityView];
            _PriorityView.backgroundColor = UIColor.greenColor;
        }
        
        if ([_onece.state isEqualToString:@"To-Do"]) {
            [_arr addObject:@"To-Do"];
            [_arr addObject:@"In progress"];
            [_arr addObject:@"Completed"];
            [_StatePickerView selectRow:0 inComponent:0 animated:YES];
        }
        else if ([_onece.state isEqualToString:@"In progress"]) {
            [_arr addObject:@"In progress"];
            [_arr addObject:@"Completed"];
            [_StatePickerView selectRow:0 inComponent:0 animated:YES];
        }
        else {
            [_arr addObject:@"Completed"];
            [_StatePickerView selectRow:0 inComponent:0 animated:YES];
        }
        
    }
    
    _tab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ShowPriority:)];
    _tab.numberOfTapsRequired = 1;
    _tab.numberOfTapsRequired = 1;
    
    [_PriorityLabel addGestureRecognizer: _tab];
    
    _datePicker.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
}


- (IBAction)BTNSave:(id)sender {
    
    if (_isEdit == NO) {
        [self SaveNote];
    }
    else {
        [self UpdateNote];
    }
    
}

- (IBAction)BTNBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) SaveNote {
    
    ToDoList *list = [ToDoList new];
    NSUUID *id1 = [NSUUID new];
    list.ID = [id1 UUIDString];
    list.name = _NoteTitle.text;
    list.priority = _PriorityLabel.text;
    list.DeadLineData = _DeadLineLabel.text;
    list.state = @"To-Do";
    list.desc = _NoteDetails.text;
  
    NSDate *date = [NSDate new];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"dd/MM/yyy hh:mm a";
    formatter.AMSymbol = @"am";
    formatter.PMSymbol = @"pm";
    NSString *result = [formatter stringFromDate: date];
    
    list.DateCreation = result;
    
    
 //   NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//    [def setValue:list.ID forKey:@"NoteID"];
//    [def setValue:list.name forKey:@"NoteName"];
//    [def setValue:list.priority forKey:@"NotePriority"];
//    [def setValue:list.DeadLineData forKey:@"NoteDeadLine"];
//    [def setValue:list.state forKey:@"NoteState"];
//    [def setValue:list.DateCreation forKey:@"NoteDateCreation"];
  //  NSData *res = [NSKeyedArchiver archivedDataWithRootObject:arr requiringSecureCoding:YES error:nil];
  //  [def setObject:res forKey:@"NewNote"];
    
 //   [def synchronize];
    //[[NSUserDefaults standardUserDefaults] setObject:NoteData forKey:@"NewNote"];
    
    
    
    [_delegate SendNewNote: list:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void) UpdateNote {
    
    if (_NoteTitle.isEnabled == NO) {
        [_NoteTitle setEnabled:YES];
        [_PriorityLabel setEnabled:YES];
        [_DeadLineLabel setEnabled:YES];
        [_NoteDetails setEditable:YES];
        [_PriorityLabel setUserInteractionEnabled:YES];
        [_StatePickerView setUserInteractionEnabled:YES];
    }
    else {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Confrimation" message:@"Are you sure to Edit?" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            printf("Edited is done\n");
            
            ToDoList *list = [ToDoList new];
            list.ID = self->_onece.ID;
            list.name = self->_NoteTitle.text;
            list.priority = self->_PriorityLabel.text;
            list.DeadLineData = self->_DeadLineLabel.text;
            list.state = self->_PickState;
            list.desc = self->_NoteDetails.text;
            list.DateCreation = self->_onece.DateCreation;
            
            [self->_delegate SendNewNote:list :YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

-(void) ShowPriority: (UITapGestureRecognizer *)recognizer {
    self.normalAlertPicker = [[SCAlertPicker alloc] initWithButtonTitle:@"OK" pickerData:[self getTestData] pickerIndex:@[@0] delegate:self];

    [self.normalAlertPicker show];
}

-(void) ShowDeadLine {
    printf("Date is Show\n");
    
    UIToolbar *toolbar = [UIToolbar new];
    [toolbar sizeToFit];


    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:@selector(DonePressed)];
    
    NSMutableArray<UIBarButtonItem *> *btns = [NSMutableArray new];
    [btns addObject:btn];
    
    [toolbar setItems:btns animated:YES];
    
    _DeadLineLabel.inputAccessoryView = toolbar;
    _DeadLineLabel.inputView = _datePicker;
    
}

-(void) DonePressed {
    
    NSDateFormatter *dateFromStringFormatter = [NSDateFormatter new];
    dateFromStringFormatter.dateFormat = @"dd/MM/yyy hh:mm a";
    dateFromStringFormatter.AMSymbol = @"am";
    dateFromStringFormatter.PMSymbol = @"pm";
    NSString *dateFromString = [dateFromStringFormatter stringFromDate:_datePicker.date];
    
    _DeadLineLabel.text = dateFromString;
    
    [self.view endEditing:YES];
}

-(void) makecornerCriclewithoutborder:(UIView*) View {
    View.layer.cornerRadius = View.frame.size.width / 2;
    View.clipsToBounds = YES;
    View.layer.backgroundColor = UIColor.grayColor.CGColor;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(void) Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma - Generate Test Data

- (NSArray *)getTestData {
    NSMutableArray *testData = [[NSMutableArray alloc] init];
    [testData addObject:@[@"High", @"Mid", @"Low"]];
    return [testData copy];
}

#pragma - SCAlertPicker Delegate

- (void)SCAlertPicker:(SCAlertPicker *)SCAlertPicker ClickWithValues:(NSArray *)values {
    if (SCAlertPicker == self.normalAlertPicker) {
        _PriorityLabel.text = values[0];
        
        if ([values[0] isEqualToString:@"High"]) {
            _PriorityView.backgroundColor = UIColor.redColor;
        }
        else if ([values[0] isEqualToString:@"Mid"]) {
            _PriorityView.backgroundColor = UIColor.orangeColor;
        }
        else {
            _PriorityView.backgroundColor = UIColor.greenColor;
        }
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == _DeadLineLabel) {
        [self ShowDeadLine];
    }
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _arr.count;
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_arr objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _PickState = [_arr objectAtIndex:row];
    printf("%s\n",[_PickState UTF8String]);
}


@end
