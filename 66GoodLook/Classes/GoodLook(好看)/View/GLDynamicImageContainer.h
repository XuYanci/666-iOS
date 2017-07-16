//
//  GLDynamicImageContainer.h
//  666
//
//  Created by Yanci on 2017/6/19.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLDynamicImageContainer : UIView
- (void)setDynamicImages:(NSArray <NSURL *> *)images;
- (NSArray <NSURL *> *)getDynamicImages;
 

@end
