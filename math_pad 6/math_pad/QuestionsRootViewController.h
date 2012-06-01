//
//  QuestionsRootViewController.h
//  Questions
//
//  Created by Gemeng Qin on 22/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionsRootViewController : UIViewController <UIPageViewControllerDelegate>
{
    NSTimer * timerSec;
    NSTimer * timerMin;
    
}

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) IBOutlet UILabel *lbl_gradeSem;
@property (strong, nonatomic) IBOutlet UILabel *lbl_version;
@property (strong, nonatomic) IBOutlet UILabel *lbl_recommendationTime;
@property (strong, nonatomic) IBOutlet UILabel *lbl_questionSet;
@property (strong, nonatomic) IBOutlet UILabel *lbl_user;
@property (strong, nonatomic) IBOutlet UILabel *lbl_timerMin;
@property (strong, nonatomic) IBOutlet UILabel *lbl_timerSec;
@property (strong, nonatomic) IBOutlet UIButton *btn_start;
@property (strong, nonatomic) IBOutlet UIButton *btn_submit;
- (IBAction)startTimer:(UIButton *)sender;
- (IBAction)endTimer:(UIButton *)sender;
- (void) timerAwake;
@property (strong, nonatomic) IBOutlet UIButton *btn_nextPage;
@property (strong, nonatomic) IBOutlet UIButton *btn_prePage;


@end
