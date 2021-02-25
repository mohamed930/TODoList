//
//  NoteViewController.m
//  To-Do List
//
//  Created by Mohamed Ali on 2/25/21.
//

#import "NoteViewController.h"
#import <SCAlertPicker.h>

@interface NoteViewController ()



@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ShowPriority:)];
    _tab.numberOfTapsRequired = 1;
    _tab.numberOfTapsRequired = 1;
    [_PriorityLabel setUserInteractionEnabled:YES];
    [_PriorityLabel addGestureRecognizer: _tab];
    
    _tab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ShowDeadLine:)];
    _tab.numberOfTapsRequired = 1;
    _tab.numberOfTapsRequired = 1;
    [_DeadLineLabel setUserInteractionEnabled:YES];
    [_DeadLineLabel addGestureRecognizer: _tab];
    
    [self makecornerCriclewithoutborder:_PriorityView];
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

-(void) ShowDeadLine: (UITapGestureRecognizer *)recognizer {
    self.dateAlertPicker = [[SCAlertPicker alloc] initWithButtonTitle:@"OK" datePickerMode:UIDatePickerModeDateAndTime delegate:self];
    [self.dateAlertPicker show];
}


-(void) makecornerCriclewithoutborder:(UIView*) View {
    View.layer.cornerRadius = View.frame.size.width / 2;
    View.clipsToBounds = YES;
    View.layer.backgroundColor = UIColor.clearColor.CGColor;
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

- (void)SCAlertPicker:(SCAlertPicker *)SCAlertPicker ClickWithDate:(NSDate *)date {
    if (SCAlertPicker == self.dateAlertPicker) {
        NSLog(@"SCAlertPicker::%@", date);
    }
}

@end
