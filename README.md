
 <p align="center" >
   <img src="https://raw.githubusercontent.com/ICU-Coders/IconLib/master/icon.jpg" alt="ICU-Coders" title="ICU-Coders">
 </p>
 
![MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat)
 [![Build Status](https://travis-ci.org/FranLucky/ZFAlertController.svg?branch=master)](https://travis-ci.org/FranLucky/ZFAlertController)
 ![podversion](https://img.shields.io/cocoapods/v/ZFAlertController.svg)
 [![Platform](https://img.shields.io/cocoapods/p/ZFAlertController.svg?style=flat)](http://cocoadocs.org/docsets/ZFAlertController)
 
 `ZFAlertController` is a Highly customizable AlertController for iOS.
 Choose `ZFAlertController` for your next project, or migrate over your existing projects—you'll be happy you did!
 

## Adding `ZFAlertController` to your project
### CocoaPods
[CocoaPods](http://cocoapods.org) is the recommended way to add `ZFAlertController` to your project.
Specify it in your Podfile:
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'ZFAlertController', '~> 1.0.4'
end
```
Then, run the following command:
```
pod install --repo-update
```
### Source files
Alternatively you can directly add the `ZFAlertController.h` and `ZFAlertController.m` source files to your project.
1. Download the [latest code version](https://github.com/ICU-Coders/ZFAlertController/archive/master.zip) or add the repository as a git submodule to your git-tracked project.
2. Open your project in Xcode, then drag and drop `ZFAlertController.h` and `ZFAlertController.m` onto your project (use the "Product Navigator view"). Make sure to select Copy items when asked if you extracted the code archive outside of your project.
3. Include `ZFAlertController` wherever you need it with `#import "ZFAlertController.h"`.

##  Usage
Equal with UIAlertController
#### Make a nomal alert
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

#### Add textfield, and this will auto adjust keyboard

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

#### Make a action sheet
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


### How custom it is
![custom](https://raw.githubusercontent.com/ICU-Coders/IconLib/master/AlertController/custom.jpg)
#### Add a custom view, imageView,label and so on
```
[alertVC addCustomView:^UIView * _Nonnull{
    UIView *customView = [[UIView alloc] init];
    [customView setBackgroundColor:[UIColor greenColor]];
    return customView;
} config:^(UIView * _Nonnull contentView, UIView * _Nonnull customView) {
    [customView setFrame:CGRectMake(contentView.frame.origin.x + 40, contentView.frame.origin.y - 40, contentView.frame.size.width - 40 * 2, 30)];
}];
```
#### And add a custom button 

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

And more see `sample` in project.  
If there any mistake, tell me.  
If you feel comfortable, maybe you can take a star🌟  
Thank you for your time.  

        
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
