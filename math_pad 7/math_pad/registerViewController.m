//
//  registerViewController.m
//  math_pad
//
//  Created by zhaoyue on 23/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "registerViewController.h"
#import <sqlite3.h>
@interface registerViewController ()

@end

@implementation registerViewController
@synthesize Btn_grade,userName,userPassword,userPasswordConfirm;

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
	// Do any additional setup after loading the view.
    databaseName = @"mathTestDatabase.sql";
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    NSLog(@"%@",databasePath);
    
    grades = [[NSMutableArray alloc] init];
    [grades addObject:[NSString stringWithString:@"－－请选择－－"]];
    [grades addObject:[NSString stringWithString:@"一年级（上）"]];
    [grades addObject:[NSString stringWithString:@"一年级（下）"]];
    [grades addObject:[NSString stringWithString:@"二年级（上）"]];
    [grades addObject:[NSString stringWithString:@"二年级（下）"]];
    
    
    // set up the delegate

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
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
   // picker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
   
    [picker setFrame:CGRectMake(0, 20, 280, 180)];
   
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@" testing " delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"cancel" otherButtonTitles:@"button 1", @"button 2",nil];
    actionSheet.actionSheetStyle = UIBarStyleBlackOpaque;
    
    [actionSheet addSubview:picker];
    [actionSheet setBounds:CGRectMake(0, 0, 320, 500)];
    [actionSheet showFromRect:CGRectMake(0,0,750,550) inView:self.view animated:YES];
    
       
  

}
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
-(IBAction)submit:(UIButton *)sender{
    
  
    userRegisterName = userName.text;
    userRegisterPassword = userPassword.text;
    userRegisterPasswordConfirm = userPasswordConfirm.text;
    
    // code here for detection of user grade 

    [self registerCheck];

}





-(void) registerCheck
{
    
    // Setup the database object
	sqlite3 *database;

	// Init the animals Array
	
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
    {
		// Setup the SQL Statement and compile it for faster access
        NSLog(@"%@ /n the database has been succefully opened",databasePath);
        // the following code is for testing purpose
        NSString *insertSQL =@"INSERT INTO animals (userName,schoolYear, userPassword,userEmail) values(?,?,?,?);";
        const char *sqlStatement1 = [insertSQL UTF8String];
        NSLog(@"%s",sqlStatement1);
		sqlite3_stmt *compiledStatement=nil;
		if(sqlite3_prepare_v2(database, sqlStatement1, -1, &compiledStatement, NULL) == SQLITE_OK) 
        {
			// Loop through the results and add them to the feeds array
            NSLog(@"databaseConnection successful");
            sqlite3_bind_text(compiledStatement, 1, [userName.text UTF8String], -1, NULL);//绑定参数  
            sqlite3_bind_text(compiledStatement, 2, [@"1" UTF8String], -1, NULL);  
            sqlite3_bind_text(compiledStatement, 3, [userPassword.text UTF8String], -1, NULL);  
            sqlite3_bind_text(compiledStatement, 4, [@"zyzyzy@gmail.com" UTF8String], -1, NULL); 
		}
        
        if (SQLITE_DONE == (sqlite3_step(compiledStatement))) 
        { 
            NSLog(@"data update successful");
             
        }
        else
        {  
            NSLog(@"data update failure"); 
            
        }  
        
        
		// Release the compiled statement from memory
        
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{ 
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed. 
    NSTimeInterval animationDuration = 0.30f; 
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil]; 
    [UIView setAnimationDuration:animationDuration]; 
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height); 
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    
    return YES; 
}

- (void)keyboardWillShow:(NSNotification *)noti
{ 
    float height = 216.0; 
    CGRect frame = self.view.frame; 
    frame.size = CGSizeMake(frame.size.width, frame.size.height - height); 
    [UIView beginAnimations:@"Curl"context:nil];//动画开始 
    [UIView setAnimationDuration:0.30]; 
    [UIView setAnimationDelegate:self]; 
    [self.view setFrame:frame]; 
    [UIView commitAnimations];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{ 
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f; 
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil]; 
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width; 
    float height = self.view.frame.size.height; 
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height); 
        self.view.frame = rect; 
    } 
    [UIView commitAnimations]; 
    
}

-(void)shakescreen
{
    //Shake screen
    CGFloat t = 5.0;
    CGAffineTransform translateRight = CGAffineTransformTranslate(CGAffineTransformIdentity, t, 0);
    CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, 0);
    
    self.view.transform = translateLeft;
    
    [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^
     {
         [UIView setAnimationRepeatCount:2.0];
         self.view.transform = translateRight;
     } completion:^(BOOL finished)
     
     {
         if (finished) 
         {
             [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
              {
                  self.view.transform = CGAffineTransformIdentity;
              } 
                              completion:NULL];
         }
     }];
}

@end
