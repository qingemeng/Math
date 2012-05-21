//
//  CourseInfo.h
//  Math
//
//  Created by zhaoyue on 16/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseInfo : NSObject


@property (nonatomic, assign)int uniqueId;
@property (nonatomic, retain)NSString* userName;
@property (nonatomic, retain)NSString* userPassword;

-(id) initWithUseName:(NSString* )userName Password:(NSString*) userPassword;

@end
