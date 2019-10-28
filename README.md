
 <p align="center" >
   <img src="https://github.com/FranLucky/IconLib/blob/master/icon.png?raw=true" alt="ZFAlertController" title="ZFAlertController">
 </p>
 
![MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat)
 [![Build Status](https://travis-ci.org/FranLucky/ZFAlertController.svg?branch=master)](https://travis-ci.org/FranLucky/ZFAlertController)
 ![podversion](https://img.shields.io/cocoapods/v/ZFAlertController.svg)
 [![Platform](https://img.shields.io/cocoapods/p/ZFAlertController.svg?style=flat)](http://cocoadocs.org/docsets/ZFAlertController)
 
 `ZFAlertController` is a Highly customizable AlertController for iOS.
 Choose `ZFAlertController` for your next project, or migrate over your existing projects—you'll be happy you did!
 
 | Alert      |   actionSheet | 
 | :-------: | :--------------: |
 |  ![alert](https://github.com/FranLucky/IconLib/blob/master/AlertController/alert.jpg)  |  ![actionSheet](https://github.com/FranLucky/IconLib/blob/master/AlertController/actionSheet.jpg) |
 | **Custom**      |  **TextFiled** | 
 | ![custom](https://github.com/FranLucky/IconLib/blob/master/AlertController/custom.jpg)  |  ![textFiled](https://github.com/FranLucky/IconLib/blob/master/AlertController/textFiled.jpg) |

### Installation with CocoaPods
##### Podfile
To integrate `ZFAlertController` into your Xcode project using CocoaPods, specify it in your Podfile:
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'ZFAlertController', '~> 1.0.2'
end
```
Then, run the following command:
```
pod install --repo-update
```

###  Usage
Equal with UIAlertController
#### ZFAlertControllerStyleAlert
```
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
```
#### ZFAlertControllerStyleActionSheet
```
ZFAlertController *alertVC = [ZFAlertController alertWithTitle:@"ActionSheet" message:@"alertWithTitle:message:style:" style:ZFAlertControllerStyleActionSheet];
```

#### MIT License

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
