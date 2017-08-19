//
//  GLQiniuImageHelper.h
//  666
//
//  Created by Yanci on 2017/6/20.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLQiniuImageHelper : NSObject

+ (NSString *)imageView2:(NSString *)baseUrl
               imagePath:(NSString *)imagePath
                  format:(NSString *)format
                 quality:(NSString *)quality
                   width:(NSString *)width
                  height:(NSString *)height;

+ (NSString *)imageMogr2:(NSString *)baseUrl
               imagePath:(NSString *)imagePath
               cropWidth:(NSString *)cropWidth
              cropHeight:(NSString *)cropHeight
                  startX:(NSString *)startX
                  startY:(NSString *)startY
                  format:(NSString *)format
                 quality:(NSString *)quality
          thumbnailWidth:(NSString *)thumbnailWidth
         thumbnailHeight:(NSString *)thumbnailHeight;

+ (NSString *)vframe:(NSString *)baseUrl imagePath:(NSString *)imagePath;
@end
