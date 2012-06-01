//
//  QuestionsModelController.m
//  Questions
//
//  Created by Gemeng Qin on 22/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuestionsModelController.h"
#import <sqlite3.h>
#import "QuestionsDataViewController.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

@interface QuestionsModelController()
@property (strong, nonatomic) NSMutableArray *pageData;
@property (strong,nonatomic) NSMutableArray *questionsData;
@end

@implementation QuestionsModelController

@synthesize pageData = _pageData;
@synthesize questionsData =_questionsData;
@synthesize numOfQuestionsPerPage;


- (id)init
{
    numOfQuestionsPerPage =6;
    self = [super init];
    if (self) {
        // Create the data model.
        NSInteger i=0;
        NSMutableArray *pages = [[NSMutableArray alloc] init];
        while (i<60/numOfQuestionsPerPage) {
            NSString *page = [[NSString alloc] init];      
            page= [NSString stringWithFormat:@"Page %d", i+1];
            i++;
            [pages addObject:page];
        }
        
     //setting up the data base path
        databaseName = @"mathTestDatabase.sql";
        
        // Get the path to the documents directory and append the databaseName
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
        array = [[NSMutableArray alloc] init];    
        
        NSMutableArray *allQuestions = [[NSMutableArray alloc]init];
               
        // database connection:
        
        
        allQuestions = [self load] ;
        NSLog(@"%@", [allQuestions objectAtIndex:1]);
        NSLog(@"%@", [allQuestions objectAtIndex:2]);
        NSLog(@"%@", [allQuestions objectAtIndex:3]);
        
        
        _pageData = pages;
        _questionsData = allQuestions;
        //[self.pageData arrayByAddingObject:@"Page1"];
        //[pageData arrayByAddingObject:@"Page2"];
        //[pageData arrayByAddingObject:@"Page3"];
        NSLog(@"page data content %@", _pageData);
        NSLog(@"no of pages %d",[self.pageData count]);
    }
    return self;
}

- (QuestionsDataViewController *)viewControllerAtIndex:(NSUInteger)index ofQuestionSet:(NSMutableIndexSet *) indexSet storyboard:(UIStoryboard *)storyboard
{   
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    QuestionsDataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"QuestionsDataViewController"];
    dataViewController.dataObject = [self.pageData objectAtIndex:index];
    dataViewController.allQuestions = [self.questionsData objectsAtIndexes:indexSet];
    NSLog(@"indexSet %@",indexSet);
    NSLog(@"allQs%@",dataViewController.allQuestions);
    NSLog(@"dataobject %@",dataViewController.dataObject);
    return dataViewController;
}


-(NSMutableArray *)load
{
    

    
    sqlite3 *database;
	BOOL caseMatched = NO;
	// Init the animals Array
	
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) 
    {
		// Setup the SQL Statement and compile it for faster access
        NSLog(@"%@ /n the database has been succefully opened",databasePath);
        NSString *sqlString = @"select * from Question";

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
                NSString *question = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                NSLog(@"%@",question);
                [array addObject:question];
                NSLog(@"------------");
			}
		}
		// Release the compiled statement from memory

		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
    return array;
    
}




- (NSUInteger)indexOfViewController:(QuestionsDataViewController *)viewController
{   
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.pageData indexOfObject:viewController.dataObject];
}




#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(QuestionsDataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    if (index*numOfQuestionsPerPage+numOfQuestionsPerPage<59){
        NSLog(@"Before inRange %d",index);
        return [self viewControllerAtIndex:index ofQuestionSet:[[NSMutableIndexSet alloc] initWithIndexesInRange:NSMakeRange(numOfQuestionsPerPage*index,numOfQuestionsPerPage)] storyboard:viewController.storyboard];
    }
    else {
        
        NSLog(@"Before outRange %d",index);
        
        return [self viewControllerAtIndex:index ofQuestionSet:[[NSMutableIndexSet alloc] initWithIndexesInRange:NSMakeRange(numOfQuestionsPerPage*index,60-numOfQuestionsPerPage*index)] storyboard:viewController.storyboard];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(QuestionsDataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    
    if (index*numOfQuestionsPerPage+numOfQuestionsPerPage<59){
        NSLog(@"after inRange %d",index);
        return [self viewControllerAtIndex:index ofQuestionSet:[[NSMutableIndexSet alloc] initWithIndexesInRange:NSMakeRange(numOfQuestionsPerPage*index,numOfQuestionsPerPage)] storyboard:viewController.storyboard];
    }
    else {
        NSLog(@"after outRange %d",index);
        return [self viewControllerAtIndex:index ofQuestionSet:[[NSMutableIndexSet alloc] initWithIndexesInRange:NSMakeRange(numOfQuestionsPerPage*index,60-numOfQuestionsPerPage*index)] storyboard:viewController.storyboard];
    }
}





@end
