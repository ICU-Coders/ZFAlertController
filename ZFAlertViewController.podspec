#
#  Be sure to run `pod spec lint ZFAlertViewController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#


Pod::Spec.new do |s|
  s.name         = "ZFAlertViewController"
  s.version      = "0.0.6"
  s.summary      = "No short description of ZFAlertViewController."
  s.homepage     = "https://github.com/FranLucky/ZFAlertViewController"
  s.license      = { :type => "MIT"}
  s.author       = { "Pokeey" => "zhangfan8080@gmail.com" }
  s.platform     = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/FranLucky/ZFAlertViewController.git", :tag => "#{s.version}" }
  s.source_files  = "ZFAlertViewController/*.{h,m}"
  s.frameworks = "Foundation","UIKit"
  s.requires_arc = true
end
