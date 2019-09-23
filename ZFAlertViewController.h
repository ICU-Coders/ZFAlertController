//
//  ZFAlertViewController.h
//  ZFAlertViewController
//
//  Created by 张帆 on 2019/9/23.
//  Copyright © 2019 张帆. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#define ZFALERT_BLACKCLOLR [UIColor colorWithRed:19/255.0 green:19/255.0 blue:54/255.0 alpha:1]
#define ZFALERT_OK_CLOLR [UIColor colorWithRed:0 green:180/255.0 blue:175/255.0 alpha:1]
#define ZFALERT_LINE_COLOR [UIColor colorWithRed:240/255.0 green:240/255.0 blue:243/255.0 alpha:1.0]

@interface ZFAlertViewAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title action:(void (^ _Nullable)(void))action;

@property(nonatomic, copy) NSString *titleText;
@property (nonatomic, strong) UIFont *titleFont; // default [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
@property (nonatomic, strong) UIColor *titleColor; // default  red:19/255.0 green:19/255.0 blue:54/255.0 alpha:1

@end

typedef NS_OPTIONS(NSUInteger, ZFAlertViewControllerStyleOption) {
    ZFAlertViewControllerOptionTitle = 1 << 0, //   1
    ZFAlertViewControllerOptionMessage = 1 << 1,// 10
    ZFAlertViewControllerOptionInput = 1 << 2, // 100
    ZFAlertViewControllerOptionTitle_Message = ZFAlertViewControllerOptionTitle | ZFAlertViewControllerOptionMessage,
    ZFAlertViewControllerOptionTitle_Input = ZFAlertViewControllerOptionTitle | ZFAlertViewControllerOptionInput,
    ZFAlertViewControllerOptionTitle_Message_Input = ZFAlertViewControllerOptionTitle | ZFAlertViewControllerOptionMessage | ZFAlertViewControllerOptionInput,
};

@interface ZFAlertViewController : UIViewController

@property (nonatomic, strong) UIColor *backgroundColor; // default [UIColor whiteColor]
@property (nonatomic, strong) UIColor *titleColor; // default red:19/255.0 green:19/255.0 blue:54/255.0 alpha:1
@property (nonatomic, strong) UIColor *messageColor; // default red:19/255.0 green:19/255.0 blue:54/255.0 alpha:1

@property(nonatomic, copy) NSString *titleText;
@property(nonatomic, copy) NSString *messageText;
@property (nonatomic, strong) UIFont *titleFont; // default [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
@property (nonatomic, strong) UIFont *messageFont; // default [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];

@property(nonatomic, copy) NSString *textFiledPlaceholder;

@property (nullable, nonatomic, strong) UITextField * textFiled;

@property(nonatomic, assign) float cornerRadius; // default 5

+ (instancetype)alertWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message style:(ZFAlertViewControllerStyleOption )style;

- (void)addAction:(ZFAlertViewAction *)action; // max 3


@end

NS_ASSUME_NONNULL_END
