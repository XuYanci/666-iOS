//
//  GLChatInputPanel.m
//  66GoodLook
//
//  Created by Yanci on 17/4/20.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLChatInputPanel.h"
#import "GLChatInputAbleView.h"
#import "GLChatInputToolBar.h"
#import "GLPickVideoCollectionView.h"
#import "GLPickPictureCollectionView.h"
#import "GLPickEmojView.h"

@interface GLChatInputPanel()<GLChatInputToolBarDelegate>
/** 工具栏 */
@property (nonatomic,strong) GLChatInputToolBar *toolbar;
/** 当前面板 */
@property (nonatomic,weak)  UIView<GLChatInputAbleView> *panel;
/** 视频选择器,作为Pannel */
@property (nonatomic,strong) UIView<GLChatInputAbleView> *pickVideoCollectionView;
/** 图片选择器,作为Pannel */
@property (nonatomic,strong) UIView<GLChatInputAbleView> *pickPictureCollectionView;
/** 表情选择器,作为Pannel */
@property (nonatomic,strong) UIView<GLChatInputAbleView> *pickEmojView;
@end

@implementation GLChatInputPanel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
