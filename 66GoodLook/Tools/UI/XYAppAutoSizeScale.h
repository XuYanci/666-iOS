#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    DesignSizeIPhone6,
    DesignSizeIPhone6Plus,
    DesignSizeIPhone5,
    DesignSizeIPhone4
} AppDesignSize;

CGFloat autoSizeVertical_d(CGFloat designValue,AppDesignSize designSize);
CGFloat autoSizeVertical(CGFloat designValue);
CGFloat autoSizeHorizontal_d(CGFloat designValue,AppDesignSize designSize);
CGFloat autoSizeHorizontal(CGFloat designValue);

CGFloat autoSizeScale();
CGFloat autoSizeScaleX();
CGFloat autoSizeScaleY();
CGFloat scaleX(CGFloat value);
CGFloat scaleY(CGFloat value);
