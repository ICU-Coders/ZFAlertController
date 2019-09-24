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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [button setFrame:CGRectMake(100, 100, 44, 44)];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClicked:(UIButton *)button {
    ZFAlertViewController *alertVC = [ZFAlertViewController alertWithTitle:@"标题？" message:@"副标题" style:ZFAlertViewControllerOptionMessage_Input];
    
    alertVC.textChangeCallback = ^(NSString * _Nonnull text, UITextField * _Nonnull textField) {
        NSLog(@"text:%@", text);
    };
    
    ZFAlertViewAction *ok = [ZFAlertViewAction actionWithTitle:@"确定" action:^{
        NSLog(@"ok");
    }];
    ok.titleColor = ZFALERT_OK_CLOLR;
    ZFAlertViewAction *cancel = [ZFAlertViewAction actionWithTitle:@"取消" action:^{
        NSLog(@"cancel");
    }];
    
    [alertVC addAction:cancel];
    [alertVC addAction:ok];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
