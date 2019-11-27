//
//  ZFAlertController.m
//  ZFAlertController
//
//  Created by Pokey on 2019/9/23.
//  Copyright © 2019 Pokey. All rights reserved.
//

#import "ZFAlertController.h"
#import <objc/runtime.h>

#define ZF_SCREEN_WIDTH self.view.frame.size.width

static int NOMAL_ALERT_WIDTH = 270;
static int NOMAL_CONTENT_MARGIN = 10;
static int NOMAL_KEYBOARD_JUDGE_MARGIN = 30;
static int NOMAL_KEYBOARD_SPACE_MARGIN = 50;

static inline BOOL isIPhoneXSeries() {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    
    return iPhoneXSeries;
}

typedef void(^actionCallback)(void);


@interface ZFAlertAction ()
@property(nonatomic, copy) actionCallback action;
@end

@implementation ZFAlertAction

+ (instancetype)actionWithTitle:(NSString *)title action:(void (^)(void))action {
    return [[ZFAlertAction alloc] initWithTitle:title action:action];
}

- (instancetype)initWithTitle:(NSString *)title action:(void (^)(void))action
{
    self = [super init];
    if (self) {
        self.action = action;
        self.titleText = title;
        self.titleColor = ZFALERT_BLACKCLOLR;
        self.titleFont = [UIFont systemFontOfSize:16];
        self.separatoColor = ZFALERT_LINE_COLOR;
        self.verticalSpaceMargin = .5f;
        self.horizontalSpaceMargin = NOMAL_CONTENT_MARGIN;
    }
    return self;
}

@end

@interface UIView (Custom)
@property(nonatomic, copy) NSString *customIdentify;
@end

@implementation UIView (Custom)

- (void)setCustomIdentify:(NSString *)customIdentify {
    objc_setAssociatedObject(self, @"customIdentify", customIdentify, OBJC_ASSOCIATION_COPY);
}
- (NSString *)customIdentify {
    return objc_getAssociatedObject(self, @"customIdentify");
}
@end

@interface ZFAlertController ()

@property(nonatomic, assign) ZFAlertControllerStyle style;
@property (nonatomic, strong) UIButton *coverButton;
@property (nonatomic, strong, readwrite) UIView *contentView;
@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIView *lineHorView;
@property (nonatomic, strong) UIView *lineVecView;
@property (nonatomic, strong) UIView *bottomButtonView;

@property (nonatomic, strong) CAShapeLayer *maskLayer;

@property(nonatomic, assign) float titleHeight;
@property(nonatomic, assign) float messageHeight;

@property (nonatomic, strong) NSMutableArray *buttonsArray;
@property (nonatomic, strong) NSMutableArray *actionsArray;
@property (nonatomic, strong) NSMutableDictionary *actionCallbacks;
@property (nonatomic, strong) NSMutableArray *textFiledArray;
@property (nonatomic, strong) NSMutableDictionary *textFiledCallbacks;
@property (nonatomic, strong) NSMutableSet *customViewSet;
@property (nonatomic, strong) NSMutableDictionary *customViewConfigs;
@property (nonatomic, strong) NSMutableDictionary *customButtonActions;
@end

@implementation ZFAlertController

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message style:(ZFAlertControllerStyle)style {
    return [[ZFAlertController alloc] initWithTitle:title message:message style:style];
}

