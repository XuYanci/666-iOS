//
//  GLAssetLibrary.h
//  66GoodLook
//
//  Created by Yanci on 17/4/28.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

/*!
 @class GLAssetLibrary
 @brief The NSObject class
 @discussion   资源库管理器 (图片 视频)
 @superclass SuperClass: NSObject\n
 @classdesign    single responsability pattern
 @coclass    No coclass
 @helps It helps no other classes.
 @helper    No helper exists for this class.
 */
@interface GLAssetLibraryManager : NSObject

// 思路整理(功能需求):
// 1. 获取全部视频
// 2. 获取指定分类视频
// 3. 获取全部图片
// 4. 获取指定分类图片
// 5. 能获取指定图片尺寸 (小图，大图)
// 6. 监听图片和视频的变化 (增加 删除)
// 7. 请求访问权限

/**
 GLAssetLibrary instance

 @return the instance of the GLAssetLibrary
 */
+ (instancetype)shareInstance;




@end
