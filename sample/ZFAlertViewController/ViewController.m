//
//  ViewController.m
//  ZFAlertViewController
//
//  Created by 张帆 on 2019/9/23.
//  Copyright © 2019 张帆. All rights reserved.
//

#import "ViewController.h"
#import "ZFAlertController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}

- (IBAction)buttclick:(UIButton *)sender {

    ZFAlertController *alertVC = [ZFAlertController alertWithTitle:@"" message:@"" style:ZFAlertControllerStyleActionSheet];
    
//    [alertVC addTextFiledWithText:@"" placeholder:@"请输入..." textFieldTextChangedCallback:^(NSString * _Nonnull text, UITextField * _Nonnull textField) {
//        NSLog(@"text1:%@", text);
//    }];
    ZFAlertAction *ok = [ZFAlertAction actionWithTitle:@"ok" action:^{
        NSLog(@"ok");
        [self testFunc];
    }];
    ZFAlertAction *cancel = [ZFAlertAction actionWithTitle:@"cancel" action:^{
        NSLog(@"cancel");
    }];
    cancel.verticalSpaceMargin = 10;
    cancel.horizontalSpaceMargin = 0;
    cancel.titleColor = ZFALERT_OK_CLOLR;
    [alertVC addAction:ok];
    [alertVC addAction:cancel];
    alertVC.actionSheetIgnoreXSeriesBottomInset = YES;
    [self presentViewController:alertVC animated:YES completion:nil];
}


- (void)testFunc {
    NSLog(@"%s",  __func__);
    
}
@end
