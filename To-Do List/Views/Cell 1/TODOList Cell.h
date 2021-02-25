//
//  TODOList Cell.h
//  To-Do List
//
//  Created by Mohamed Ali on 2/25/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TODOList_Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *CellTitle;

@property (weak, nonatomic) IBOutlet UILabel *CellDate;

@property (weak, nonatomic) IBOutlet UIView *CellPerioerty;

-(void) makecornerCriclewithoutborder:(UIView*) View;


@end

NS_ASSUME_NONNULL_END
