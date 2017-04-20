//
//  GLChatInputToolBar.h
//  66GoodLook
//
//  Created by Yanci on 17/4/20.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLChatInputBaseView.h"

@protocol GLChatInputToolBarDataSource <NSObject>
@end

@protocol GLChatInputToolBarDelegate <NSObject>
@end


/*!
 @class GLChatInputToolBar
 
 @brief The UIView class
 
 @discussion    聊天输入工具框
 
 @superclass SuperClass: GLChatInputBaseView\n
 @classdesign    No special design is applied here.
 @coclass    None
 @helps It helps no other classes.
 @helper    No helper exists for this class.
 */
@interface GLChatInputToolBar : GLChatInputBaseView
@end
