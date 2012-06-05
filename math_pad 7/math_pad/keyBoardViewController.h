//
//  keyBoardViewController.h
//  math_pad
//
//  Created by Gemeng Qin on 29/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol keyBoardDelegate <NSObject>

- (void)titleChanged:(NSString *)Title;
-(void)finish;

@end

@interface keyBoardViewController : UIViewController <UIPopoverControllerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *key0;
@property (strong, nonatomic) IBOutlet UIButton *key1;
@property (strong, nonatomic) IBOutlet UIButton *key2;
@property (strong, nonatomic) IBOutlet UIButton *key3;
@property (strong, nonatomic) IBOutlet UIButton *key4;

@property (strong, nonatomic) IBOutlet UIButton *key5;
@property (strong, nonatomic) IBOutlet UIButton *key6;
@property (strong, nonatomic) IBOutlet UIButton *key7;

@property (strong, nonatomic) IBOutlet UIButton *key8;
@property (strong, nonatomic) IBOutlet UIButton *key9;
@property (strong, nonatomic) IBOutlet UIButton *equals;
@property (strong, nonatomic) IBOutlet UIButton *smallerThan;
@property (strong, nonatomic) IBOutlet UIButton *biggerThan;
@property (strong, nonatomic) IBOutlet UIButton *point;
@property (strong, nonatomic) IBOutlet UIButton *clear;
@property (strong, nonatomic) NSMutableString *answerString;
@property (nonatomic, assign) id<keyBoardDelegate> delegate;

- (IBAction)answerPressed:(UIButton *)sender;
- (IBAction)clear:(UIButton *)sender;

- (void)titleChanged:(NSString *)Title;


@end
