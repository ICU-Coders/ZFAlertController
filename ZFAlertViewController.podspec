#
#  Be sure to run `pod spec lint ZFAlertViewController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "ZFAlertViewController"
  spec.version      = "0.0.2"
  spec.summary      = "No short description of ZFAlertViewController."
  spec.homepage     = "https://github.com/FranLucky/ZFAlertViewController"
  spec.license      = "MIT"
  spec.author       = { "Pokeey" => "zhangfan8080@gmail.com" }
  spec.platform     = :ios, "9.0"
  spec.ios.deployment_target = "9.0"
  spec.source       = { :git => "https://github.com/FranLucky/ZFAlertViewController.git", :tag => "#{spec.version}" }
  spec.source_files  = "ZFAlertViewController/Classes/*.{h,m}"
  spec.public_header_files = "ZFAlertViewController/Classes/*.h"
  spec.requires_arc = true

end
