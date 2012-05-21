//
//  loginViewController.h
//  Math
//
//  Created by zhaoyue on 15/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;
@class registerViewController;

@interface loginViewController : UIViewController<UITextFieldDelegate>
{
    NSString * databaseName;
    NSString * databasePath;
  
}
@property (strong, retain) IBOutlet UITextField *userName;
@property (strong, retain) IBOutlet UITextField *userPassword;
@property (strong, nonatomic) ViewController* ViewController;
@property (strong, nonatomic) registerViewController* registerViewController;
@property (nonatomic, retain) NSMutableArray *question;
@property (nonatomic, retain) NSMutableArray *userdetail;
@property (nonatomic, retain) NSMutableArray *
anwser;
- (IBAction)userLogin:(id)sender;

- (IBAction)userRegister:(id)sender;

- (void)checkAndCreateDatabase;

- (void)shakescreen;

- (BOOL)login;  

@end
