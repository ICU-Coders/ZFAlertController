//
//  ViewController.m
//  ZFAlertViewController
//
//  Created by Pokey on 2019/9/23.
//  Copyright © 2019 Pokey. All rights reserved.
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
    ZFAlertController *alertVC = [ZFAlertController alertWithTitle:@"alertWithTitle" message:@"message" style:ZFAlertControllerStyleAlert];
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
        [alertVC changeMessageText:@"change" attr:@{NSFontAttributeName: [UIFont systemFontOfSize:20]}];
        alertVC.contentBackgroundImage = [UIImage imageNamed:@"background"];
        alertVC.messageSpace = 20;
        alertVC.messageColor = ok.titleColor = alertVC.lineColor = alertVC.titleColor = cancel.titleColor = [UIColor whiteColor];
        [alertVC addCustomView:^UIView * _Nonnull{
            UIView *customView = [[UIView alloc] init];
            [customView setBackgroundColor:[UIColor greenColor]];
            return customView;
        } config:^(UIView * _Nonnull contentView, UIView * _Nonnull customView) {
            [customView setFrame:CGRectMake(contentView.frame.origin.x + 40, contentView.frame.origin.y - 40, contentView.frame.size.width - 40 * 2, 30)];
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
        alertVC.minAlertSize = CGSizeMake(0, 166);
    }
//    [alertVC addAction:ok];
//    [alertVC addAction:cancel];
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
