//
//  ViewController.m
//  Math
//
//  Created by zhaoyue on 15/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController
@synthesize questions;

- (void)viewDidLoad
{
    
    [self loadQuestions];
    [self awakeFromNib];

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark-
#pragma tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [questions count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";


    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString * rowContent = [questions objectAtIndex:indexPath.row];
    NSArray * questionComponents = [rowContent componentsSeparatedByString:@"?"];
    CGSize theBlankSize = CGSizeMake(60, 30);
    cell.textLabel.text = [questionComponents objectAtIndex:0];
    cell.textLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    CGSize theFirstHalfSize = [ [questionComponents objectAtIndex:0] sizeWithFont:[UIFont fontWithName:@"Arial" size:24]];
    
    
    //textField
    UITextField *blank = [[UITextField alloc] initWithFrame:CGRectMake(theFirstHalfSize.width+10,7, theBlankSize.width, theBlankSize.height)];
    blank.returnKeyType = UIReturnKeyDone;
    blank.autocapitalizationType = UITextAutocapitalizationTypeWords;
    blank.adjustsFontSizeToFitWidth = TRUE;
    blank.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    blank.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    blank.borderStyle = UITextBorderStyleRoundedRect; 

    [cell.contentView addSubview:blank];
    
    //second half of the question
    if( [questionComponents objectAtIndex:1] )
    {
        UILabel *secHalf =  [[UILabel alloc] initWithFrame: CGRectMake(theFirstHalfSize.width + 20 + theBlankSize.width,0, 300, cell.frame.size.height)];
        secHalf.text = [questionComponents objectAtIndex:1];
        secHalf.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
        
        [cell.contentView addSubview:secHalf];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
// Default is 1 if not implemented

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (UILabel) if you want something different
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;

// Editing

// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;

// Index

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView;                                                    // return list of section titles to display in section index view (e.g. "ABCD...Z#")
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;  // tell table which section corresponds to section title/index (e.g. "B",1))

// Data manipulation - insert and delete support

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

// Data manipulation - reorder / moving support

//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;
#pragma loadingQuestions
- (void)loadQuestions
{
    questions = [[NSMutableArray alloc] init];
    NSString * testString = @"1+2=?";
    NSString * testString2 = @"2*?=4";
    NSString * testString3 = @"1+2*24=?";
    [questions addObject:testString];
    [questions addObject:testString2];
    [questions addObject:testString3];
}

#pragma timer
// awakeTimer
- (void) awakeFromNib {
	// just clear timer outputs 
	[lbl_timerSec setText:@"00"];
    [lbl_timerMin setText:@"0"];
	
	// initialize timer no one to count each second
	timerSec = [NSTimer scheduledTimerWithTimeInterval:1 
												  target:self 
                                           selector:@selector(updateTimerSec: ) 
												userInfo:nil 
												 repeats:YES];
    timerMin = [NSTimer scheduledTimerWithTimeInterval:60 
                                                target:self 
                                              selector:@selector(updateTimerMin: ) 
                                              userInfo:nil 
                                               repeats:YES];

}
//updateTimer
- (void) updateTimerSec:(NSTimer *) timer 
{
    if ( [lbl_timerSec.text intValue] < 59 && [lbl_timerMin.text intValue] < 8 )
    {
        NSInteger tempInt = [lbl_timerSec.text intValue] +1 ;
        lbl_timerSec.text = [NSString stringWithFormat:@"%d",tempInt];
    } else if([lbl_timerMin.text intValue] < 8){
        [lbl_timerSec setText:@"00"];
    } else {
        [lbl_timerSec setText:@"00"];
        [timerSec invalidate];
    }

}

- ( void ) updateTimerMin:(NSTimer *) timer
{
    if ([lbl_timerMin.text intValue] < 7 ) 
    {
        NSInteger tempInt = [lbl_timerSec.text intValue] +1 ;
        lbl_timerMin.text = [NSString stringWithFormat:@"%d",tempInt];
    
    }else {
        lbl_timerMin.text = @"08";
        [timerMin invalidate];
    }
}
    

- (void)viewDidUnload
{
    questions = nil;
    lbl_userName = nil;
    lbl_gradeChosen = nil;
    tb_questions = nil;
    btn_submitAnswers = nil;
    lbl_timerSec = nil;
    lbl_timerMin = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


@end
