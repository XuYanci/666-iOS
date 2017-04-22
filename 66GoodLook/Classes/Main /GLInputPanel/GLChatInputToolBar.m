//
//  GLChatInputToolBar.m
//  66GoodLook
//
//  Created by Yanci on 17/4/20.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLChatInputToolBar.h"
#import <Masonry/Masonry.h>

typedef enum : NSUInteger {
    GLChatInputToolBarRightButtonBarType_Default,
    GLChatInputToolBarRightButtonBarType_Emoj,
    GLChatInputToolBarRightButtonBarType_Keyboard = GLChatInputToolBarRightButtonBarType_Default,
} GLChatInputToolBarRightButtonBarType;



@interface GLChatInputToolBar()
@property (nonatomic,strong) UIButton *picBtn;
@property (nonatomic,strong) UIButton *videoBtn;
@property (nonatomic,strong) UIButton *emojBtn;
@property (nonatomic,strong) UIButton *sendBtn;
@property (nonatomic,strong) UITextField *inputTextField;
@property (nonatomic,assign) GLChatInputToolBarType barType;
@property (nonatomic,assign) GLChatInputToolBarRightButtonBarType rightButtonBarType;
@end

@implementation GLChatInputToolBar {
    BOOL _needsReload;  /*! 需要重载 */
    struct {
    }_datasourceHas;    /*! 数据源存在标识 */
    struct {
    }_delegateHas;      /*! 数据委托存在标识 */
}

#pragma mark - life cycle
- (id)initWithBarType:(GLChatInputToolBarType)barType {
    if (self = [super init]) {
        _barType = barType;
        _rightButtonBarType = GLChatInputToolBarRightButtonBarType_Default;
        [self commonInit];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setNeedsReload];
    }
    return self;
}

- (void)layoutSubviews {
    [self _reloadDataIfNeeded];
    [super layoutSubviews];
}

#pragma mark - datasource
#pragma mark - delegate
#pragma mark - user events
- (void)showEmojPanel:(id)sender {
    
}

- (void)showKeyboardPanel:(id)sender {
    
}

- (void)showVideoPanel:(id)sender {
    
}

- (void)showPicPanel:(id)sender {
    
}

#pragma mark - functions


- (void)commonInit {
    [self addSubview:self.picBtn];
    [self addSubview:self.videoBtn];
    [self addSubview:self.emojBtn];
    [self addSubview:self.sendBtn];
    [self addSubview:self.inputTextField];
    
    [self.picBtn setImage:[UIImage imageNamed:@"shuru_images_icon"]
                 forState:UIControlStateNormal];
    [self.picBtn addTarget:self action:@selector(showPicPanel:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.videoBtn setImage:[UIImage imageNamed:@"shuru_shipin_icon"]
                   forState:UIControlStateNormal];
    [self.videoBtn addTarget:self action:@selector(showVideoPanel:)
            forControlEvents:UIControlEventTouchUpInside];
    
    [self.emojBtn setImage:[UIImage imageNamed:@"shuru_biaoqing_icon"] forState:UIControlStateNormal];
    [self.sendBtn setImage:[UIImage imageNamed:@"shuru_fasong_01"] forState:UIControlStateNormal];
    
    if (self.rightButtonBarType == GLChatInputToolBarRightButtonBarType_Default) {
        [self setKeyBoardBtn];
    }
    else {
        [self setEmojBtn];
    }
    
    
    [self.picBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10.0);
        make.width.offset(35.0);
        make.height.offset(35.0);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.width.offset(35.0);
        make.height.offset(35.0);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.emojBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.sendBtn.mas_left).offset(-10);
        make.width.offset(35.0);
        make.height.offset(35.0);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.picBtn.mas_right).offset(10);
        make.right.mas_equalTo(self.emojBtn.mas_left).offset(-10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.offset(35.0);
    }];
    
    [self.inputTextField becomeFirstResponder];

}

- (void)setBarType:(GLChatInputToolBarType)barType {
    _barType = barType;
}

- (BOOL)isEditing {
    return [self.inputTextField isFirstResponder];
}

- (CGFloat)contentHeight {
    return 44.0;
}

- (void)setEmojBtn {
     [self.emojBtn setImage:[UIImage imageNamed:@"shuru_biaoqing_icon"]
                   forState:UIControlStateNormal];
    [self.emojBtn removeTarget:self action:@selector(showKeyboardPanel:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.emojBtn addTarget:self action:@selector(showEmojPanel:)
           forControlEvents:UIControlEventTouchUpInside];
}

- (void)setKeyBoardBtn {
     [self.emojBtn setImage:[UIImage imageNamed:@"shuru_jianpan_icon"]
                   forState:UIControlStateNormal];
    [self.emojBtn removeTarget:self action:@selector(showEmojPanel:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.emojBtn addTarget:self action:@selector(showKeyboardPanel:)
           forControlEvents:UIControlEventTouchUpInside];
}

- (void)setDataSource:(id<GLChatInputBaseViewDataSource>)dataSource {}

- (void)setDelegate:(id<GLChatInputBaseViewDelegate>)delegate {}

- (void)setNeedsReload {
    _needsReload = YES;
    [self setNeedsLayout];
}
- (void)_reloadDataIfNeeded {
    if (_needsReload) {
        [self reloadData];
    }
}
- (void)reloadData {}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}


#pragma mark - notification

#pragma mark - getter and setter
- (UIButton *)picBtn {
    if (!_picBtn) {
        _picBtn = [[UIButton alloc]init];
    }
    return _picBtn;
}

- (UIButton *)videoBtn {
    if (!_videoBtn) {
        _videoBtn = [[UIButton alloc]init];
    }
    return _videoBtn;
}

- (UIButton *)emojBtn {
    if (!_emojBtn) {
        _emojBtn = [[UIButton alloc]init];
    }
    return _emojBtn;
}

- (UIButton *)sendBtn {
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc]init];
    }
    return _sendBtn;
}

- (UITextField *)inputTextField {
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc]init];
        _inputTextField.layer.cornerRadius = 5.0;
        _inputTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _inputTextField.layer.borderWidth = 0.3;
    }
    return _inputTextField;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
