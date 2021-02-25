//
//  NoteViewController.h
//  To-Do List
//
//  Created by Mohamed Ali on 2/25/21.
//

#import <UIKit/UIKit.h>
#import "SCAlertPicker.h"

NS_ASSUME_NONNULL_BEGIN

@interface NoteViewController : UIViewController <SCAlertPickerDelegte>

@property (weak, nonatomic) IBOutlet UITextField *NoteTitle;
@property (weak, nonatomic) IBOutlet UITextView *NoteDetails;
@property (weak, nonatomic) IBOutlet UIView *PriorityView;
@property (weak, nonatomic) IBOutlet UILabel *PriorityLabel;
@property (weak, nonatomic) IBOutlet UILabel *DeadLineLabel;

@property UITapGestureRecognizer *tab;
@property (nonatomic, strong) SCAlertPicker *normalAlertPicker;
@property (nonatomic, strong) SCAlertPicker *dateAlertPicker;

- (IBAction)BTNBack:(id)sender;

- (IBAction)BTNSave:(id)sender;




@end

NS_ASSUME_NONNULL_END
