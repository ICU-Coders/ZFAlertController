//
//  ViewController.m
//  ZFAlertViewController
//
//  Created by 张帆 on 2019/9/23.
//  Copyright © 2019 张帆. All rights reserved.
//

#import "ViewController.h"
#import "ZFAlertViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor yellowColor]];
    
}
- (IBAction)buttclick:(UIButton *)sender {
    
    int tag = (int)sender.tag;
    ZFAlertViewControllerStyleOption option;
    switch (tag) {
        case 0:
            option = ZFAlertViewControllerOptionTitle;
            break;
        case 1:
            option = ZFAlertViewControllerOptionMessage;
            break;
        case 2:
            option = ZFAlertViewControllerOptionInput;
            break;
        case 3:
            option = ZFAlertViewControllerOptionTitle_Message;
            break;
        case 4:
            option = ZFAlertViewControllerOptionTitle_Input;
            break;
        case 5:
            option = ZFAlertViewControllerOptionTitle_Message_Input;
            break;
        default:
            option = ZFAlertViewControllerOptionTitle_Message_Input;
            break;
    }
    
    ZFAlertViewController *alertVC = [ZFAlertViewController alertWithTitle:@"标题" message:@"描述" style:option];
    alertVC.textChangeCallback = ^(NSString * _Nonnull text, UITextField * _Nonnull textField) {
        NSLog(@"text:%@", text);
    };
    
    ZFAlertViewAction *ok = [ZFAlertViewAction actionWithTitle:@"确定" action:^{
        NSLog(@"ok");
        [self testFunc];
    }];
    ok.titleColor = ZFALERT_OK_CLOLR;
    ZFAlertViewAction *cancel = [ZFAlertViewAction actionWithTitle:@"取消" action:^{
        NSLog(@"cancel");
    }];
    
    [alertVC addAction:cancel];
    [alertVC addAction:ok];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}


- (void)testFunc {
    NSLog(@"%s",  __func__);
}
@end
