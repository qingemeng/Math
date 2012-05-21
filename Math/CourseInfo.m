//
//  CourseInfo.m
//  Math
//
//  Created by zhaoyue on 16/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CourseInfo.h"

@implementation CourseInfo
@synthesize uniqueId,userName,userPassword;

-(id) initWithUseName:(NSString *)userName Password:(NSString *)userPassword{
    self = [super init];
    if(self != nil)
    {
       
    }
    return self;
}


-(void) dealloc{
  
}


@end
