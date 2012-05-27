//
//  QuestionsDataViewController.h
//  Questions
//
//  Created by Gemeng Qin on 22/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionsDataViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray * questions;
    NSMutableArray * blanks;
    NSMutableArray * answerLabels;
    NSInteger j;
}
- (void)loadQuestions;
- (IBAction)buttonPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;
@property (strong, nonatomic) NSMutableArray * allQuestions;



@end
