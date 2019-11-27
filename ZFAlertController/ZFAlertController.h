//
//  ZFAlertController.h
//  ZFAlertController
//
//  Created by Pokey on 2019/9/23.
//  Copyright © 2019 Pokey. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#define ZFALERT_BLACKCLOLR [UIColor colorWithRed:19/255.0 green:19/255.0 blue:54/255.0 alpha:1]
#define ZFALERT_OK_CLOLR [UIColor colorWithRed:0 green:180/255.0 blue:175/255.0 alpha:1]
#define ZFALERT_LINE_COLOR [UIColor colorWithRed:240/255.0 green:240/255.0 blue:243/255.0 alpha:1.0]

typedef void(^zf_TextFieldTextChanged)(NSString *text, UITextField *textField);
typedef void(^zf_CustomViewConfig)(UIView *contentView, UIView *customView);
typedef UIView *_Nonnull(^zf_CustomView)(void);
typedef UIButton *_Nonnull(^zf_CustomButton)(void);
typedef void(^zf_CustomButtonAction)(UIViewController *alert);

@interface ZFAlertAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title action:(void (^ _Nullable)(void))action;

@property(nonatomic, copy) NSString *titleText;
/**
 * Default [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
 */
@property (nonatomic, strong) UIFont *titleFont;
/**
 *  Default  red:19/255.0 green:19/255.0 blue:54/255.0 alpha:1
 */
@property (nonatomic, strong) UIColor *titleColor;
/**
 * Only actionSheet. Default .5f
 * Can make a custom line between two buttons
 */
@property(nonatomic, assign) CGFloat verticalSpaceMargin;
/**
 * Left & right edge inset
 * Only actionSheet. Default 10.0f
 */
@property(nonatomic, assign) CGFloat horizontalSpaceMargin;
/**
 * Only actionSheet, under action. Default ZFALERT_LINE_COLOR
 */
@property (nonatomic, strong) UIColor *separatoColor;

@end

typedef NS_ENUM(NSUInteger, ZFAlertControllerStyle) {
    ZFAlertControllerStyleAlert,
    ZFAlertControllerStyleActionSheet,
};

@interface ZFAlertController : UIViewController


+ (instancetype)alertWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message style:(ZFAlertControllerStyle)style;

- (void)addAction:(ZFAlertAction *)action;

- (UITextField *)addTextFiledWithText:(NSString *)text placeholder:(NSString *)placeholder textFieldTextChangedCallback:(zf_TextFieldTextChanged)textFieldTextChangedCallback;
/**
 * highest priority
 * config base on contentView, config() will take on viewWillLayoutSubviews
 * view will add by [self.view addSubview:view]
 */
- (UIView *)addCustomView:(zf_CustomView)view config:(zf_CustomViewConfig)config;
- (void)addCustomButton:(zf_CustomButton)view buttonAction:(zf_CustomButtonAction)action config:(zf_CustomViewConfig)config;

- (void)changeMessageText:(NSString *)text attr:(NSDictionary *)attr;

/**
 * Background cover color,default [UIColor colorWithWhite:0 alpha:.6]
 */
@property (nonatomic, strong) UIColor *backgroudColor;
/**
 * Alert background color,default [UIColor whiteColor]
 */
@property (nonatomic, strong) UIColor *contentBackgroundColor;
/**
 * Level > contentBackgroundColor
*/
@property (nonatomic, strong) UIImage *contentBackgroundImage;
/**
 * Default red:19/255.0 green:19/255.0 blue:54/255.0 alpha:1
 */
@property (nonatomic, strong) UIColor *titleColor;
/**
 * Default red:19/255.0 green:19/255.0 blue:54/255.0 alpha:1
 */
@property (nonatomic, strong) UIColor *messageColor;

@property(nonatomic, copy) NSString *titleText;
@property(nonatomic, copy) NSString *messageText;

/**
 * Nomal CGSizeZero ZFAlertControllerStyleAlert
 * height = 0 means auto
 * width min = NOMAL_ALERT_WIDTH
 */

@property(nonatomic, assign) CGSize minAlertSize;

/**
 * Title top margin. Default 10(init) + 10.
 * title.length > 0
 */
@property(nonatomic, assign) float titleSpace;
/**
 * Nomal NSTextAlignmentCenter
 */
@property(nonatomic, assign) NSTextAlignment titleAlignment;
/**
 *  Message title margin. Default 10.
 */
@property(nonatomic, assign) float messageSpace;
/**
* Nomal NSTextAlignmentCenter
*/
@property(nonatomic, assign) NSTextAlignment messageAlignment;

/**
 *  textField message margin. Default 10.
 */
@property(nonatomic, assign) float textFieldSpace;
/**
 * Button message margin
 * Default alert 15, sheet half.
 *
 */
@property(nonatomic, assign) float buttonsSpace;
/**
 * Title label font
 * Default [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
 */
@property (nonatomic, strong) UIFont *titleFont;
/**
 * Default [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
 */
@property (nonatomic, strong) UIFont *messageFont;
/**
 * Default 5
 */
@property(nonatomic, assign) float cornerRadius;
/**
 * Default UIRectCornerAllCorners
 */
@property(nonatomic, assign) UIRectCorner roundingCorners;
/**
 * Buttons line custom color
 * Nomal ZFALERT_LINE_COLOR
 * init
 */
@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, strong, readonly) NSArray<ZFAlertAction *> *actions;

@property (nullable, nonatomic, readonly) NSArray<UITextField *> *textFields;

/**
 * Default YES. Will never calculate safeArea bottom.
 */
@property(nonatomic, assign) BOOL actionSheetIgnoreXSeriesBottomInset;

@property (nonatomic, strong, readonly) UIView *contentView;

/**
 * default NO
 * if yes, alert will dismiss when clicked the black
 */
@property(nonatomic, assign) BOOL blankClickDismiss;


@end

NS_ASSUME_NONNULL_END
