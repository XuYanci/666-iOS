//
//  GLRefreshFooter.m
//  666
//
//  Created by Yanci on 17/6/1.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLRefreshFooter.h"

@implementation GLRefreshFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)prepare {
    [super prepare];
    
    NSArray *array = @[
                       
                       [UIImage imageNamed:@"xiala_jiazai_01"],
                       [UIImage imageNamed:@"xiala_jiazai_02"],
                       [UIImage imageNamed:@"xiala_jiazai_03"],
                       [UIImage imageNamed:@"xiala_jiazai_04"],
                       [UIImage imageNamed:@"xiala_jiazai_05"],
                       [UIImage imageNamed:@"xiala_jiazai_06"],
                       [UIImage imageNamed:@"xiala_jiazai_07"],
                       [UIImage imageNamed:@"xiala_jiazai_08"],
                       [UIImage imageNamed:@"xiala_jiazai_09"],
                       [UIImage imageNamed:@"xiala_jiazai_10"],
                       ];
    [self setImages:array forState:MJRefreshStateRefreshing];
    self.refreshingTitleHidden = YES;
    self.automaticallyRefresh = YES;
    self.automaticallyHidden = YES;
}


@end
