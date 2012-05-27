//
//  QuestionsModelController.m
//  Questions
//
//  Created by Gemeng Qin on 22/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuestionsModelController.h"

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
        
        NSMutableArray *allQuestions = [[NSMutableArray alloc]init];
        NSString * testString = @"--1 1 + 2 =?";
        NSString * testString2 = @"2 1 =?2 =?3";
        NSString * testString3 = @"3 1 + 2 × 24 =?";
        NSString * testString4 = @"4 1 + 2 =?";
        NSString * testString5 = @"5 2 ×?= 4";
        NSString * testString6 = @"6 1 + 2 × 24 =?";
        NSString * testString7 = @"7 1 + 2 =?";
        NSString * testString8 = @"8 2 ×?= 4";
        NSString * testString9 = @"9 1 + 2 × 24 =?";
        NSString * testString10 = @"10 1 + 2 =?";
        NSString * testString11 = @"11 2 ×?= 4";
        NSString * testString12 = @"12 1 + 2 × 24 =?";
        NSString * testString13 = @"13 1 + 2 =?";
        NSString * testString14 = @"14 2 ×?= 4";
        NSString * testString15 = @"15 1 + 2 × 24 =?";
        NSString * testString16 = @"16 1 + 2 =?";
        NSString * testString17 = @"17 2 ×?= 4";
        NSString * testString18 = @"18 1 + 2 × 24 =?";
        NSString * testString19 = @"19 1 + 2 =?";
        NSString * testString20 = @"20 2 ×?= 4";
        NSString * testString21 = @"21 1 + 2 × 24 =?";
        NSString * testString22 = @"22 1 + 2 =?";
        NSString * testString23 = @"23 2 ×?= 4";
        NSString * testString24 = @"24 1 + 2 × 24 =?";
        NSString * testString25 = @"25 1 + 2 =?";
        NSString * testString26 = @"26 2 ×?= 4";
        NSString * testString27 = @"27 1 + 2 × 24 =?";
        NSString * testString28 = @"28 1 + 2 =?";
        NSString * testString29 = @"29 2 ×?= 4";
        NSString * testString30 = @"30 1 + 2 × 24 =?";
        NSString * testString31 = @"31 1 + 2 =?";
        NSString * testString32 = @"32 2 ×?= 4";
        NSString * testString33 = @"33 1 + 2 × 24 =?";
        NSString * testString34 = @"34 1 + 2 =?";
        NSString * testString35 = @"35 2 ×?= 4";
        NSString * testString36 = @"36 1 + 2 × 24 =?";
        NSString * testString37 = @"37 1 + 2 =?";
        NSString * testString38 = @"38 2 ×?= 4";
        NSString * testString39 = @"39 1 + 2 × 24 =?";
        NSString * testString40 = @"40 1 + 2 =?";
        NSString * testString41 = @"41 2 ×?= 4";
        NSString * testString42 = @"42 1 + 2 × 24 =?";
        NSString * testString43 = @"43 1 + 2 =?";
        NSString * testString44 = @"44 2 ×?= 4";
        NSString * testString45 = @"45 1 + 2 × 24 =?";
        NSString * testString46 = @"46 1 + 2 =?";
        NSString * testString47 = @"47 2 ×?= 4";
        NSString * testString48 = @"48 1 + 2 × 24 =?";
        NSString * testString49 = @"49 1 + 2 =?";
        NSString * testString50 = @"50 2 ×?= 4";
        NSString * testString51 = @"51 1 + 2 × 24 =?";
        NSString * testString52 = @"52 1 + 2 =?";
        NSString * testString53 = @"53 2 ×?= 4";
        NSString * testString54 = @"54 1 + 2 × 24 =?";
        NSString * testString55 = @"55 1 + 2 =?";
        NSString * testString56 = @"56 2 ×?= 4";
        NSString * testString57 = @"57 1 + 2 × 24 =?";
        NSString * testString58 = @"58 1 + 2 =?";
        NSString * testString59 = @"59 2 ×?= 4";
        NSString * testString60 = @"60 1 + 2 × 24 =?";
        
        
        [allQuestions addObject:testString];
        [allQuestions addObject:testString2];
        [allQuestions addObject:testString3];
        [allQuestions addObject:testString4];
        [allQuestions addObject:testString5];
        [allQuestions addObject:testString6];
        [allQuestions addObject:testString7];
        [allQuestions addObject:testString8];
        [allQuestions addObject:testString9];
        [allQuestions addObject:testString10];
        [allQuestions addObject:testString11];
        [allQuestions addObject:testString12];
        [allQuestions addObject:testString13];
        [allQuestions addObject:testString14];
        [allQuestions addObject:testString15];
        [allQuestions addObject:testString16];
        [allQuestions addObject:testString17];
        [allQuestions addObject:testString18];
        [allQuestions addObject:testString19];
        [allQuestions addObject:testString20];
        [allQuestions addObject:testString21];
        [allQuestions addObject:testString22];
        [allQuestions addObject:testString23];
        [allQuestions addObject:testString24];
        [allQuestions addObject:testString25];
        [allQuestions addObject:testString26];
        [allQuestions addObject:testString27];
        [allQuestions addObject:testString28];
        [allQuestions addObject:testString29];
        [allQuestions addObject:testString30];
        [allQuestions addObject:testString31];
        [allQuestions addObject:testString32];
        [allQuestions addObject:testString33];
        [allQuestions addObject:testString34];
        [allQuestions addObject:testString35];
        [allQuestions addObject:testString36];
        [allQuestions addObject:testString37];
        [allQuestions addObject:testString38];
        [allQuestions addObject:testString39];
        [allQuestions addObject:testString40];
        [allQuestions addObject:testString41];
        [allQuestions addObject:testString42];
        [allQuestions addObject:testString43];
        [allQuestions addObject:testString44];
        [allQuestions addObject:testString45];
        [allQuestions addObject:testString46];
        [allQuestions addObject:testString47];
        [allQuestions addObject:testString48];
        [allQuestions addObject:testString49];
        [allQuestions addObject:testString50];
        [allQuestions addObject:testString51];
        [allQuestions addObject:testString52];
        [allQuestions addObject:testString53];
        [allQuestions addObject:testString54];
        [allQuestions addObject:testString55];
        [allQuestions addObject:testString56];
        [allQuestions addObject:testString57];
        [allQuestions addObject:testString58];
        [allQuestions addObject:testString59];
        [allQuestions addObject:testString60];
        
        
        _pageData = pages;
        _questionsData = allQuestions;
        //[self.pageData arrayByAddingObject:@"Page1"];
        //[pageData arrayByAddingObject:@"Page2"];
        //[pageData arrayByAddingObject:@"Page3"];
        //NSLog(@"page data content %@", _pageData);
        //NSLog(@"no of pages %d",[self.pageData count]);
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
   // NSLog(@"indexSet %@",indexSet);
   // NSLog(@"allQs%@",dataViewController.allQuestions);
    //NSLog(@"dataobject %@",dataViewController.dataObject);
    return dataViewController;
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
        //NSLog(@"Before inRange %d",index);
        return [self viewControllerAtIndex:index ofQuestionSet:[[NSMutableIndexSet alloc] initWithIndexesInRange:NSMakeRange(numOfQuestionsPerPage*index,numOfQuestionsPerPage)] storyboard:viewController.storyboard];
    }
    else {
        
        //NSLog(@"Before outRange %d",index);
        
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
        //NSLog(@"after inRange %d",index);
        return [self viewControllerAtIndex:index ofQuestionSet:[[NSMutableIndexSet alloc] initWithIndexesInRange:NSMakeRange(numOfQuestionsPerPage*index,numOfQuestionsPerPage)] storyboard:viewController.storyboard];
    }
    else {
        //NSLog(@"after outRange %d",index);
        return [self viewControllerAtIndex:index ofQuestionSet:[[NSMutableIndexSet alloc] initWithIndexesInRange:NSMakeRange(numOfQuestionsPerPage*index,60-numOfQuestionsPerPage*index)] storyboard:viewController.storyboard];
    }
}





@end
