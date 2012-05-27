//
//  loginViewController.h
//  math_pad
//
//  Created by zhaoyue on 23/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class registerViewController;
@interface loginViewController : UIViewController<UITextFieldDelegate>
{
    NSString * databaseName;
    NSString * databasePath;
    
}
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *userPassword;
@property (nonatomic, retain) NSMutableArray *question;
@property (nonatomic, retain) NSMutableArray *userdetail;
@property (strong, nonatomic) registerViewController* registerViewController;
@property (nonatomic, retain) NSMutableArray *
anwser;


- (IBAction)userLogin:(id)sender;

- (IBAction)userRegister:(id)sender;

- (void)checkAndCreateDatabase;

- (BOOL)login;  

- (void)shakescreen;



@end
