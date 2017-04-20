//
//  GLChatInputPanel.h
//  66GoodLook
//
//  Created by Yanci on 17/4/20.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLChatInputBaseView.h"

@protocol GLChatInputPanelDataSource <NSObject>
@end

@protocol GLChatInputPanelDelegate <NSObject>

@end

/*!
 @class GLChatInputPanel
 
 @brief The UIView class
 
 @discussion    聊天输入面板
 
 @superclass SuperClass: GLChatInputBaseView\n
 @classdesign    No special design is applied here.
 @coclass    None
 @helps It helps no other classes.
 @helper    No helper exists for this class.
 */
@interface GLChatInputPanel : GLChatInputBaseView

@end


