//
//  QuestionsDataViewController.h
//  Questions
//
//  Created by Gemeng Qin on 22/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "keyBoardViewController.h"

@interface QuestionsDataViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,keyBoardDelegate,UIPopoverControllerDelegate,UIGestureRecognizerDelegate>
{
    NSMutableArray * questions; 
    char veryfier;
    id drawer;
    NSInteger componentCount;
    NSString *denominator;
    NSString *numerator;
    NSString *number;
    BOOL isDenominator;
    BOOL  newRound;
    BOOL isDenominatorBlank;
    BOOL isNumeratorBlank;
    BOOL drawCount;
    NSMutableArray * answerBtns;
    NSInteger j;
    NSMutableArray * blanks; 
    NSInteger numOfBlank;
}

- (void)loadQuestions;
- (IBAction)buttonPressed:(id)sender;
- (IBAction)popOut:(id)sender;

@property (strong,nonatomic) IBOutlet UIButton *temp;
@property (strong,nonatomic) keyBoardViewController *keyBoardViewController;
@property (strong, nonatomic) IBOutlet UIButton *btn_active;
@property NSInteger btn_activeIndex;
@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;
@property (strong, nonatomic) NSMutableArray * allQuestions;
@property (strong, nonatomic) UIPopoverController *popKeyboardController;


- (void)titleChanged:(NSString *)Title;

@end
