//
//  QuestionsRootViewController.m
//  Questions
//
//  Created by Gemeng Qin on 22/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuestionsRootViewController.h"

#import "QuestionsModelController.h"

#import "QuestionsDataViewController.h"

@interface QuestionsRootViewController ()
@property (readonly, strong, nonatomic) QuestionsModelController *modelController;
@end

@implementation QuestionsRootViewController
@synthesize btn_nextPage = _btn_nextPage;
@synthesize btn_prePage = _btn_prePage;

@synthesize pageViewController = _pageViewController;
@synthesize lbl_gradeSem = _lbl_gradeSem;
@synthesize lbl_version = _lbl_version;
@synthesize lbl_recommendationTime = _lbl_recommendationTime;
@synthesize lbl_questionSet = _lbl_questionSet;
@synthesize lbl_user = _lbl_user;
@synthesize lbl_timerMin;
@synthesize lbl_timerSec;
@synthesize btn_start = _btn_start;
@synthesize btn_submit = _btn_submit;
@synthesize modelController = _modelController;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Configure the page view controller and add it as a child view controller.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    
    QuestionsDataViewController *startingViewController = [self.modelController viewControllerAtIndex:0 ofQuestionSet:[[NSMutableIndexSet alloc] initWithIndexesInRange:NSMakeRange(0,_modelController.numOfQuestionsPerPage)] storyboard:self.storyboard];
    NSArray *viewControllers = [NSArray arrayWithObject:startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    
    self.pageViewController.dataSource = self.modelController;
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    pageViewRect = CGRectInset(pageViewRect, 40.0, 80.0);
    self.pageViewController.view.frame = pageViewRect;
    
    [self.pageViewController didMoveToParentViewController:self];
    
    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
}

- (void)viewDidUnload
{
    [self setLbl_gradeSem:nil];
    [self setLbl_version:nil];
    [self setLbl_recommendationTime:nil];
    [self setLbl_questionSet:nil];
    [self setLbl_user:nil];
    [self setLbl_timerMin:nil];
    [self setLbl_timerSec:nil];
    [self setBtn_start:nil];
    [self setBtn_submit:nil];
    [self setBtn_nextPage:nil];
    [self setBtn_prePage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (QuestionsModelController *)modelController
{
    // Return the model controller object, creating it if necessary.
    // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[QuestionsModelController alloc] init];
    }
    return _modelController;
}

#pragma mark - UIPageViewController delegate methods

/*
 - (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
 {
 
 }
 */

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        // In portrait orientation: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
        UIViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
        NSArray *viewControllers = [NSArray arrayWithObject:currentViewController];
        //NSLog(@"currentviewContrllers%@", currentViewController);
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        
        self.pageViewController.doubleSided = NO;
        return UIPageViewControllerSpineLocationMin;
    }
    
    // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
    QuestionsDataViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
    NSArray *viewControllers = nil;
    
    NSUInteger indexOfCurrentViewController = [self.modelController indexOfViewController:currentViewController];
    if (indexOfCurrentViewController == 0 || indexOfCurrentViewController % 2 == 0) {
        UIViewController *nextViewController = [self.modelController pageViewController:self.pageViewController viewControllerAfterViewController:currentViewController];
        viewControllers = [NSArray arrayWithObjects:currentViewController, nextViewController, nil];
    } else {
        UIViewController *previousViewController = [self.modelController pageViewController:self.pageViewController viewControllerBeforeViewController:currentViewController];
        viewControllers = [NSArray arrayWithObjects:previousViewController, currentViewController, nil];
    }
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    
    return UIPageViewControllerSpineLocationMid;
}

#pragma timer
// awakeTimer
- (void) timerAwake {
	// just clear timer outputs 
	//[lbl_timerSec setText:@"00"];
    //[lbl_timerMin setText:@"0"];
    NSLog(@"timer test %@ %@",lbl_timerMin.text, lbl_timerSec.text);
	
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
    if ( [lbl_timerSec.text intValue] < 59)
    {
        NSInteger tempInt = [lbl_timerSec.text intValue] +1 ;
        lbl_timerSec.text = [NSString stringWithFormat:@"%d",tempInt];
    }else {
        [lbl_timerSec setText:@"0"];
    }
    
    /*if ( [_lbl_timerSec.text intValue] < 59 && [_lbl_timerMin.text intValue] < 8 )
     {
     NSInteger tempInt = [_lbl_timerSec.text intValue] +1 ;
     _lbl_timerSec.text = [NSString stringWithFormat:@"%d",tempInt];
     } else if([_lbl_timerMin.text intValue] < 8){
     [_lbl_timerSec setText:@"00"];
     } else {
     [_lbl_timerSec setText:@"00"];
     [timerSec invalidate];
     }*/
    
}

- ( void ) updateTimerMin:(NSTimer *) timer
{
    //if ([_lbl_timerMin.text intValue] < 7 ) 
    //{
    NSInteger tempInt = [lbl_timerSec.text intValue] +1 ;
    lbl_timerMin.text = [NSString stringWithFormat:@"%d",tempInt];
    
    //}else {
    // _lbl_timerMin.text = @"08";
    //[timerMin invalidate];
    //}*/
}



- (IBAction)startTimer:(UIButton *)sender 
{
    [self timerAwake];
}

- (IBAction)endTimer:(UIButton *)sender 
{
    NSLog(@"stop");
    [timerSec invalidate];
    [timerMin invalidate];
    
    
}
@end
