//
//  PageAppModelController.h
//  math_pad
//
//  Created by zhaoyue on 23/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PageAppDataViewController;

@interface PageAppModelController : NSObject <UIPageViewControllerDataSource>

- (PageAppDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(PageAppDataViewController *)viewController;

@end
