//
//  GLChatInputAbleView.h
//  66GoodLook
//
//  Created by Yanci on 17/4/21.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GLChatInputAbleViewDelegate;


/**
 Able接口
 */
@protocol GLChatInputAbleView <NSObject>

@required
@property (nonatomic,weak) id<GLChatInputAbleViewDelegate> chatDelegate;

@end

/**
 Able委托
 */
@protocol GLChatInputAbleViewDelegate <NSObject>
@optional
- (void)onChatInputSendImage:(UIView<GLChatInputAbleView> *)chatInput;
- (void)onChatInputTakePhoto:(UIView<GLChatInputAbleView> *)chatInput;
- (void)onChatInputSendFile:(UIView<GLChatInputAbleView> *)chatInput;
- (void)onChatInputRecordVideo:(UIView<GLChatInputAbleView> *)chatInput;
@end
