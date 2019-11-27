
 <p align="center" >
   <img src="https://raw.githubusercontent.com/ICU-Coders/IconLib/master/icon.jpg" alt="ICU-Coders" title="ICU-Coders">
 </p>
 
![MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat)
 [![Build Status](https://travis-ci.org/FranLucky/ZFAlertController.svg?branch=master)](https://travis-ci.org/FranLucky/ZFAlertController)
 ![podversion](https://img.shields.io/cocoapods/v/ZFAlertController.svg)
 [![Platform](https://img.shields.io/cocoapods/p/ZFAlertController.svg?style=flat)](http://cocoadocs.org/docsets/ZFAlertController)
 
 `ZFAlertController` 是一款使用方便高度自定义的iOS弹窗控件
 

## 添加 `ZFAlertController` 到您的项目
### CocoaPods
[CocoaPods](http://cocoapods.org) is the recommended way to add `ZFAlertController` to your project.
在您的PodFile中添加
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

target 'TargetName' do
pod 'ZFAlertController', '~> 1.0.6'
end
```
运行:
```
pod install --repo-update
```
### Source files
直接拖拽 `ZFAlertController.h` 和 `ZFAlertController.m` 到您的项目
1. Download the [latest code version](https://github.com/ICU-Coders/ZFAlertController/archive/master.zip) or add the repository as a git submodule to your git-tracked project.
2. Open your project in Xcode, then drag and drop `ZFAlertController.h` and `ZFAlertController.m` onto your project (use the "Product Navigator view"). Make sure to select Copy items when asked if you extracted the code archive outside of your project.
3. Include `ZFAlertController` wherever you need it with `#import "ZFAlertController.h"`.

##  Usage
使用方法完全和 UIAlertController 相同
#### 创建一个普通弹窗
![alert](https://raw.githubusercontent.com/ICU-Coders/IconLib/master/AlertController/alert.jpg)
```
ZFAlertController *alertVC = [ZFAlertController alertWithTitle:@"ZFAlertController" message:@"alertWithTitle:message:style:" style:ZFAlertControllerStyleAlert];

ZFAlertAction *ok = [ZFAlertAction actionWithTitle:@"ok" action:^{
}];
ZFAlertAction *cancel = [ZFAlertAction actionWithTitle:@"cancel" action:^{
}];

[alertVC addAction:ok];
[alertVC addAction:cancel];

[self presentViewController:alertVC animated:YES completion:nil];
```

#### 创建一个带有TextFiled的弹窗（自动适应键盘）

![textFiled](https://raw.githubusercontent.com/ICU-Coders/IconLib/master/AlertController/textFiled.jpg)
```
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
```

#### Action Sheet
![actionSheet](https://raw.githubusercontent.com/ICU-Coders/IconLib/master/AlertController/actionSheet.jpg)
```
ZFAlertController *alertVC = [ZFAlertController alertWithTitle:@"ActionSheet" message:@"alertWithTitle:message:style:" style:ZFAlertControllerStyleActionSheet];

ZFAlertAction *ok = [ZFAlertAction actionWithTitle:@"Ok" action:^{
}];
ZFAlertAction *cancel = [ZFAlertAction actionWithTitle:@"Cancel" action:^{
}];

[alertVC addAction:ok];
[alertVC addAction:cancel];

[self presentViewController:alertVC animated:YES completion:nil];
```


### 自定义
![custom](https://raw.githubusercontent.com/ICU-Coders/IconLib/master/AlertController/custom.jpg)
#### 添加各种自定义View
```
[alertVC addCustomView:^UIView * _Nonnull{
    UIView *customView = [[UIView alloc] init];
    [customView setBackgroundColor:[UIColor greenColor]];
    return customView;
} config:^(UIView * _Nonnull contentView, UIView * _Nonnull customView) {
    [customView setFrame:CGRectMake(contentView.frame.origin.x + 40, contentView.frame.origin.y - 40, contentView.frame.size.width - 40 * 2, 30)];
}];
```
#### 添加按钮

```
[alertVC addCustomButton:^UIButton * _Nonnull{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    return button;
} buttonAction:^(UIViewController * _Nonnull alert) {
    [alert dismissViewControllerAnimated:YES completion:nil];
} config:^(UIView * _Nonnull contentView, UIView * _Nonnull customView) {
    [customView setFrame:CGRectMake(CGRectGetMaxX(contentView.frame) - 44, contentView.frame.origin.y - 44 - 10, 44, 44)];
}];
```

更多可以查看`sample`
> 如果有任何问题或建议，请告诉我.  
> 如果觉得不错，给个赞吧🌟  
> 谢谢 

        
## MIT License

Copyright (c) 2019 Pokeey

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
