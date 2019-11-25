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
    ZFAlertController *alertVC = [ZFAlertController alertWithTitle:@"ZFAlertController" message:@"alertWithTitle:message:style:\nalertWithTitle:message:style:\nalertWithTitle:message:style:\nalertWithTitle:message:style:" style:ZFAlertControllerStyleAlert];
    ZFAlertAction *ok = [ZFAlertAction actionWithTitle:@"Ok" action:^{
        NSLog(@"ok");
        [self testFunc];
    }];
    ZFAlertAction *cancel = [ZFAlertAction actionWithTitle:@"Cancel" action:^{
        NSLog(@"cancel");
    }];
    alertVC.blankClickDismiss = YES;
    if ([sender.titleLabel.text isEqualToString:@"Custom"]) {
//        alertVC.backgroudColor = [UIColor redColor];
//        alertVC.contentBackgroundColor = [UIColor grayColor];
        alertVC.contentBackgroundImage = [UIImage imageNamed:@"background"];
        alertVC.messageSpace = 20;
        alertVC.messageColor = ok.titleColor = alertVC.lineColor = alertVC.titleColor = cancel.titleColor = [UIColor whiteColor];
        [alertVC addCustomView:^UIView * _Nonnull{
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            return imageView;
        } config:^(UIView * _Nonnull contentView, UIView * _Nonnull customView) {
            [customView setFrame:CGRectMake(contentView.frame.origin.x, contentView.frame.origin.y - 53, contentView.frame.size.width, 53)];
        }];
        
        
        [alertVC addCustomButton:^UIButton * _Nonnull{
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
            return button;
        } buttonAction:^(UIViewController * _Nonnull alert) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        } config:^(UIView * _Nonnull contentView, UIView * _Nonnull customView) {
            [customView setFrame:CGRectMake(CGRectGetMaxX(contentView.frame) - 44, contentView.frame.origin.y - 44 - 10, 44, 44)];
        }];
        
    }
    [alertVC addAction:ok];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
}



- (IBAction)textFields:(id)sender {
    
    ZFAlertController *alertVC = [ZFAlertController alertWithTitle:@"Alert" message:@"alertWithTitle:message:style:" style:ZFAlertControllerStyleAlert];
    [alertVC addTextFiledWithText:@"" placeholder:@"Input..." textFieldTextChangedCallback:^(NSString * _Nonnull text, UITextField * _Nonnull textField) {
        NSLog(@"text1:%@", text);
    }];
    ZFAlertAction *ok = [ZFAlertAction actionWithTitle:@"Ok" action:^{
        NSLog(@"ok");
        [self testFunc];
    }];
    [alertVC addAction:ok];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (IBAction)sheet:(id)sender {
    ZFAlertController *alertVC = [ZFAlertController alertWithTitle:@"ActionSheet" message:@"alertWithTitle:message:style:" style:ZFAlertControllerStyleActionSheet];
        
        ZFAlertAction *ok = [ZFAlertAction actionWithTitle:@"Ok" action:^{
            NSLog(@"ok");
            [self testFunc];
        }];
        ZFAlertAction *cancel = [ZFAlertAction actionWithTitle:@"Cancel" action:^{
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
