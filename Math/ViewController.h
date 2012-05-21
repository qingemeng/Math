//
//  ViewController.h
//  Math
//
//  Created by zhaoyue on 15/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UILabel *lbl_userName;
    IBOutlet UILabel *lbl_gradeChosen;
    IBOutlet UITableView *tb_questions;
    IBOutlet UIButton *btn_submitAnswers;
    NSTimer * timerSec;
    NSTimer * timerMin;
    IBOutlet UILabel *lbl_timerSec;    
    IBOutlet UILabel *lbl_timerMin;
    NSMutableArray * questions;
}
@property ( retain , nonatomic ) NSMutableArray * questions;

@end


