//
//  keyBoardViewController.m
//  math_pad
//
//  Created by Gemeng Qin on 29/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "keyBoardViewController.h"


@interface keyBoardViewController ()

@end

@implementation keyBoardViewController
@synthesize clear;
@synthesize key0;
@synthesize key1;
@synthesize key2;
@synthesize key3;
@synthesize key4;
@synthesize key5;
@synthesize key6;
@synthesize key7;
@synthesize key8;
@synthesize key9;
@synthesize equals;
@synthesize smallerThan;
@synthesize biggerThan;
@synthesize point;

@synthesize answerString = m_answerString;
@synthesize delegate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //NSLog(@" initwith in");
        // Custom initialization
        //[self.view setBounds:CGRectMake(0, 0, 0, 0)];
       // NSLog(@"bound %f", [self.view bounds].size.height);
       // [self.view setFrame:CGRectMake(0, 0, 400, 400)];
       // NSLog(@"view %f %f",self.view.frame.size.width, self.view.frame.size.height);
        //self.view.backgroundColor = [UIColor redColor];
        //NSLog(@"initwith out");
    }
    return self;
}

- (void)viewDidLoad
{
   // NSLog(@"viewDidLoad in ");
    
    [super viewDidLoad];
    m_answerString = [[NSMutableString alloc]init];
	// Do any additional setup after loading the view.
    //NSLog(@"in viewDidLoad %@",self.view);
    //NSLog(@"viewDidLoad out ");

    
}

- (void)viewDidUnload
{

    [self setKey1:nil];
    [self setKey2:nil];
    [self setKey3:nil];
    [self setKey4:nil];
    [self setKey5:nil];
    [self setKey6:nil];
    [self setKey8:nil];
    [self setKey9:nil];
    [self setKey7:nil];
    [self setEquals:nil];
    [self setSmallerThan:nil];
    [self setBiggerThan:nil];
    [self setKey0:nil];
    [self setPoint:nil];
    [self setClear:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)answerPressed:(UIButton *)sender 
{
    [self.answerString appendString:sender.titleLabel.text]; 
    NSLog(@"ansStr %@" , self.answerString);
    
    [delegate titleChanged:self.answerString];
}

- (IBAction)clear:(UIButton *)sender 
{
    if ( [self.answerString length] > 0)
        self.answerString = [self.answerString substringToIndex:[self.answerString length] - 1];
    NSLog(@"ansStr %@" , self.answerString);
    [delegate titleChanged:self.answerString];

}
@end
