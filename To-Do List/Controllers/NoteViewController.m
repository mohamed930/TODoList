//
//  NoteViewController.m
//  To-Do List
//
//  Created by Mohamed Ali on 2/25/21.
//

#import "NoteViewController.h"
#import <SCAlertPicker.h>
#import <UIAlertDateTimePicker.h>

@interface NoteViewController ()

@property NSString *PickState;

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makecornerCriclewithoutborder:_PriorityView];
    
    _tab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ShowPriority:)];
    _tab.numberOfTapsRequired = 1;
    _tab.numberOfTapsRequired = 1;
    [_PriorityLabel setUserInteractionEnabled:YES];
    [_PriorityLabel addGestureRecognizer: _tab];
    
    _datePicker = [[UIDatePicker alloc] init];
    _datePicker.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
    
    _arr = [NSMutableArray new];
    [_arr addObject:@"To-Do"];
    [_arr addObject:@"In progress"];
    [_arr addObject:@"Completed"];
}


- (IBAction)BTNSave:(id)sender {
    
}

- (IBAction)BTNBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
