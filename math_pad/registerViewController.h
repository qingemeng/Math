//
//  registerViewController.h
//  math_pad
//
//  Created by zhaoyue on 23/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface registerViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate>

{
    UIButton *Btn_grade;
    NSMutableArray *grades;
    NSString *databaseName;
    NSString *databasePath;
    NSString * userGrade;
    NSString * userRegisterName;
    NSString * userRegisterPassword;
    NSString * userRegisterPasswordConfirm;
    
}

@property (nonatomic,retain) IBOutlet UIButton *Btn_grade;
@property (nonatomic,retain) IBOutlet UITextField*
userName;
@property (nonatomic, retain) IBOutlet UITextField*
userPassword;
@property (nonatomic, retain) IBOutlet UITextField*
userPasswordConfirm;

- (IBAction)btnGradeClicked:(UIButton *)sender;
- (IBAction)submit:(UIButton*)sender;
- (void) registerCheck;
@end