- (instancetype)initWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message style:(ZFAlertControllerStyle)style
{
    self = [super init];
    if (self) {
        
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        _backgroudColor = [UIColor colorWithWhite:0 alpha:.6];
        _contentBackgroundColor = [UIColor whiteColor];
        _titleColor = ZFALERT_BLACKCLOLR;
        _messageColor = ZFALERT_BLACKCLOLR;
        _cornerRadius = 15;
        _roundingCorners = UIRectCornerAllCorners;
        _titleFont = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        _messageFont = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
        _style = style;
        _titleText = title;
        _messageText = message;
        
        _titleSpace = NOMAL_CONTENT_MARGIN;
        _messageSpace = NOMAL_CONTENT_MARGIN;
        _textFieldSpace = NOMAL_CONTENT_MARGIN;
        _buttonsSpace = NOMAL_CONTENT_MARGIN * 1.5;
        _lineColor = ZFALERT_LINE_COLOR;
        _titleAlignment = _messageAlignment = NSTextAlignmentCenter;
        
        self.buttonsArray = [NSMutableArray arrayWithCapacity:10];
        self.actionsArray = [NSMutableArray arrayWithCapacity:10];
        self.customButtonActions = [NSMutableDictionary dictionaryWithCapacity:10];
        self.customViewSet = [NSMutableSet setWithCapacity:10];
        self.actionCallbacks = [NSMutableDictionary dictionaryWithCapacity:10];
        self.customViewConfigs = [NSMutableDictionary dictionaryWithCapacity:10];
        self.textFiledArray = [NSMutableArray arrayWithCapacity:10];
        self.textFiledCallbacks = [NSMutableDictionary dictionaryWithCapacity:10];
        self.actionSheetIgnoreXSeriesBottomInset = YES;
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
        
        self.coverButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundColor:[UIColor clearColor]];
            [button addTarget:self action:@selector(blackClicked) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
        
        self.maskLayer = [[CAShapeLayer alloc] init];
        self.contentView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            [view setBackgroundColor:self.contentBackgroundColor];
            view.layer.mask = self.maskLayer;
            view;
        });
        
        self.contentImageView = ({
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView;
        });
        [self.contentView addSubview:self.contentImageView];
        
        self.titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = self.titleFont;
            label.textColor = self.titleColor;
            label.numberOfLines = 0;
            label.text = self.titleText;
            label.textAlignment = self.titleAlignment;
            label;
        });
        [self.contentView addSubview:self.titleLabel];
        
        self.messageLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = self.messageFont;
            label.textColor = self.messageColor;
            label.numberOfLines = 0;
            label.text = self.messageText;
            label.textAlignment = self.messageAlignment;
            label;
        });
        [self.contentView addSubview:self.messageLabel];
     
        self.lineHorView = ({
            UIView *view = [[UIView alloc] init];
            [view setBackgroundColor:ZFALERT_LINE_COLOR];
            view;
        });
        [self.contentView addSubview:self.lineHorView];
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
        self.bottomButtonView = ({
            UIView *view = [[UIView alloc] init];
            view;
        });
        [self.contentView addSubview:self.bottomButtonView];
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:_backgroudColor];

    [self.view addSubview:self.coverButton];
    [self.view addSubview:self.contentView];
    
    if (_titleText.length > 0) {
        _titleHeight = [self caclulateHeightWithString:_titleText font:_titleFont];
    }
    if (_messageText > 0) {
        _messageHeight = [self caclulateHeightWithString:_messageText font:_messageFont];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.textFiledArray.count > 0) {
            UITextField *textField = self.textFiledArray[0];
            [textField becomeFirstResponder];
        }
    });
    
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.coverButton setFrame:self.view.bounds];
    
    float y = NOMAL_CONTENT_MARGIN;
    float x = NOMAL_CONTENT_MARGIN;
    float contentWidth = 0;
    switch (self.style) {
        case ZFAlertControllerStyleAlert:
            contentWidth = NOMAL_ALERT_WIDTH - NOMAL_CONTENT_MARGIN * 2;
            break;
        case ZFAlertControllerStyleActionSheet:
            contentWidth = ZF_SCREEN_WIDTH - NOMAL_CONTENT_MARGIN * 2;
            break;
    }
    
    if (self.titleText.length > 0) {
        y += self.titleSpace;
        [self.titleLabel setFrame:CGRectMake(x, y, contentWidth, self.titleHeight)];
        y += self.titleHeight;
    }
    
    if (self.messageText.length > 0) {
        if (y == 0) y += self.messageSpace;
        y += (self.messageSpace - 5);
        [self.messageLabel setFrame:CGRectMake(x, y, contentWidth, self.messageHeight)];
        y += self.messageHeight + 5;
    }
    
    if (self.textFiledArray.count > 0) {
        for (UITextField *textField in self.textFiledArray) {
            y += self.textFieldSpace;
            [textField setFrame:CGRectMake(20, y, contentWidth - 20, 35)];
            y += 30;
        }
    }

    if (self.buttonsArray.count > 0) {

        for (UIView *view in self.bottomButtonView.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                [view removeFromSuperview];
            }
        }
        x = 0;
        float btnH = 44;
        if (self.style == ZFAlertControllerStyleAlert) {
            // hor
            y += self.buttonsSpace;
            [self.lineHorView setBackgroundColor:self.lineColor];
            [self.lineHorView setFrame:CGRectMake(0, y, NOMAL_ALERT_WIDTH, 1)];
            y += 1;
            [self.bottomButtonView setFrame:CGRectMake(0, y, NOMAL_ALERT_WIDTH, 44)];
            float btnWidth = NOMAL_ALERT_WIDTH / self.buttonsArray.count;
            for (int i = 0; i < self.buttonsArray.count; i++) {
                UIButton *btn = self.buttonsArray[i];
                [btn setFrame:CGRectMake(x + btnWidth * i, 0, btnWidth, btnH)];
                if (i == 1 || i == self.buttonsArray.count - 1) {
                    UIImageView *line = [[UIImageView alloc] init];
                    [line setFrame:CGRectMake(x + btnWidth * i, 0, 1, btnH)];
                    [line setBackgroundColor:self.lineColor];
                    [self.bottomButtonView addSubview:line];
                    x += 1;
                }
            }
            y += btnH;
        } else if (self.style == ZFAlertControllerStyleActionSheet) {
            // ver
            btnH = 50;
            BOOL haveOtherElement = NO;
            if (y > 0) {
                haveOtherElement = YES;
                y += (self.buttonsSpace * .5);
            }
            float btnWidth = ZF_SCREEN_WIDTH;
            float tempy = y;
            float btnY = 0;
            for (int i = 0; i < self.buttonsArray.count; i++) {
                UIButton *btn = self.buttonsArray[i];
                ZFAlertAction *action = self.actionCallbacks[@(btn.tag)];
                [btn setFrame:CGRectMake(0, btnY + action.verticalSpaceMargin, btnWidth, btnH)];
                
                if (i != self.buttonsArray.count) {
                    UIImageView *line = [[UIImageView alloc] init];
                    [line setFrame:CGRectMake(action.horizontalSpaceMargin, btnY, ZF_SCREEN_WIDTH - action.horizontalSpaceMargin * 2, action.verticalSpaceMargin)];
                    [line setBackgroundColor:action.separatoColor];
                    [self.bottomButtonView addSubview:line];
                    btnY += action.verticalSpaceMargin;
                }
                btnY += btnH;
            }
            y += btnY;
            [self.bottomButtonView setFrame:CGRectMake(0, tempy, ZF_SCREEN_WIDTH, btnY)];
        }
        
    } else {
        y += NOMAL_CONTENT_MARGIN * 2;
    }
    if (self.style == ZFAlertControllerStyleAlert) {
        if (y < self.minAlertSize.height) y = self.minAlertSize.height;
        float width = MAX(self.minAlertSize.width, NOMAL_ALERT_WIDTH);
        [self.contentView setFrame:CGRectMake(0, 0, width, y)];
        [self.contentView setCenter:self.view.center];
    } else if (self.style == ZFAlertControllerStyleActionSheet) {
        CGFloat contentY = self.view.frame.size.height - y;
        if (isIPhoneXSeries()) {
            if (@available(iOS 11.0, *)) {
                float safeMargin = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
                contentY -= safeMargin;
                if (self.actionSheetIgnoreXSeriesBottomInset) {
                    y += safeMargin;
                }
            }
        }
        [self.contentView setFrame:CGRectMake(0, contentY, ZF_SCREEN_WIDTH, y)];
    }
    [self.contentImageView setFrame:self.contentView.bounds];
    
    [self.customViewSet enumerateObjectsUsingBlock:^(UIView  *_Nonnull obj, BOOL * _Nonnull stop) {
        zf_CustomViewConfig config = self.customViewConfigs[[NSString stringWithFormat:@"%p", obj]];
        if (config) config(self.contentView, obj);
    }];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:self.roundingCorners cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
    self.maskLayer.path = maskPath.CGPath;
    self.maskLayer.frame = self.contentView.bounds;
    
}

