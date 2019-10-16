//
//  ZFAlertController.h
//  ZFAlertController
//
//  Created by 张帆 on 2019/9/23.
//  Copyright © 2019 张帆. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#define ZFALERT_BLACKCLOLR [UIColor colorWithRed:19/255.0 green:19/255.0 blue:54/255.0 alpha:1]
#define ZFALERT_OK_CLOLR [UIColor colorWithRed:0 green:180/255.0 blue:175/255.0 alpha:1]
#define ZFALERT_LINE_COLOR [UIColor colorWithRed:240/255.0 green:240/255.0 blue:243/255.0 alpha:1.0]

typedef void(^zf_TextFieldTextChanged)(NSString *text, UITextField *textField);

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
 * Only actionSheet. Default ZFALERT_LINE_COLOR
 */
@property (nonatomic, strong) UIColor *separatoColor;

@end

typedef NS_ENUM(NSUInteger, ZFAlertControllerStyle) {
    ZFAlertControllerStyleAlert,
    ZFAlertControllerStyleActionSheet,
};

@interface ZFAlertController : UIViewController
/**
 * Background cover color,default [UIColor colorWithWhite:0 alpha:.6]
 */
@property (nonatomic, strong) UIColor *backgroudColor;
/**
 * Alert background color,default [UIColor whiteColor]
 */
@property (nonatomic, strong) UIColor *contentBackgroundColor;
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
 * Title top margin. Default 10.
 */
@property(nonatomic, assign) float titleSpace;
/**
 *  Message title margin. Default 10.
 */
@property(nonatomic, assign) float messageSpace;
/**
 *  textField message margin. Default 10.
 */
@property(nonatomic, assign) float textFieldSpace;
/**
 * Button message margin
 * Default alert 20, sheet half(10).
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

@property (nonatomic, strong, readonly) NSArray<ZFAlertAction *> *actions;

@property (nullable, nonatomic, readonly) NSArray<UITextField *> *textFields;

/**
 * Default YES. Will never calculate safeArea bottom.
 */
@property(nonatomic, assign) BOOL actionSheetIgnoreXSeriesBottomInset;

+ (instancetype)alertWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message style:(ZFAlertControllerStyle)style;

- (void)addAction:(ZFAlertAction *)action;

- (UITextField *)addTextFiledWithText:(NSString *)text placeholder:(NSString *)placeholder textFieldTextChangedCallback:(zf_TextFieldTextChanged)textFieldTextChangedCallback;


@end

NS_ASSUME_NONNULL_END
