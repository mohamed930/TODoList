//
//  TODOList Cell.m
//  To-Do List
//
//  Created by Mohamed Ali on 2/25/21.
//

#import "TODOList Cell.h"

@implementation TODOList_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self makecornerCriclewithoutborder:_CellPerioerty];
}


-(void) makecornerCriclewithoutborder:(UIView*) View {
    View.layer.cornerRadius = View.frame.size.width / 2;
    View.clipsToBounds = YES;
    View.layer.backgroundColor = UIColor.clearColor.CGColor;
}

@end
