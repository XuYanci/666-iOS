//
//  GLPickPictureViewCollectionView.h
//  66GoodLook
//
//  Created by Yanci on 17/4/28.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    GLPickPicVidType_Pic,
    GLPickPicVidType_Vid,
} GLPickPicVidCVType;

@interface GLPickPicVidViewCollectionViewCell : UICollectionViewCell {
}
@property (nonatomic,assign) GLPickPicVidCVType *pickPicVidCVType;
@property (nonatomic,strong) UIImage *image;
@end
