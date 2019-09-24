//
//  ZFAlertViewController.m
//  ZFAlertViewController
//
//  Created by 张帆 on 2019/9/23.
//  Copyright © 2019 张帆. All rights reserved.
//

#import "ZFAlertViewController.h"


typedef void(^actionCallback)(void);

@interface ZFAlertViewAction ()
@property(nonatomic, copy) actionCallback action;
@end

@implementation ZFAlertViewAction

+ (instancetype)actionWithTitle:(NSString *)title action:(void (^)(void))action {
    return [[ZFAlertViewAction alloc] initWithTitle:title action:action];
}

- (instancetype)initWithTitle:(NSString *)title action:(void (^)(void))action
{
    self = [super init];
    if (self) {
        self.action = action;
        self.titleText = title;
        self.titleColor = ZFALERT_BLACKCLOLR;
        self.titleFont = [UIFont systemFontOfSize:16];
    }
    return self;
}

@end

static int NOMAL_ALERT_WIDTH = 270;
static int NOMAL_CONTENT_MARGIN = 12;

@interface ZFAlertViewController ()

@property(nonatomic, assign) ZFAlertViewControllerStyleOption styleOption;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIView *lineHorView;
@property (nonatomic, strong) UIView *lineVecView;
@property (nonatomic, strong) UIView *bottomButtonView;
@property (nonatomic, strong) NSArray *buttonsArray;

@property(nonatomic, assign) float titleHeight;
@property(nonatomic, assign) float messageHeight;

@property (nonatomic, strong) NSMutableArray *actionArray;
@end

@implementation ZFAlertViewController

+ (instancetype)alertWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message style:(ZFAlertViewControllerStyleOption)style {
    return [[ZFAlertViewController alloc] initWithTitle:title message:message style:style];
}

- (instancetype)initWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message style:(ZFAlertViewControllerStyleOption)styleOption
{
    self = [super init];
    if (self) {
        
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        self.textFiledPlaceholder = @"  请输入...";
        _backgroundColor = [UIColor whiteColor];
        _titleColor = ZFALERT_BLACKCLOLR;
        _messageColor = ZFALERT_BLACKCLOLR;
        _cornerRadius = 5;
        _titleFont = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        _messageFont = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
        
        if (title) {
            _titleText = title;
            _titleHeight = [self caclulateHeightWithString:_titleText font:_titleFont];
        }
        if (message) {
            _messageText = message;
            _messageHeight = [self caclulateHeightWithString:_messageText font:_messageFont];
        }
        
        _styleOption = styleOption;
        self.actionArray = [NSMutableArray arrayWithCapacity:10];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
        
        
        self.contentView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            [view setBackgroundColor:self.backgroundColor];
            view.layer.cornerRadius = self.cornerRadius;
            view;
        });
        if (_styleOption & ZFAlertViewControllerOptionTitle) {
            self.titleLabel = ({
                UILabel *label = [[UILabel alloc] init];
                label.font = self.titleFont;
                label.textColor = self.titleColor;
                label.numberOfLines = 3;
                label.text = self.titleText;
                label.textAlignment = NSTextAlignmentCenter;
                label;
            });
            [self.contentView addSubview:self.titleLabel];
        }
        
        if (_styleOption & ZFAlertViewControllerOptionMessage) {
            self.messageLabel = ({
                UILabel *label = [[UILabel alloc] init];
                label.font = self.messageFont;
                label.textColor = self.messageColor;
                label.numberOfLines = 3;
                label.text = self.messageText;
                label.textAlignment = NSTextAlignmentCenter;
                label;
            });
            [self.contentView addSubview:self.messageLabel];
        }
        
        if (_styleOption & ZFAlertViewControllerOptionInput) {
            self.textFiled = ({
                UITextField *tf = [[UITextField alloc] init];
                tf.placeholder = self.textFiledPlaceholder;
                tf.textColor = ZFALERT_BLACKCLOLR;
                tf.layer.borderWidth = 0.5;
                [tf addTarget:self action:@selector(changeTextFieldText:) forControlEvents:UIControlEventEditingChanged];
                tf.clearButtonMode = UITextFieldViewModeAlways;
                [tf setValue:[NSNumber numberWithInt:NOMAL_CONTENT_MARGIN] forKey:@"paddingLeft"];
                [tf setValue:[NSNumber numberWithInt:NOMAL_CONTENT_MARGIN] forKey:@"paddingRight"];
                tf.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:243/255.0 alpha:1.0].CGColor;
                tf;
            });
            [self.contentView addSubview:self.textFiled];
        }
        
        self.lineHorView = ({
            UIView *view = [[UIView alloc] init];
            [view setBackgroundColor:ZFALERT_LINE_COLOR];
            view;
        });
        [self.contentView addSubview:self.lineHorView];
        
        
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
    
    NSAssert(self.actionArray.count > 0, @"actions need more than one");
    NSAssert(self.actionArray.count < 3, @"actions need less than three");
    
    [self.view setBackgroundColor:[UIColor colorWithWhite:0 alpha:.6]];
    
    [self.view addSubview:self.contentView];
    
    int count = self.actionArray.count > 3 ? 3 : (int)self.actionArray.count;
    NSMutableArray *btnsArray = [NSMutableArray arrayWithCapacity:3];
    for (int i = 0; i < count; i++) {
        ZFAlertViewAction *action = self.actionArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 89383+i;
        [button setTitle:action.titleText forState:UIControlStateNormal];
        [button setTitleColor:action.titleColor forState:UIControlStateNormal];
        button.titleLabel.font = action.titleFont;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomButtonView addSubview:button];
        [btnsArray addObject:button];
    }
    self.buttonsArray = btnsArray.copy;
}

