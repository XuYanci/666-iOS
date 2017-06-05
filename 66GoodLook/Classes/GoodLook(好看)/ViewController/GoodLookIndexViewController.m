//
//  GoodLookIndexViewController.m
//  66GoodLook
//
//  Created by Yanci on 17/4/12.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GoodLookIndexViewController.h"
#import "GoodLookBaseViewController.h"
#import "GoodLookWellChosenViewController.h"
#import "GoodLookFloatView.h"
#import "GLChatInputPanel.h"

NSString* const  kNotificationShowNaviBar = @"notif_showNaviBar";
NSString* const  kNotificationHideNaviBar = @"notif_hideNaviBar";

@interface GoodLookIndexViewController ()<GLViewPagerViewControllerDataSource,GLViewPagerViewControllerDelegate,GoodLookFloatViewDelegate>
@property (nonatomic,strong)NSMutableArray *viewControllers;
@property (nonatomic,strong)NSMutableArray *tagTitles;
@property (nonatomic,strong)GoodLookFloatView *floatView;
@property (nonatomic,strong)GLChatInputPanel *inputPanel;
@property (nonatomic,strong)GLGetDefaultTopicListResponse *response;
@end

@implementation GoodLookIndexViewController {
    BOOL _showNaviBar;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"666";
    _showNaviBar = YES;
    // Do any additional setup after loading the view.
    self.dataSource = self;
    self.delegate = self;
    self.fixTabWidth = NO;
    self.padding = 10;
    self.leadingPadding = 10;
    self.trailingPadding = 10;
    self.defaultDisplayPageIndex = 0;
    self.tabAnimationType = GLTabAnimationType_whileScrolling;
    self.indicatorColor = [UIColor colorWithRed:255.0/255.0 green:205.0 / 255.0 blue:0.0 alpha:1.0];
    
    GoodLookBaseViewController *concernViewController = [[GoodLookBaseViewController alloc]init];
    GoodLookWellChosenViewController *wellChosenViewController = [[GoodLookWellChosenViewController alloc]init];
 
    
    /** 设置内容视图 */
    self.viewControllers = [ NSMutableArray array];
    [self.viewControllers addObject:concernViewController];
    [self.viewControllers addObject:wellChosenViewController];
    
    /** 设置标签标题 */
    self.tagTitles = [NSMutableArray array];
    [self.tagTitles addObject:@"关注"];
    [self.tagTitles addObject:@"精选"];
    
    /** 添加悬浮视图 */
    [self.view addSubview:self.floatView];
    [self.floatView resetPosition];
    
    /** 加载请求 */
    [self loadRequest];
    
    /** Add notification */
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(animationHideNaviBar)
                                                name:kNotificationHideNaviBar
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(animationShowNaviBar)
                                                name:kNotificationShowNaviBar
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(animationShowNaviBar)
                                                name:UIApplicationDidBecomeActiveNotification object:nil];
   
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)animationHideNaviBar {
    NSLog(@"animationHideNaviBar");

    // Here has a funny thing , if you change navigationbar height , and change view height will not effective, but change navbar transitionview will effective.
    if (_showNaviBar) {
        [UIView animateWithDuration:0.5 animations:^{
            self.navigationController.navigationBar.height = 1.0;
            UIView* navBarTransitionView = [self.navigationController.view.subviews objectAtIndex:0];
            CGRect rect = navBarTransitionView.frame;
            rect.origin.y -= 44.0;
            rect.size.height += 44.0;
            navBarTransitionView.frame = rect;
            [self.floatView setNaviBarHidden:YES];
            [self.floatView updatePosition:self.floatView.frame.origin];
        } completion:^(BOOL finished) {
            
            [self.navigationController.navigationBar setTitleTextAttributes:
             @{NSForegroundColorAttributeName:[UIColor colorWithWhite:0 alpha:0.0]}];
        }];
        _showNaviBar = NO;
    }
}

- (void)animationShowNaviBar {
    NSLog(@"animationShowNaviBar");
    
    if (!_showNaviBar) {
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor colorWithWhite:0 alpha:1.0]}];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.navigationController.navigationBar.height = 44.0;
            UIView* navBarTransitionView = [self.navigationController.view.subviews objectAtIndex:0];
            CGRect rect = navBarTransitionView.frame;
            rect.origin.y += 44.0;
            rect.size.height -= 44.0;
            navBarTransitionView.frame = rect;
            [self.floatView setNaviBarHidden:NO];
            [self.floatView updatePosition:self.floatView.frame.origin];
        } completion:^(BOOL finished) {
        }];
        _showNaviBar = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - GLViewPagerViewControllerDataSource
- (NSUInteger)numberOfTabsForViewPager:(GLViewPagerViewController *)viewPager {
    return self.viewControllers.count;
}

- (UIView *)viewPager:(GLViewPagerViewController *)viewPager
      viewForTabIndex:(NSUInteger)index {
    UILabel *label = [[UILabel alloc]init];
    label.text = [self.tagTitles objectAtIndex:index];
    label.font = [UIFont systemFontOfSize:16.0];
    label.textColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    label.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    return label;
}

