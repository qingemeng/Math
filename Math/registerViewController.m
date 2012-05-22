//
//  registerViewController.m
//  Math
//
//  Created by zhaoyue on 15/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "registerViewController.h"




@implementation registerViewController
@synthesize Btn_grade;

/*- (void)dealloc
 {
 [grades release];
 
 [Btn_grade release];
 [super dealloc];
 }*/



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //picker
    
    
    grades = [[NSMutableArray alloc] init];
    [grades addObject:[NSString stringWithString:@"－－请选择－－"]];
    [grades addObject:[NSString stringWithString:@"一年级（上）"]];
    [grades addObject:[NSString stringWithString:@"一年级（下）"]];
    [grades addObject:[NSString stringWithString:@"二年级（上）"]];
    [grades addObject:[NSString stringWithString:@"二年级（下）"]];
    //grade_button action
    
    
}

- (void)viewDidUnload
{
    [self setBtn_grade:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)showPickerView
{
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.delegate = self;
    picker.dataSource = self;
    picker.showsSelectionIndicator = YES;
    picker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Done" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    [actionSheet addSubview:picker];
    [actionSheet showInView:self.view];
    [actionSheet setBounds:CGRectMake(0, 0, 320, 500)];
    [picker setFrame:CGRectMake(0, 80, 0, 0)];
    //    picker.center = CGPointMake(240, picker.center.y);
    
    //  [picker release];
    //[actionSheet release];
}



#pragma mark -
#pragma mark Picker View Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return [grades count];
	
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [grades objectAtIndex:row];
	
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	[Btn_grade.titleLabel setText:[grades objectAtIndex:row]];
    
}

- (IBAction)btnGradeClicked:(id)sender 
{
    [self showPickerView];
}
@end


