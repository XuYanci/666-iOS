//
//  GLQiniuImageHelper.m
//  666
//
//  Created by Yanci on 2017/6/20.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLQiniuImageHelper.h"

@implementation GLQiniuImageHelper



//** 基本裁剪 **
//http://7xj5zf.com2.z0.glb.qiniucdn.com/o_1binr4819eqi1sv4uln1tr15gsg.jpg?imageView2/1/format/webp/quality/60/w/620/h/349/
+ (NSString *)imageView2:(NSString *)baseUrl
               imagePath:(NSString *)imagePath
                  format:(NSString *)format
                 quality:(NSString *)quality
                   width:(NSString *)width
                  height:(NSString *)height {
    return [NSString stringWithFormat:@"%@/%@?imageView2/1/format/%@/quality/%@/w/%@/h/%@/",baseUrl,imagePath,format,quality,width,height];
}

 
//** 复杂裁剪 **
//http://7xj5zf.com2.z0.glb.qiniucdn.com/b74833f9-b42d-4987-91a3-325a57f73e93?imageMogr2/crop/!720x800a0a480/format/webp/quality/60/thumbnail/306.00x348.75
+ (NSString *)imageMogr2:(NSString *)baseUrl
               imagePath:(NSString *)imagePath
               cropWidth:(NSString *)cropWidth
              cropHeight:(NSString *)cropHeight
                  startX:(NSString *)startX
                  startY:(NSString *)startY
                  format:(NSString *)format
                 quality:(NSString *)quality
          thumbnailWidth:(NSString *)thumbnailWidth
         thumbnailHeight:(NSString *)thumbnailHeight {
    return [NSString stringWithFormat:@"%@/%@?imageMogr2/crop/!%@x%@a%@a%@/format/%@/quality/%@/thumbnail/%@x%@",baseUrl,imagePath,cropWidth,cropHeight,startX,startY,format,quality,thumbnailWidth,thumbnailHeight];
}


/**
 视频裁剪
 */
//http://7xj5zf.com2.z0.glb.qiniucdn.com/4ce6cccaf80acefc8395a33342f80540?vframe/jpg/offset/1.5/rotate/auto/

+ (NSString *)vframe:(NSString *)baseUrl imagePath:(NSString *)imagePath {
    return [NSString stringWithFormat:@"%@/%@?vframe/jpg/offset/1.5/rotate/auto/",baseUrl,imagePath];
}

@end
