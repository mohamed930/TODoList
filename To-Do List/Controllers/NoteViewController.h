//
//  NoteViewController.h
//  To-Do List
//
//  Created by Mohamed Ali on 2/25/21.
//

#import <UIKit/UIKit.h>
#import "SCAlertPicker.h"

NS_ASSUME_NONNULL_BEGIN

@interface NoteViewController : UIViewController <SCAlertPickerDelegte , UITextFieldDelegate , UIPickerViewDelegate , UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *NoteTitle;
@property (weak, nonatomic) IBOutlet UITextView *NoteDetails;
@property (weak, nonatomic) IBOutlet UIView *PriorityView;
@property (weak, nonatomic) IBOutlet UILabel *PriorityLabel;
@property (weak, nonatomic) IBOutlet UITextField *DeadLineLabel;

@property UITapGestureRecognizer *tab;
@property (nonatomic, strong) SCAlertPicker *normalAlertPicker;

@property UIDatePicker *datePicker;
@property NSMutableArray *arr;

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
