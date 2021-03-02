//
//  NoteViewController.h
//  To-Do List
//
//  Created by Mohamed Ali on 2/25/21.
//

#import <UIKit/UIKit.h>
#import "SCAlertPicker.h"
#import "ToDoProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NoteViewController : UIViewController <SCAlertPickerDelegte, UIGestureRecognizerDelegate , UITextFieldDelegate , UIPickerViewDelegate , UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *NoteTitle;
@property (weak, nonatomic) IBOutlet UITextView *NoteDetails;
@property (weak, nonatomic) IBOutlet UIView *PriorityView;
@property (weak, nonatomic) IBOutlet UILabel *PriorityLabel;
@property (weak, nonatomic) IBOutlet UITextField *DeadLineLabel;
@property (weak, nonatomic) IBOutlet UIButton *SaveButton;
@property (weak, nonatomic) IBOutlet UIPickerView *StatePickerView;
@property (weak, nonatomic) IBOutlet UILabel *PickStateLabel;


@property UITapGestureRecognizer *tab;
@property (nonatomic, strong) SCAlertPicker *normalAlertPicker;

@property UIDatePicker *datePicker;
@property NSMutableArray *arr;
@property id<ToDoProtocol> delegate;
@property BOOL isEdit;
@property ToDoList *onece;
@property UIScreenEdgePanGestureRecognizer *screenedge;

-(void) makecornerCriclewithoutborder:(UIView*) View;

- (IBAction)BTNBack:(id)sender;

- (IBAction)BTNSave:(id)sender;

-(void) ShowPriority: (UITapGestureRecognizer *)recognizer;

-(void) ShowDeadLine;

-(void) DonePressed;

- (NSArray *)getTestData;

- (void)SCAlertPicker:(SCAlertPicker *)SCAlertPicker ClickWithValues:(NSArray *)values;

-(void)textFieldDidBeginEditing:(UITextField *)textField;

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end

NS_ASSUME_NONNULL_END
