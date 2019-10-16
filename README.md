 ZFAlertController is a Highly customizable AlertController for iOS.
 Choose ZFAlertController for your next project, or migrate over your existing projects—you'll be happy you did!

### Installation with CocoaPods
##### Podfile
To integrate ZFAlertController into your Xcode project using CocoaPods, specify it in your Podfile:
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'ZFAlertController', '~> 0.1.1'
end
```
Then, run the following command:
```
pod install --repo-update
```

###  Usage
All the usages are equal with UIAlertController
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
