#import "XYAppAutoSizeScale.h"

#define SCREEN_ADAPTER_IPHONE5                  0
#define SCREEN_ADAPTER_IPHONE6                  1
#define SCREEN_ADAPTER_BASE                     SCREEN_ADAPTER_IPHONE6


CGSize DesignSizeScreenSize(AppDesignSize designSize){
    switch (designSize) {
        case DesignSizeIPhone4:
            return CGSizeMake(320, 480);
        case DesignSizeIPhone5:
            return CGSizeMake(320, 567);
        case DesignSizeIPhone6:
            return CGSizeMake(375, 667);
        case DesignSizeIPhone6Plus:
            return CGSizeMake(540, 960);
        default:
            break;
    }
}

CGFloat autoSizeVertical_d(CGFloat designValue,AppDesignSize designSize){
    return [UIScreen mainScreen].bounds.size.height/DesignSizeScreenSize(designSize).height * designValue;
}
CGFloat autoSizeVertical(CGFloat designValue){
    return autoSizeVertical_d(designValue,DesignSizeIPhone6);
}
CGFloat autoSizeHorizontal_d(CGFloat designValue,AppDesignSize designSize){
    return [UIScreen mainScreen].bounds.size.width/DesignSizeScreenSize(designSize).width * designValue;
}
CGFloat autoSizeHorizontal(CGFloat designValue){
    return autoSizeHorizontal_d(designValue,DesignSizeIPhone6);
}


CGFloat autoSizeScale()
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
#if (SCREEN_ADAPTER_BASE == SCREEN_ADAPTER_IPHONE5)
        /* 往上适配 */
        if ([[UIScreen mainScreen] bounds].size.height > 568.f) {
            return MIN(autoSizeScaleX(), autoSizeScaleY());
        }
#elif (SCREEN_ADAPTER_BASE == SCREEN_ADAPTER_IPHONE6)
        /* 往下适配 */
        if ([[UIScreen mainScreen] bounds].size.height > 480.f) {
            return MIN(autoSizeScaleX(), autoSizeScaleY());
        }
#endif
        
        return 1.0f;
    }
    else
        return 1.0f;
}

CGFloat autoSizeScaleX()
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        
#if (SCREEN_ADAPTER_BASE == SCREEN_ADAPTER_IPHONE5)
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        CGFloat autoSizeScaleX = 1.0f;
        
        if ([[UIScreen mainScreen] bounds].size.height > 480.0f) {
            autoSizeScaleX = screenWidth / 320.0f;
        }
        return autoSizeScaleX;
        
#elif (SCREEN_ADAPTER_BASE == SCREEN_ADAPTER_IPHONE6)
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        CGFloat autoSizeScaleX = 320.0 / 375.0 ;  /*! 以 iphone5 scale 为最小尺寸 */
        
        /*! if iphone > iphone5 , change scale */
        if ([[UIScreen mainScreen] bounds].size.height > 568.0f) {
            autoSizeScaleX = screenWidth / 375.0;
        }
        return autoSizeScaleX;
#endif
        
    }
    else
        return 1.0f;
    
    
}

CGFloat autoSizeScaleY()
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
#if (SCREEN_ADAPTER_BASE == SCREEN_ADAPTER_IPHONE5)
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        CGFloat autoSizeScaleY = 1.0f;
        if (screenHeight > 480.0f) {
            autoSizeScaleY = screenHeight / 568.0f;
        }
        return autoSizeScaleY;
#elif  (SCREEN_ADAPTER_BASE == SCREEN_ADAPTER_IPHONE6)
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        CGFloat autoSizeScaleY = 568.0 / 667.0;  /*! iphone5 scale */
        
        /*! if iphone > iphone5 , change scale */
        if (screenHeight > 568.0) {
            autoSizeScaleY = screenHeight / 667.0;
        }
        return autoSizeScaleY;
#endif
    }
    else
        return 1.0f;
}

CGFloat scaleX(CGFloat value)
{
    return value * autoSizeScaleX();
}

CGFloat scaleY(CGFloat value)
{
    return value * autoSizeScaleY();
}



