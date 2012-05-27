//
//  QuestionsDataViewController.m
//  Questions
//
//  Created by Gemeng Qin on 22/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuestionsDataViewController.h"

@interface QuestionsDataViewController ()
@property (strong,nonatomic) IBOutlet UILabel *lbl;
@end

@implementation QuestionsDataViewController

@synthesize dataLabel = _dataLabel;
@synthesize dataObject = _dataObject;
@synthesize allQuestions = _allQuestions;
@synthesize lbl;




- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self loadQuestions];
    blanks = [[NSMutableArray alloc] init];
    answerLabels =[[NSMutableArray alloc] init];
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
        
        //add answerLabels
        UILabel *lbl_eachAnswerLabel = [[UILabel alloc] initWithFrame:CGRectMake(answerLabelOriginPoint.x, answerLabelOriginPoint.y, answerLabelSize.width, answerLabelSize.height)];
        [answerLabels addObject:lbl_eachAnswerLabel];
        //NSLog(@"labels %d" , answerLabels.count);


        [cell.contentView addSubview:lbl_eachAnswerLabel];

        
        //update
        answerLabelOriginPoint.y += (tableView.rowHeight/numOfBlank)*i;
        
        i++;

    }
    //NSLog(@"blanks %d",blanks.count);
    //NSLog(@"labels %d" , answerLabels.count);
    lbl = [answerLabels objectAtIndex:0];
    
    //add action
    while (j<blanks.count) {
        [[blanks objectAtIndex:j] addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
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
    lbl.backgroundColor = [UIColor whiteColor];
    lbl=[answerLabels objectAtIndex:[blanks indexOfObject:sender]];
    lbl.backgroundColor = [UIColor redColor];
    //NSLog(@"pressed");
    
}



@end
