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

    ZFAlertController *alertVC = [ZFAlertController alertWithTitle:@"ZFAlertController" message:@"alertWithTitle:message:style:" style:ZFAlertControllerStyleAlert];
    ZFAlertAction *ok = [ZFAlertAction actionWithTitle:@"ok" action:^{
        NSLog(@"ok");
        [self testFunc];
    }];
    ZFAlertAction *cancel = [ZFAlertAction actionWithTitle:@"cancel" action:^{
        NSLog(@"cancel");
    }];
    [alertVC addAction:ok];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
}


- (IBAction)textFields:(id)sender {
    ZFAlertController *alertVC = [ZFAlertController alertWithTitle:@"Alert" message:@"alertWithTitle:message:style:" style:ZFAlertControllerStyleAlert];
        [alertVC addTextFiledWithText:@"" placeholder:@"请输入..." textFieldTextChangedCallback:^(NSString * _Nonnull text, UITextField * _Nonnull textField) {
            NSLog(@"text1:%@", text);
        }];
        ZFAlertAction *ok = [ZFAlertAction actionWithTitle:@"ok" action:^{
            NSLog(@"ok");
            [self testFunc];
        }];
        [alertVC addAction:ok];
        [self presentViewController:alertVC animated:YES completion:nil];
}

- (IBAction)sheet:(id)sender {
    ZFAlertController *alertVC = [ZFAlertController alertWithTitle:@"ActionSheet" message:@"alertWithTitle:message:style:" style:ZFAlertControllerStyleActionSheet];
        
        ZFAlertAction *ok = [ZFAlertAction actionWithTitle:@"ok" action:^{
            NSLog(@"ok");
            [self testFunc];
        }];
        ZFAlertAction *cancel = [ZFAlertAction actionWithTitle:@"cancel" action:^{
            NSLog(@"cancel");
        }];
        {
            // Custom
            cancel.verticalSpaceMargin = 10;
            cancel.horizontalSpaceMargin = 0;
            cancel.titleColor = ZFALERT_OK_CLOLR;
            alertVC.actionSheetIgnoreXSeriesBottomInset = YES;
        }
        [alertVC addAction:ok];
        [alertVC addAction:cancel];
        [self presentViewController:alertVC animated:YES completion:nil];
}



- (void)testFunc {
    NSLog(@"%s",  __func__);
    
}
@end
