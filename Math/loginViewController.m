//
//  loginViewController.m
//  Math
//
//  Created by zhaoyue on 15/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "loginViewController.h"
#import "ViewController.h"
#import "registerViewController.h"
#import <sqlite3.h>
@interface loginViewController ()

@end

@implementation loginViewController
@synthesize userName;
@synthesize userPassword;
@synthesize ViewController, registerViewController;
@synthesize question,userdetail,anwser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization   
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    // Setup some globals
	databaseName = @"mathTestDatabase.sql";
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    NSLog(@"%@",databasePath);
    
    userName.delegate =self;
    userPassword.delegate =self;
    // Execute the "checkAndCreateDatabase" function
	[self checkAndCreateDatabase];
	

    
    
}

- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setUserPassword:nil];
    [super viewDidUnload];
   
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)userLogin:(id)sender 
{
    BOOL loginStatus;
    if ( !self.ViewController ) 
    {
        self.ViewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    }
    
    // Query the database for all animal records and construct the "animals" array
    
    loginStatus = [self login];
    if(loginStatus == YES)
    {
        [self.navigationController pushViewController:self.ViewController animated:YES];
    }
    else 
    {
        [self shakescreen];
    }
}

- (IBAction)userRegister:(id)sender 
{
    if ( !self.registerViewController ) 
    {
        self.registerViewController = [[registerViewController alloc] initWithNibName:@"registerViewController" bundle:nil];
    }
    
    [self.navigationController pushViewController:self.registerViewController animated:YES];
    
    
    
}



- (void)checkAndCreateDatabase
{
	// Check if the SQL database has already been saved to the users phone, if not then copy it over
	BOOL success;
	
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:databasePath];
	
	// If the database already exists then return without doing anything
	if(success) return;
	
	// If not then proceed to copy the database from the application to the users filesystem
	
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
	
    NSLog(@"database dosen't exist");
    
	// Copy the database from the package to the users filesystem
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
	
    
}

- (BOOL)login
{
    // Setup the database object
	sqlite3 *database;
	BOOL caseMatched = NO;
	// Init the animals Array
	
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
    {
		// Setup the SQL Statement and compile it for faster access
        NSLog(@"%@ /n the database has been succefully opened",databasePath);
        NSString *name = userName.text;
        NSString *password = userPassword.text;
        NSString *sqlString = @"select * from animals Where userName like'";
        sqlString = [sqlString stringByAppendingString:name];
        sqlString = [sqlString stringByAppendingFormat:@"'"];
        
        NSLog(@"%@",sqlString);
        NSLog(@"%@",password);
        const char *sqlStatement = [sqlString UTF8String];
        
        NSLog(@"%s",sqlStatement);
        
        
		sqlite3_stmt *compiledStatement=nil;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
        {
			// Loop through the results and add them to the feeds array
            NSLog(@"databaseConnection successful");
            
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
            {
                //Read the data from the result row
                NSString *aPassword = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                NSLog(@"%@",aPassword);
               
                NSLog(@"------------");
                if([password isEqualToString:aPassword])
                {
                    caseMatched =YES;
                }
			}
		}
		// Release the compiled statement from memory

		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    if(caseMatched == YES)
    {
        return YES;
    }
    else 
    {
        return NO;
    }
    
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


- (void)textFieldDidEndEditing:(UITextField*)textField
{
    
    // for further development
    
}


@end
