//
//  GLDynamicImageContainer.m
//  666
//
//  Created by Yanci on 2017/6/19.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLDynamicImageContainer.h"

@interface GLDynamicImageContainer()
@property (nonatomic,strong) NSArray <NSURL *> *images;

@end

@implementation GLDynamicImageContainer

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews {
    
    switch (_images.count) {
        case 1: {
            UIImageView *imageView = [self.subviews firstObject];
            imageView.frame = self.bounds;
        }
            break;
        case 2: {
            UIImageView *firstImageView = [self.subviews firstObject];
            UIImageView *secondImageView = [self.subviews lastObject];
            
            CGFloat width = self.bounds.size.width;
            CGFloat height = self.bounds.size.height;
            
            firstImageView.frame = CGRectMake(0,
                                              0,
                                              width / 2.0 - 5.0,
                                              height);
            
            secondImageView.frame = CGRectMake(width / 2.0 + 5.0,
                                               0,
                                               width / 2.0 - 5.0,
                                               height);
            
        }
            break;
        case 3: {
            UIImageView *firstImageView = [self.subviews firstObject];
            UIImageView *secondImageView = [self.subviews objectAtIndex:1];
            UIImageView *thirdImageView = [self.subviews objectAtIndex:2];
            CGFloat width = self.bounds.size.width;
            CGFloat height = self.bounds.size.height;
            
            firstImageView.frame = CGRectMake(0,
                                              0,
                                              width / 2.0 - 5.0,
                                              height);
            
            secondImageView.frame = CGRectMake(width / 2.0 + 5.0,
                                               0,
                                               width / 2.0 - 5.0,
                                               height / 2.0 - 5.0);
            
            thirdImageView.frame = CGRectMake(width / 2.0 + 5.0,
                                              height / 2.0 + 5.0,
                                              width / 2.0 - 5.0,
                                              height / 2.0 - 5.0);
            
        }
            break;
        case 4: {
            UIImageView *firstImageView = [self.subviews firstObject];
            UIImageView *secondImageView = [self.subviews objectAtIndex:1];
            UIImageView *thirdImageView = [self.subviews objectAtIndex:2];
            UIImageView *fourImageView = [self.subviews objectAtIndex:3];
            
            CGFloat width = self.bounds.size.width;
            CGFloat height = self.bounds.size.height;
            
            firstImageView.frame = CGRectMake(0,
                                              0,
                                              width / 2.0 - 5.0,
                                              height / 2.0 - 5.0);
            
            secondImageView.frame = CGRectMake(0,
                                              height / 2.0 + 5.0,
                                              width / 2.0 - 5.0,
                                              height / 2.0 - 5.0);
            
            thirdImageView.frame = CGRectMake(width / 2.0 + 5.0,
                                               0,
                                               width / 2.0 - 5.0,
                                               height / 2.0 - 5.0);
            
            fourImageView.frame = CGRectMake(width / 2.0 + 5.0,
                                              height / 2.0 + 5.0,
                                              width / 2.0 - 5.0,
                                              height / 2.0 - 5.0);
   
        }
            break;
        default:
            break;
    }
    
    
}

- (void)setDynamicImages:(NSArray <NSURL *> *)images {
    _images = images;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    switch (images.count) {
        case 1:
        {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.layer.cornerRadius = 5.0;
            imageView.layer.masksToBounds = YES;
            [imageView setImageWithURL:[images firstObject] placeholder:[UIImage imageWithColor:[UIColor redColor]]];
            [self addSubview:imageView];
        }
            break;
        case 2:
        {
            UIImageView *firstImageView = [[UIImageView alloc]init];
            firstImageView.layer.cornerRadius = 5.0;
            firstImageView.layer.masksToBounds = YES;
            UIImageView *secondImageView = [[UIImageView alloc]init];
            secondImageView.layer.cornerRadius = 5.0;
            secondImageView.layer.masksToBounds = YES;
            [self addSubview:firstImageView];
            [self addSubview:secondImageView];
            
            [firstImageView setImageWithURL:[images firstObject] placeholder:[UIImage imageWithColor:[UIColor redColor]]];
            
            [secondImageView setImageWithURL:[images lastObject] placeholder:[UIImage imageWithColor:[UIColor greenColor]]];
        }
            break;
        case 3:
        {
            UIImageView *firstImageView = [[UIImageView alloc]init];
            firstImageView.layer.cornerRadius = 5.0;
            firstImageView.layer.masksToBounds = YES;
            UIImageView *secondImageView = [[UIImageView alloc]init];
            secondImageView.layer.cornerRadius = 5.0;
            secondImageView.layer.masksToBounds = YES;
            
            UIImageView *thirdImageView = [[UIImageView alloc]init];
            thirdImageView.layer.cornerRadius = 5.0;
            thirdImageView.layer.masksToBounds = YES;
            
            [self addSubview:firstImageView];
            [self addSubview:secondImageView];
            [self addSubview:thirdImageView];
            
            [firstImageView setImageWithURL:[images firstObject] placeholder:[UIImage imageWithColor:[UIColor redColor]]];
            
            [secondImageView setImageWithURL:[images lastObject] placeholder:[UIImage imageWithColor:[UIColor greenColor]]];
            
            [thirdImageView setImageWithURL:[images lastObject] placeholder:[UIImage imageWithColor:[UIColor blueColor]]];
            
        }
            break;
        case 4:
        {
            UIImageView *firstImageView = [[UIImageView alloc]init];
            firstImageView.layer.cornerRadius = 5.0;
            firstImageView.layer.masksToBounds = YES;
            UIImageView *secondImageView = [[UIImageView alloc]init];
            secondImageView.layer.cornerRadius = 5.0;
            secondImageView.layer.masksToBounds = YES;
            UIImageView *thirdImageView = [[UIImageView alloc]init];
            thirdImageView.layer.cornerRadius = 5.0;
            thirdImageView.layer.masksToBounds = YES;
            UIImageView *fourImageView = [[UIImageView alloc]init];
            fourImageView.layer.cornerRadius = 5.0;
            fourImageView.layer.masksToBounds = YES;
            
            [self addSubview:firstImageView];
            [self addSubview:secondImageView];
            [self addSubview:thirdImageView];
            [self addSubview:fourImageView];
            
            [firstImageView setImageWithURL:[images firstObject] placeholder:[UIImage imageWithColor:[UIColor redColor]]];
            
            [secondImageView setImageWithURL:[images lastObject] placeholder:[UIImage imageWithColor:[UIColor greenColor]]];
            
            [thirdImageView setImageWithURL:[images lastObject] placeholder:[UIImage imageWithColor:[UIColor blueColor]]];
            
             [fourImageView setImageWithURL:[images lastObject] placeholder:[UIImage imageWithColor:[UIColor yellowColor]]];
            
        }
            break;
        default:
            break;
    }
    
    [self setNeedsLayout];
}

@end
