//
//  QuestionsDataViewController.h
//  Questions
//
//  Created by Gemeng Qin on 22/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "keyBoardViewController.h"
@interface QuestionsDataViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPopoverControllerDelegate,keyBoardDelegate>{
    NSMutableArray * questions;
    NSMutableArray * blanks;
    NSMutableArray * answerBtns;
    NSInteger j;

}
- (void)loadQuestions;
- (IBAction)buttonPressed:(id)sender;
- (IBAction)popOut:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;
@property (strong, nonatomic) NSMutableArray * allQuestions;
@property (strong, nonatomic) UIPopoverController *popKeyboardController;

- (void)titleChanged:(NSString *)Title;






@end
