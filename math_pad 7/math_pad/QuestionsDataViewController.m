//
//  QuestionsDataViewController.m
//  Questions
//
//  Created by Gemeng Qin on 22/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuestionsDataViewController.h"
#import "PageAppAppDelegate.h"
#import "keyBoardViewController.h"
@interface QuestionsDataViewController ()

@end

@implementation QuestionsDataViewController
@synthesize dataLabel = _dataLabel;
@synthesize dataObject = _dataObject;
@synthesize allQuestions = _allQuestions;
@synthesize temp;
@synthesize keyBoardViewController=_keyBoardViewController;
@synthesize popKeyboardController = _popKeyBoardController;
@synthesize btn_active;
@synthesize btn_activeIndex;


- (void)viewDidLoad
{
    isDenominator = NO;
    newRound = NO;
    [super viewDidLoad];
    [self loadQuestions];
    blanks = [[NSMutableArray alloc] init];
    answerBtns =[[NSMutableArray alloc] init];
   
  
    
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
    
    // Seperate and create the cell componnet 
    NSString * rowContent = [questions objectAtIndex:indexPath.row];
    NSArray * questionComponents = [rowContent componentsSeparatedByString:@"?"];

    
    // Define the BlankSize, this row of code is used for format modification
    theBlankSize = CGSizeMake(tableView.rowHeight/2, tableView.rowHeight/3);
    
    // defining up the base point
    
     basePointX = 20;
    
       
    // analyze the row content
    NSInteger count = 0;
    NSLog(@"---------------");
    componentCount = 0;
    

    //The remaining part of the question will be create inside of the while loop
   
    NSInteger i = 0;
    
    // define the number of blank
     numOfBlank = questionComponents.count-1;
    
    while((i < questionComponents.count && ([[questionComponents objectAtIndex:i] isEqualToString:@""]==NO))||i==0)
    {
        
        //adjusting basepoint width 
        NSString* data = [questionComponents objectAtIndex:i];
        basePointX =basePointX+5;
        
         // initialize the next component seperated by the ? mark
        componentCount = 0;
        count = 0;
        
        if(([[questionComponents objectAtIndex:i] isEqualToString:@""]==NO))
        {
            
        veryfier =[data characterAtIndex:count];
        NSLog(@"Testing");
        NSString *compare=[NSString stringWithFormat:@"%c",veryfier];
       if([compare isEqualToString:@"/"]==NO&& isDenominatorBlank ==NO&&i!=0)
       {
        
        //add button if the first object in the array is not empty, which means 
        UIButton* blank = [self drawButton:numerator yPosition:0 theCell:cell theTable:tableView];
        [cell.contentView addSubview:blank];
        basePointX = basePointX + blank.frame.size.width -20 ;

       }         
      
        }
        // carry out the iteration
        
        while(count<[data length])
        {
            
            
            veryfier =[data characterAtIndex:count];
            NSString *compare=[NSString stringWithFormat:@"%c",veryfier];
            
            // verify the status 
            
            NSLog(@"%@",compare);
            
            // the following logic acts as the way to collect a pair of denominator and numerator 
            
            if(([compare isEqualToString:@"*"]||[compare isEqualToString:@"+"]||[compare isEqualToString:@"%"]||[compare isEqualToString:@"-"]||[compare isEqualToString:@":"]||[compare isEqualToString:@"="]||[compare isEqualToString:@"/"]||(count == [data length]-1)))
            {
                
                if([compare isEqualToString:@"/"]&&(count < [data length]-1)&&(count !=0 ))
                {
                    NSRange range = NSMakeRange(componentCount, count-componentCount);
                    if(isDenominator==NO)
                    {
                        numerator = [data substringWithRange:range];
                        NSLog(@"the numerator is %@",numerator);
                        isDenominator = YES;
                        
                    }
                }
                else if(([compare isEqualToString:@"*"]||[compare isEqualToString:@"+"]||[compare isEqualToString:@"%"]||[compare isEqualToString:@"-"]||[compare isEqualToString:@":"]||[compare isEqualToString:@"="]||((count == [data length]-1)&& ![compare isEqualToString:@"/"])))
                {
                    if (isDenominator==YES) {
                        if((count == [data length]-1)&&!([compare isEqualToString:@"*"]||[compare isEqualToString:@"+"]||[compare isEqualToString:@"%"]||[compare isEqualToString:@"-"]||[compare isEqualToString:@":"]||[compare isEqualToString:@"="])){
                            NSRange range = NSMakeRange(componentCount, count-componentCount+1);
                            denominator =[data substringWithRange:range];
                        }else {
                            NSRange range = NSMakeRange(componentCount, count-componentCount);
                            denominator =[data substringWithRange:range];
                        }
                        
                        isDenominator = NO;
                        newRound = YES;
                        NSLog(@"the denominator is %@",denominator);
                    }
                    else if(isNumeratorBlank == YES)
                    {
                        NSRange range = NSMakeRange(componentCount, count-componentCount);
                        denominator =[data substringWithRange:range];
                        
                        
                        //draw out the blank inside the denominator
                        UIButton* blank = [self drawButton:numerator yPosition:-20 theCell:cell theTable:tableView];
                        NSLog(@"the position of the blank is at %f",blank.frame.size.width);
                        NSLog(@"key points reached=========== denominator is : %@",denominator);
                        
                        
                        UILabel *buttonLine =  [[UILabel alloc] initWithFrame: CGRectMake(basePointX,-39,blank.frame.size.width, tableView.rowHeight+10+theBlankSize.height)];
                        buttonLine.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
                        buttonLine.backgroundColor =   [UIColor clearColor];
                        buttonLine.text = @"_____";    
                        [cell.contentView addSubview:buttonLine];
                        UILabel *denominatorLabel =  [[UILabel alloc] initWithFrame: CGRectMake(basePointX+blank.frame.size.width/2-10,-10,blank.frame.size.width
                                                                                                , tableView.rowHeight+10+theBlankSize.height)];
                        denominatorLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
                        denominatorLabel.backgroundColor =   [UIColor clearColor];
                        denominatorLabel.text = denominator;    
                        [cell.contentView addSubview:denominatorLabel];
                        basePointX = basePointX + blank.frame.size.width +15 ;
                        
                        UILabel *finalOperator =  [[UILabel alloc] initWithFrame: CGRectMake(basePointX-10,-25,15, tableView.rowHeight+10+theBlankSize.height)];
                        finalOperator.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
                        finalOperator.backgroundColor =   [UIColor clearColor];
                        finalOperator.text = compare;    
                        [cell.contentView addSubview:finalOperator];
                        basePointX = basePointX + blank.frame.size.width/2 + 5;
                    
                        
                        isNumeratorBlank =NO;
                        
                    }
                    else
                    {
                        // if not equal to "/"
                        if((count < [data length] -1)||((count = [data length] -1)&&([compare isEqualToString:@"*"]||[compare isEqualToString:@"+"]||[compare isEqualToString:@"%"]||[compare isEqualToString:@"-"]||[compare isEqualToString:@":"]||[compare isEqualToString:@"="])))
                        {
                        NSRange range = NSMakeRange(componentCount, count-componentCount);   
                        number = [data substringWithRange:range];
                        
                        UILabel *dataNumber =  [[UILabel alloc] initWithFrame: CGRectMake(basePointX,-25,30, tableView.rowHeight+10+theBlankSize.height)];
                        dataNumber.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
                        dataNumber.backgroundColor =   [UIColor clearColor];
                        dataNumber.text = number;    
                        [cell.contentView addSubview:dataNumber];
                        basePointX = basePointX + dataNumber.frame.size.width;
                        
                        
                        UILabel *dataOperator =  [[UILabel alloc] initWithFrame: CGRectMake(basePointX,-25,30, tableView.rowHeight+10+theBlankSize.height)];
                        dataOperator.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
                        dataOperator.backgroundColor =   [UIColor clearColor];
                        dataOperator.text = compare;    
                        [cell.contentView addSubview:dataOperator];
                        basePointX = basePointX + dataOperator.frame.size.width;
                        }
                        else 
                        {
                            NSRange range = NSMakeRange(componentCount, count-componentCount+1);   
                            number = [data substringWithRange:range];
                            
                            UILabel *dataNumber =  [[UILabel alloc] initWithFrame: CGRectMake(basePointX,-25,30, tableView.rowHeight+10+theBlankSize.height)];
                            dataNumber.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
                            dataNumber.backgroundColor =   [UIColor clearColor];
                            dataNumber.text = number;    
                            [cell.contentView addSubview:dataNumber];
                            basePointX = basePointX + dataNumber.frame.size.width;
                        }
                    }
                } 
                
                
                
                if([compare isEqualToString:@"/"]&&(count == 0))
                {
                    isNumeratorBlank = YES;
                } 
                
                //on  the next round
                     
                    
               
                
                if([compare isEqualToString:@"/"]&&(count == [data length]-1))
                {
                    isDenominatorBlank = YES;
                    
                    NSRange range = NSMakeRange(componentCount, count-componentCount);
                    numerator =[data substringWithRange:range];
                    
                    UIButton* blank = [self drawButton:numerator yPosition:20 theCell:cell theTable:tableView];
               
                    NSLog(@"key points reached=========== numerator is : %@",numerator); 
                                  
                    
                    UILabel *buttonLine =  [[UILabel alloc] initWithFrame: CGRectMake(basePointX,-39,blank.frame.size.width, tableView.rowHeight+10+theBlankSize.height)];
                    buttonLine.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
                    buttonLine.backgroundColor =   [UIColor clearColor];
                    buttonLine.text = @"_____";    
                    [cell.contentView addSubview:buttonLine];
                    UILabel *denominatorLabel =  [[UILabel alloc] initWithFrame: CGRectMake(basePointX+blank.frame.size.width/2-10,-40,blank.frame.size.width
                                                                                            , tableView.rowHeight+10+theBlankSize.height)];
                    denominatorLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
                    denominatorLabel.backgroundColor =   [UIColor clearColor];
                    denominatorLabel.text = numerator;    
                    [cell.contentView addSubview:denominatorLabel];
                    basePointX = basePointX + blank.frame.size.width -10 ;
                    
                    
                }
                else if(![compare isEqualToString:@"/"]&&(count == [data length]-1))
                {
                    isDenominatorBlank = NO;
                }
                componentCount = count + 1;
            }
                      
            
            // after catching of the denominator and numerator pair 
            
            if(newRound == YES)
            {
                
                CGFloat labelWidth;
                if([numerator length]>[denominator length])
                {
                    labelWidth =[numerator sizeWithFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:20]].width;
                }
                else 
                {
                    labelWidth=[denominator sizeWithFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:20]].width;
                }
                
                UILabel *denominatorLabel =  [[UILabel alloc] initWithFrame: CGRectMake(basePointX-10,-10,labelWidth, tableView.rowHeight+10+theBlankSize.height)];
                denominatorLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
                denominatorLabel.backgroundColor =   [UIColor clearColor];
                denominatorLabel.text = denominator;    
                [cell.contentView addSubview:denominatorLabel];
                
                
                UILabel *numeratorLabel =  [[UILabel alloc] initWithFrame: CGRectMake(basePointX-10,-40,labelWidth, tableView.rowHeight+10+theBlankSize.height)];
                numeratorLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
                numeratorLabel.backgroundColor =   [UIColor clearColor];
                numeratorLabel.text = numerator;    
                [cell.contentView addSubview:numeratorLabel];
                
                
                UILabel *buttonLine =  [[UILabel alloc] initWithFrame: CGRectMake(basePointX-10,-39,labelWidth, tableView.rowHeight+10+theBlankSize.height)];
                buttonLine.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
                buttonLine.backgroundColor =   [UIColor clearColor];
                buttonLine.text = @"__";    
                [cell.contentView addSubview:buttonLine];
                basePointX = basePointX + labelWidth + 20;
                
                if(i < questionComponents.count -1)
                {
                UILabel *finalOperator =  [[UILabel alloc] initWithFrame: CGRectMake(basePointX-10,-25,labelWidth, tableView.rowHeight+10+theBlankSize.height)];
                finalOperator.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
                finalOperator.backgroundColor =   [UIColor clearColor];
                finalOperator.text = compare;    
                [cell.contentView addSubview:finalOperator];
                basePointX = basePointX + labelWidth + 5;
                }
                newRound = NO;  
            }
            count ++ ;    
        }
        i++;
    } 
    
    //read the last row and test whether this part 
    
    NSInteger lastCount = questionComponents.count -1;
    
    if(([[questionComponents objectAtIndex:lastCount] isEqualToString:@""]==YES))
    {
     
        NSLog(@"logic correct============");
        
        // creation of button
        UIButton* blank = [self drawButton:numerator yPosition:0 theCell:cell theTable:tableView];
        NSLog(@"the position of the blank is at %f",blank.frame.size.width);
    }
    
    
    // plot of the anwser label, show out the correct label position, waiting for combi
    i = 1;
    
    CGSize answerLabelSize=CGSizeMake(200, tableView.rowHeight/3-10);
    CGPoint answerLabelOriginPoint = CGPointMake(525, (tableView.rowHeight/numOfBlank-answerLabelSize.height)/2);
    
    while(i<=numOfBlank)
    {
        
        NSLog(@"data is drawn inside of the: %f",answerLabelOriginPoint.y);
        UIButton *lbl_eachAnswerLabel;
        lbl_eachAnswerLabel = [UIButton buttonWithType:UIButtonTypeRoundedRect]; 
        CGRect theFrame = CGRectMake(answerLabelOriginPoint.x, answerLabelOriginPoint.y, answerLabelSize.width-100, answerLabelSize.height);
        lbl_eachAnswerLabel.Frame= theFrame;
            answerLabelOriginPoint.y += (tableView.rowHeight/numOfBlank);

        [answerBtns addObject:lbl_eachAnswerLabel];
        
        [lbl_eachAnswerLabel addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [lbl_eachAnswerLabel addTarget:self action:@selector(popOut:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:lbl_eachAnswerLabel];
         i ++;
    }

    
 
    return cell;
}

- (IBAction)buttonPressed:(UIButton *)sender 

{
    temp.backgroundColor = [UIColor whiteColor];
    temp=[blanks objectAtIndex:[answerBtns indexOfObject:sender]];
    
    NSLog(@"button pressed");
    
}

- (IBAction)popOut:(UIButton *)sender
{
    NSLog(@"call already");
    

    _keyBoardViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"keyBoardViewController"];
    
	
	//set popover content size
	self.keyBoardViewController.contentSizeForViewInPopover = //CGSizeMake(400, 400);
    CGSizeMake(self.keyBoardViewController.view.frame.size.width, self.keyBoardViewController.view.frame.size.height);
    
	
	//set delegate 
	self.popKeyboardController.delegate = self;
    self.keyBoardViewController.delegate =self;
      
    btn_active = sender;
    btn_activeIndex = [answerBtns indexOfObject:sender];  
	
	//create a popover controller
	_popKeyBoardController = [[UIPopoverController alloc] initWithContentViewController:self.keyBoardViewController];
	

    if(btn_activeIndex < answerBtns.count/2 )
    {
       [self.popKeyboardController presentPopoverFromRect:[sender.superview convertRect:sender.frame toView:sender.superview.superview.superview.superview] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    }
    else 
    {
      [self.popKeyboardController presentPopoverFromRect:[sender.superview convertRect:sender.frame toView:sender.superview.superview.superview.superview] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];  
    }
    
}

//implementing keyboardProtocol
- (void)titleChanged:(NSString *)Title
{
    [btn_active setTitle:Title forState:(UIControlStateNormal)] ;
    btn_active.titleLabel.textColor = [UIColor blackColor];
    [[blanks objectAtIndex:btn_activeIndex] setTitle:Title forState:(UIControlStateNormal)];
    [[blanks objectAtIndex:btn_activeIndex] setBackgroundColor:[UIColor brownColor] ];
    [btn_active.titleLabel setTextColor:[UIColor brownColor]];
    
}

-(UIButton*)drawButton:(NSString*) value yPosition:(CGFloat)y theCell:(UITableViewCell*) cell theTable:(UITableView*) tableView
{

    //draw out the blank inside the denominator
    UIButton* blank =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGRect btFrame =CGRectMake(basePointX,(tableView.rowHeight- theBlankSize.height)/2+y, theBlankSize.width, theBlankSize.height);
    blank.frame = btFrame;
    
    blank.backgroundColor =[UIColor cyanColor];
    cell.backgroundColor =[UIColor redColor];
    blank.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [blank setTitle:@"(      )" forState:UIControlStateNormal];
    blank.titleLabel.font = [UIFont systemFontOfSize: 20.0];
    [blank.titleLabel setTextColor:[UIColor brownColor]];
    [cell.contentView addSubview:blank];
    [blanks addObject:blank];

    return blank;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)cellDraw
{
    NSLog(@"function for testing");
}

-(void)finish
{
    [self.popKeyboardController dismissPopoverAnimated:YES];
    
}


#pragma loadingQuestions
- (void) loadQuestions
{
    questions = _allQuestions;
    NSLog(@"%@", [questions objectAtIndex:0]);
    NSLog(@"%@", [questions objectAtIndex:1]);
    NSLog(@"%@", [questions objectAtIndex:2]);
    NSLog(@"%@", [questions objectAtIndex:3]);
    NSLog(@"%@", [questions objectAtIndex:4]);
    NSLog(@"%@", [questions objectAtIndex:5]);

    
}
@end