- (void)buttonClicked:(UIButton *)button {
    ZFAlertAction *action = self.actionCallbacks[@(button.tag)];
    if (action.action) {
        action.action();
    }
    [self.view endEditing:YES];
    [self.actionCallbacks removeAllObjects];
    [self.actionsArray removeAllObjects];
    [self.textFiledArray removeAllObjects];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)changeTextFieldText:(UITextField *)tf {
    if (tf.markedTextRange == nil) {
        zf_TextFieldTextChanged callback = self.textFiledCallbacks[@(tf.tag)];
        if (callback) callback(tf.text, tf);
    }
}
- (void)dealloc {
//    NSLog(@"%s", __func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardMinY = CGRectGetMinY(frame);
    CGFloat alertMaxY = CGRectGetMaxY(self.contentView.frame);
    CGFloat margin = NOMAL_KEYBOARD_SPACE_MARGIN;
    CGFloat diff = keyboardMinY - alertMaxY;
    if (diff < NOMAL_KEYBOARD_JUDGE_MARGIN) {
        CGPoint center = self.view.center;
        center.y -= (margin - diff);
        [UIView animateWithDuration:.3 animations:^{
            [self.contentView setCenter:center];
        }];
    }
    
}
- (void)keyboardWillBeHiden:(NSNotification *)notification {
    [UIView animateWithDuration:.3 animations:^{
        [self.contentView setCenter:self.view.center];
    }];
}

