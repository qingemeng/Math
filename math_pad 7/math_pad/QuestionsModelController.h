//
//  QuestionsModelController.h
//  Questions
//
//  Created by Gemeng Qin on 22/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuestionsDataViewController;

@interface QuestionsModelController : NSObject <UIPageViewControllerDataSource>
{
    NSString * databaseName;
    NSString * databasePath;
    NSMutableArray * array;
}

@property NSInteger numOfQuestionsPerPage;


- (QuestionsDataViewController *)viewControllerAtIndex:(NSUInteger)index ofQuestionSet:(NSMutableIndexSet *) indexSet storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(QuestionsDataViewController *)viewController;


@end
