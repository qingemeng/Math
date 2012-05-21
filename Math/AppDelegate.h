//
//  AppDelegate.h
//  Math
//
//  Created by zhaoyue on 15/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class ViewController;
@class loginViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>



@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic)  UINavigationController *navigationController;
@property (strong, nonatomic) ViewController *viewController;
@property (strong,nonatomic) loginViewController * loginViewController;



@end
