//
//  registerViewController.h
//  Math
//
//  Created by zhaoyue on 15/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface registerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate>
{
    UIButton *Btn_grade;
    NSMutableArray *grades;
}
@property (nonatomic,retain) IBOutlet UIButton *Btn_grade;

- (IBAction)btnGradeClicked:(UIButton *)sender;



@end