- (UIViewController *)viewPager:(GLViewPagerViewController *)viewPager
contentViewControllerForTabAtIndex:(NSUInteger)index {
    return self.viewControllers[index];
}
#pragma mark - GLViewPagerViewControllerDelegate
- (void)viewPager:(GLViewPagerViewController *)viewPager didChangeTabToIndex:(NSUInteger)index fromTabIndex:(NSUInteger)fromTabIndex {
    UILabel *prevLabel = (UILabel *)[viewPager tabViewAtIndex:fromTabIndex];
    UILabel *currentLabel = (UILabel *)[viewPager tabViewAtIndex:index];
    prevLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    currentLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    prevLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    currentLabel.textColor = [UIColor colorWithWhite:0.0 alpha:1.0];
}

- (void)viewPager:(GLViewPagerViewController *)viewPager willChangeTabToIndex:(NSUInteger)index fromTabIndex:(NSUInteger)fromTabIndex withTransitionProgress:(CGFloat)progress {
    
    if (fromTabIndex == index) {
        return;
    }
    
    UILabel *prevLabel = (UILabel *)[viewPager tabViewAtIndex:fromTabIndex];
    UILabel *currentLabel = (UILabel *)[viewPager tabViewAtIndex:index];
    prevLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity,
                                                 1.0 - (0.1 * progress),
                                                 1.0 - (0.1 * progress));
    currentLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity,
                                                    0.9 + (0.1 * progress),
                                                    0.9 + (0.1 * progress));
    prevLabel.textColor = [UIColor colorWithWhite:0.0 alpha:1.0 - (0.5 * progress)];
    currentLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.5 + (0.5 * progress)];
}

- (CGFloat)viewPager:(GLViewPagerViewController *)viewPager widthForTabIndex:(NSUInteger)index {
    static UILabel *prototypeLabel ;
    if (!prototypeLabel) {
        prototypeLabel = [[UILabel alloc]init];
    }
    prototypeLabel.text = [self.tagTitles objectAtIndex:index];
    prototypeLabel.textAlignment = NSTextAlignmentCenter;
    prototypeLabel.font = [UIFont systemFontOfSize:16.0];
    return prototypeLabel.intrinsicContentSize.width;
}


#pragma mark - GoodLookFloatViewDelegate
- (void)floatView:(id)sender didPickEdit:(GLEditType)editType {
    [self animationShowNaviBar];
    
    if (editType == GLEditText) {
        [self.inputPanel setPanelType:GLChatInputPanelType_Text];
        [self.inputPanel show];
    }
    else if(editType == GLEditUploadPic) {
        [self.inputPanel setPanelType:GLChatInputPanelType_Image];
        [self.inputPanel show];
    }
    else if(editType == GLEditUploadVideo) {
        [self.inputPanel setPanelType:GLChatInputPanelType_Video];
        [self.inputPanel show];
    }
}

#pragma mark - funcs
- (void)loadRequest {
    GLGetDefaultTopicListRequest *request = [[GLGetDefaultTopicListRequest alloc]init];
    [MXNetworkConnection sendGetRequestWithMethod:@"getDefaultTopicList"
                                     requestModel:request
                                    responseClass:[GLGetDefaultTopicListResponse class] beforeSendCallback:^{
                                        
                                    } SuccessCallBack:^(GLGetDefaultTopicListResponse *result) {
                                        _response = result;
                                        [self processResponse];
                                    } ErrorCallback:^(NSError *error) {
                                        [self showHintHudWithMessage:error.localizedDescription];
                                    } CompleteCallback:^(NSError *error, id result) {
                                        
                                    }];
}

- (void)processResponse {
    [self.viewControllers removeAllObjects];
    [self.tagTitles removeAllObjects];
    GoodLookBaseViewController *concernViewController = [[GoodLookBaseViewController alloc]init];
    GoodLookWellChosenViewController *wellChosenViewController = [[GoodLookWellChosenViewController alloc]init];
    [self.viewControllers addObject:concernViewController];
    [self.viewControllers addObject:wellChosenViewController];
    [self.tagTitles addObject:@"关注"];
    [self.tagTitles addObject:@"精选"];
    
    NSArray *sortedArray =  [_response.result sortedArrayUsingComparator:^NSComparisonResult(GLGetDefaultTopicListModel* obj1,   GLGetDefaultTopicListModel* obj2) {
        return (obj1.ID.intValue > obj2.ID.intValue);
    }];
    
    [sortedArray enumerateObjectsUsingBlock:^(GLGetDefaultTopicListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GoodLookBaseViewController *viewController = [[GoodLookBaseViewController alloc]init];
        viewController.model = obj;
        [self.viewControllers addObject:viewController];
        [self.tagTitles addObject:obj.title];
    }];
    [self reloadData];
}

#pragma mark - getter and setter
- (GoodLookFloatView *)floatView {
    if (!_floatView) {
        _floatView = [[GoodLookFloatView alloc]init];
        _floatView.frame = CGRectMake(0, 64.0 + self.tabHeight, 44, 44);
        _floatView.backgroundColor = [UIColor clearColor];
        _floatView.delegate = self;
    }
    return _floatView;
}

- (GLChatInputPanel *)inputPanel {
    if (!_inputPanel) {
        _inputPanel = [[GLChatInputPanel alloc]init];
    }
    return _inputPanel;
}

@end