- (void)addAction:(ZFAlertAction *)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    {
        button.tag = arc4random() % 10000 + 200000;
        [button setTitle:action.titleText forState:UIControlStateNormal];
        [button setTitleColor:action.titleColor forState:UIControlStateNormal];
        button.titleLabel.font = action.titleFont;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomButtonView addSubview:button];
    }
    [self.actionsArray addObject:action];
    [self.buttonsArray addObject:button];
    self.actionCallbacks[@(button.tag)] = action;

}

- (UITextField *)addTextFiledWithText:(NSString *)text placeholder:(NSString *)placeholder textFieldTextChangedCallback:(zf_TextFieldTextChanged)textFieldTextChangedCallback {
    
    NSAssert(self.style == ZFAlertControllerStyleAlert, @"TextField only support ZFAlertControllerStyleAlert");
    
    UITextField *tf = [[UITextField alloc] init];
    {
        tf.text = text;
        tf.placeholder = placeholder;
        tf.textColor = ZFALERT_BLACKCLOLR;
        tf.layer.borderWidth = 0.5;
        [tf addTarget:self action:@selector(changeTextFieldText:) forControlEvents:UIControlEventEditingChanged];
        tf.clearButtonMode = UITextFieldViewModeAlways;
        CGRect frame = CGRectMake(0, 0, 10, 20);
        [tf setLeftView:[[UIView alloc] initWithFrame:frame]];
        [tf setLeftViewMode:UITextFieldViewModeAlways];
        tf.layer.cornerRadius = 3;
        tf.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:243/255.0 alpha:1.0].CGColor;
        tf.tag = arc4random() % 10000 + 300000;
    }
    [self.contentView addSubview:tf];
    [self.textFiledArray addObject:tf];
    if (textFieldTextChangedCallback) {
        self.textFiledCallbacks[@(tf.tag)] = textFieldTextChangedCallback;
    }
    return tf;
}