- (void)buttonClicked:(UIButton *)button {
    int index = (int)button.tag - 89383;
    ZFAlertViewAction *action = self.actionArray[index];
    action.action();
    [self.view endEditing:YES];
    [self.actionArray removeAllObjects];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)changeTextFieldText:(UITextField *)tf {
    if (tf.markedTextRange == nil) {
        if (self.textChangeCallback) {
            self.textChangeCallback(tf.text, tf);
        }
    }
    
}
- (void)dealloc {
    NSLog(@"%s", __func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillShow:(NSNotification *)notification {
    CGPoint center = self.view.center;
    center.y -= 50;
    [UIView animateWithDuration:.3 animations:^{
        [self.contentView setCenter:center];
    }];
}
- (void)keyboardWillBeHiden:(NSNotification *)notification {
    [UIView animateWithDuration:.3 animations:^{
        [self.contentView setCenter:self.view.center];
    }];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    float y = NOMAL_CONTENT_MARGIN;
    float x = NOMAL_CONTENT_MARGIN;
    float contentWidth = NOMAL_ALERT_WIDTH - NOMAL_CONTENT_MARGIN * 2;
    if (_styleOption & ZFAlertViewControllerOptionTitle) {
        y += NOMAL_CONTENT_MARGIN;
        [self.titleLabel setFrame:CGRectMake(x, y, contentWidth, self.titleHeight)];
        y += self.titleHeight;
    }
    if (_styleOption & ZFAlertViewControllerOptionMessage) {
        y += NOMAL_CONTENT_MARGIN;
        [self.messageLabel setFrame:CGRectMake(x, y, contentWidth, self.messageHeight)];
        y += self.messageHeight;
    }
    if (_styleOption & ZFAlertViewControllerOptionInput) {
        y += NOMAL_CONTENT_MARGIN;
        [self.textFiled setFrame:CGRectMake(20, y, contentWidth - 20, 35)];
        y += 30;
    }
    y += NOMAL_CONTENT_MARGIN * 2;
    [self.lineHorView setFrame:CGRectMake(0, y, NOMAL_ALERT_WIDTH, 1)];
    y += 1;
    
    {
        [self.bottomButtonView setFrame:CGRectMake(0, y, NOMAL_ALERT_WIDTH, 44)];
        
        for (UIView *view in self.bottomButtonView.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                [view removeFromSuperview];
            }
        }
        
        x = 0;
        float btnH = 44;
        
        float btnWidth = NOMAL_ALERT_WIDTH / self.buttonsArray.count;
        for (int i = 0; i < self.buttonsArray.count; i++) {
            UIButton *btn = self.buttonsArray[i];
            [btn setFrame:CGRectMake(x + btnWidth * i, 0, btnWidth, btnH)];
            if (i == 1 || i == self.buttonsArray.count - 1) {
                UIImageView *line = [[UIImageView alloc] init];
                [line setFrame:CGRectMake(x + btnWidth * i, 0, 1, btnH)];
                [line setBackgroundColor:ZFALERT_LINE_COLOR];
                [self.bottomButtonView addSubview:line];
                x += 1;
            }
        }
        y += btnH;
    }
    [self.contentView setFrame:CGRectMake(0, 0, NOMAL_ALERT_WIDTH, y)];
    [self.contentView setCenter:self.view.center];
    
}

- (void)addAction:(ZFAlertViewAction *)action {
    [self.actionArray addObject:action];
    
}

- (void)setTextFiledPlaceholder:(NSString *)textFiledPlaceholder {
    _textFiledPlaceholder = textFiledPlaceholder;
    NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:_textFiledPlaceholder attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}];
    _textFiled.attributedPlaceholder = placeholder;
}
-(void)setTextFiledAttributedPlaceholder:(NSAttributedString *)textFiledAttributedPlaceholder {
    _textFiledAttributedPlaceholder = textFiledAttributedPlaceholder;
    _textFiled.attributedPlaceholder = _textFiledAttributedPlaceholder;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    [self.contentView setBackgroundColor:_backgroundColor];
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

- (void)setMessageText:(NSString *)messageText {
    _messageText = messageText;
    _messageLabel.text = messageText;
    _messageHeight = [self caclulateHeightWithString:_messageText font:_messageFont];
}
- (float)caclulateHeightWithString:(NSString *)string font:(UIFont *)font {
    CGSize maxTitleSize = CGSizeMake(NOMAL_ALERT_WIDTH - NOMAL_CONTENT_MARGIN * 2, MAXFLOAT);
    float stringHeight = [string boundingRectWithSize:maxTitleSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil].size.height;
    return ceilf(stringHeight);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.textFiled) {
        [self.textFiled resignFirstResponder];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
