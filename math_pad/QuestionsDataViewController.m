//
//  QuestionsDataViewController.m
//  Questions
//
//  Created by Gemeng Qin on 22/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuestionsDataViewController.h"
#import "keyBoardViewController.h"

@interface QuestionsDataViewController ()
@property (strong,nonatomic) IBOutlet UIButton *temp;
@property (strong,nonatomic) keyBoardViewController *keyBoardViewController;
@property (strong, nonatomic) IBOutlet UIButton *btn_active;
@property NSInteger btn_activeIndex;
@end

@implementation QuestionsDataViewController

@synthesize dataLabel = _dataLabel;
@synthesize dataObject = _dataObject;
@synthesize allQuestions = _allQuestions;
@synthesize temp;
@synthesize keyBoardViewController= _keyBoardViewController;
@synthesize popKeyboardController = _popKeyBoardController;
@synthesize btn_active;
@synthesize btn_activeIndex;


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self loadQuestions];
    blanks = [[NSMutableArray alloc] init];
    answerBtns =[[NSMutableArray alloc] init];
    j=0;

	// Do any additional setup after loading the view, typically from a nib.
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.dataLabel = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

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
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString * rowContent = [questions objectAtIndex:indexPath.row];
    NSArray * questionComponents = [rowContent componentsSeparatedByString:@"?"];
    
    
    //NSLog(@"%@",[rowContent componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString: @"\n\t "]]);
    
    CGSize theBlankSize = CGSizeMake(tableView.rowHeight/2, tableView.rowHeight/3);
    cell.textLabel.text = [questionComponents objectAtIndex:0];
    cell.textLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:30];
    CGSize theFirstHalfSize = [ [questionComponents objectAtIndex:0] sizeWithFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:30]];
    
    //second half of the question
    NSInteger basePointX = theFirstHalfSize.width;
    NSInteger i = 1;
    NSInteger numOfBlank = questionComponents.count-1;
    CGSize answerLabelSize=CGSizeMake(200, tableView.rowHeight/3-10);
    CGPoint answerLabelOriginPoint = CGPointMake(400, (tableView.rowHeight/numOfBlank-answerLabelSize.height)/2);

    while( i < questionComponents.count && [questionComponents objectAtIndex:i]!=@"" )
    {
        //add button
        UIButton *blank = [[UIButton alloc] initWithFrame:CGRectMake(basePointX+10,(tableView.rowHeight- theBlankSize.height)/2, theBlankSize.width, theBlankSize.height)];
        //NSLog(@"blank origin point %f",cell.frame.size.height);
        cell.backgroundColor =[UIColor redColor];
        //blank.returnKeyType = UIReturnKeyDone;
        //blank.autocapitalizationType = UITextAutocapitalizationTypeWords;
        //blank.adjustsFontSizeToFitWidth = TRUE;
        //blank.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
        blank.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        blank.backgroundColor =[UIColor blueColor]; 
        [blanks addObject:blank];
        //NSLog(@"blanks %d",blanks.count);


        [cell.contentView addSubview:blank];
        
        //add another component
        UILabel *nextComponent =  [[UILabel alloc] initWithFrame: CGRectMake(basePointX + 20 + theBlankSize.width,0, [ [questionComponents objectAtIndex:i] sizeWithFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:30]].width , tableView.rowHeight)];
        nextComponent.text = [questionComponents objectAtIndex:1];
        nextComponent.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:30];
        
        [cell.contentView addSubview:nextComponent];
        
        
        basePointX =10+ basePointX + theBlankSize.width + [ [questionComponents objectAtIndex:i] sizeWithFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:30]].width ;
        
        //add answer button
        UIButton *btn_eachAnswer = [[UIButton alloc] initWithFrame:CGRectMake(answerLabelOriginPoint.x, answerLabelOriginPoint.y, answerLabelSize.width, answerLabelSize.height)];
        btn_eachAnswer.backgroundColor =[UIColor whiteColor];
        [btn_eachAnswer addTarget:self action:@selector(popOut:) forControlEvents:UIControlEventTouchUpInside];
       // NSLog(@"bottons %@",btn_eachAnswer);
        [answerBtns addObject:btn_eachAnswer ];
        //lbl_eachAnswerTextfield.borderStyle = UITextBorderStyleRoundedRect;
        //tf_eachAnswerTextfield.keyboardType = UIKeyboardTypeNumberPad;
        //NSLog(@"labels %d" , answerLabels.count);


        [cell.contentView addSubview:btn_eachAnswer];

        
        //update
        answerLabelOriginPoint.y += (tableView.rowHeight/numOfBlank)*i;
        
        i++;

    }
    //NSLog(@"blanks %d",blanks.count);
    //NSLog(@"labels %d" , answerLabels.count);
    temp = [answerBtns objectAtIndex:0];
    
    //add action
    while (j<blanks.count) {
        [[blanks objectAtIndex:j] addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        //[[answerBtns objectAtIndex:j]addTarget:self action:@selector(popOut:) forControlEvents:UIControlEventTouchUpInside];
        
        j++;
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma loadingQuestions
- (void) loadQuestions
{
    questions = _allQuestions;
    
}

- (IBAction)buttonPressed:(UIButton *)sender 

{
    temp.backgroundColor = [UIColor whiteColor];
    temp=[answerBtns objectAtIndex:[blanks indexOfObject:sender]];
    temp.backgroundColor = [UIColor redColor];
    //NSLog(@"pressed");
    
}

- (IBAction)popOut:(UIButton *)sender
{
    NSLog(@"call already");

    //create the view controller from nib
	//_keyBoardViewController = [[keyBoardViewController alloc] init];
        _keyBoardViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"keyBoardViewController"];
    
    //[self.keyBoardViewController
	
    
	//set popover content size
	self.keyBoardViewController.contentSizeForViewInPopover = //CGSizeMake(400, 400);
    CGSizeMake(self.keyBoardViewController.view.frame.size.width, self.keyBoardViewController.view.frame.size.height);
    
	
	//set delegate 
	self.popKeyboardController.delegate = self;
    self.keyBoardViewController.delegate =self;
    
	
	//create a popover controller
	_popKeyBoardController = [[UIPopoverController alloc] initWithContentViewController:self.keyBoardViewController];
	
    
	//present the popover view non-modal with a
	//refrence to the button pressed within the current view
    //NSLog(@"sender  %@ width %f height %f" , sender, sender.frame.size.width,sender.frame.size.height );
    //NSLog(@"sender.s.s.s %@",sender.superview.superview.superview.superview);
	[self.popKeyboardController presentPopoverFromRect:[sender.superview convertRect:sender.frame toView:sender.superview.superview.superview.superview] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    btn_active = sender;
    btn_activeIndex = [answerBtns indexOfObject:sender];
    

    
}

//implementing keyboardProtocol
- (void)titleChanged:(NSString *)Title
{
    [btn_active setTitle:Title forState:(UIControlStateNormal)] ;
    btn_active.titleLabel.textColor = [UIColor blackColor];
    [[blanks objectAtIndex:btn_activeIndex] setTitle:Title forState:(UIControlStateNormal)];
    
    
}


@end