- (UIView *)addCustomView:(zf_CustomView)view config:(zf_CustomViewConfig)config {
    UIView *customView = view();
    if (!customView) return nil;
    [self.view addSubview:customView];
    if (config) self.customViewConfigs[[self keyWithView:customView]] = config;
    [self.customViewSet addObject:customView];
    return customView;
}

- (void)addCustomButton:(zf_CustomButton)view buttonAction:(zf_CustomButtonAction)action config:(zf_CustomViewConfig)config {
    UIButton *customButton = (UIButton *)[self addCustomView:view config:config];
    [customButton addTarget:self action:@selector(customButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.customButtonActions[[self keyWithView:customButton]] = action;
}

- (NSArray<UITextField *> *)textFields {
    return _textFiledArray.copy;
}

- (NSArray<ZFAlertAction *> *)actions {
    return _actionsArray.copy;
}

- (void)setContentBackgroundColor:(UIColor *)backgroundColor {
    _contentBackgroundColor = backgroundColor;
    [self.contentView setBackgroundColor:_contentBackgroundColor];
}
- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    self.titleLabel.font = _titleFont;
    _titleHeight = [self caclulateHeightWithString:_titleText font:_titleFont];
}
- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.titleLabel.textColor = _titleColor;
}
- (void)setMessageFont:(UIFont *)messageFont {
    _messageFont = messageFont;
    self.messageLabel.font = messageFont;
    _messageHeight = [self caclulateHeightWithString:_messageText font:_messageFont];
    
}
- (void)setMessageColor:(UIColor *)messageColor {
    _messageColor = messageColor;
    self.messageLabel.textColor = _messageColor;
}

- (void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    _titleLabel.text = _titleText;
    _titleHeight = [self caclulateHeightWithString:_titleText font:_titleFont];
}
- (void)setTitle:(NSString *)title {
    _titleText = title;
    _titleLabel.text = _titleText;
    _titleHeight = [self caclulateHeightWithString:_titleText font:_titleFont];
}
- (void)setMessageText:(NSString *)messageText {
    _messageText = messageText;
    _messageLabel.text = messageText;
    _messageHeight = [self caclulateHeightWithString:_messageText font:_messageFont];
}
- (void)setBackgroudColor:(UIColor *)backgroudColor {
    _backgroudColor = backgroudColor;
    [self.view setBackgroundColor:_backgroudColor];
}
- (void)setContentBackgroundImage:(UIImage *)contentBackgroundImage {
    _contentBackgroundImage = contentBackgroundImage;
    self.contentImageView.image = contentBackgroundImage;
}
- (float)caclulateHeightWithString:(NSString *)string font:(UIFont *)font {
    CGFloat w = NOMAL_ALERT_WIDTH - NOMAL_CONTENT_MARGIN * 2;
    if (self.style == ZFAlertControllerStyleActionSheet) w = ZF_SCREEN_WIDTH - NOMAL_CONTENT_MARGIN * 2;
    CGSize maxTitleSize = CGSizeMake(w, MAXFLOAT);
    float stringHeight = [string boundingRectWithSize:maxTitleSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil].size.height;
    return ceilf(stringHeight);
}
- (NSString *)keyWithView:(UIView *)view {
    return [NSString stringWithFormat:@"%p", view];
}

- (void)blackClicked {
    if (self.blankClickDismiss) [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)customButtonClicked:(UIButton *)button {
    zf_CustomButtonAction action = self.customButtonActions[[self keyWithView:button]];
    if (action) action(self);
}
- (void)setTitleAlignment:(NSTextAlignment)titleAlignment {
    _titleAlignment = titleAlignment;
    self.titleLabel.textAlignment = _titleAlignment;
}
- (void)setMessageAlignment:(NSTextAlignment)messageAlignment {
    _messageAlignment = messageAlignment;
    self.messageLabel.textAlignment = _messageAlignment;
}
@end
